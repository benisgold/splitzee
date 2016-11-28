//
//  Transactions.swift
//  Splitzee
//
//  Created by Mohit Katyal on 11/10/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class Transaction {
    
    var transactionID: String = ""
    var groupToMember: Bool?
    var memberID: String = ""
    var groupID: String = ""
    var amount: Double?
    var isApproved: Bool?
    var description: String = ""
    
    
    init(key: String, transactionDict: [String: AnyObject]) {
        transactionID = key
        
        
        if let group = transactionDict[Constants.TransactionFields.groupID] as? String{
            groupID = group
        }
        
        if let sendToMember = transactionDict[Constants.TransactionFields.groupToMember] as? Bool{
            groupToMember = sendToMember
        }
        
        if let member = transactionDict[Constants.TransactionFields.memberID] as? String{
            memberID = member
        }
        
        if let amountSent = transactionDict[Constants.TransactionFields.amount] as? Double{
            amount = amountSent
        }
        
        if let approved = transactionDict[Constants.TransactionFields.isApproved] as? Bool{
            isApproved = approved
        }
        
        if let descriptionText = transactionDict["description"] as? String{
            description = descriptionText
        }
    }
    
    
    init(amount: Double, memberID: String, groupID: String, groupToMember: Bool, description: String) {
        self.amount = amount
        self.memberID = memberID
        self.groupID = groupID
        self.groupToMember = groupToMember
        self.description = description
        
    }
    
    
    func deleteTransaction() {
        let ref = FIRDatabase.database().reference()
        ref.child("Transactions/\(transactionID)").removeValue()
    }
    
    // Gets the userID of the member the group is trying to send the money to
    func getUser(withBlock: @escaping (User) -> Void ){
        let ref = FIRDatabase.database().reference()
        ref.child("Members/\(memberID)").observe(.value, with: { snapshot -> Void in
            // Get user value
            if snapshot.exists(){
                if let userDict = snapshot.value as? [String: AnyObject]{
                    let user = User(key: snapshot.key, userDict: userDict)
                    withBlock(user)
                }
            }
        })
    }
    
    // Gets the userIDs of all members within a group (used for Admin transactions)
    func getMembersArray(withBlock: @escaping (User) -> Void ){
        var membersArray = [String]()
        for member in membersArray {
            let ref = FIRDatabase.database().reference()
            ref.child("Members/\(memberID)").observe(.value, with: { snapshot -> Void in
                // Get user value
                if snapshot.exists(){
                    if let userDict = snapshot.value as? [String: AnyObject]{
                        let user = User(key: snapshot.key, userDict: userDict)
                        withBlock(user)
                    }
                }
            })
            membersArray.append(member)
        }
    }
    
    
    
    
    // Gets current group so that one can update the money of the group
    func getGroup(withBlock: @escaping (Group) -> Void) {
        let ref = FIRDatabase.database().reference()
        ref.child("Group/\(groupID)").observe(.value, with: { snapshot -> Void in
            // Get user value
            if snapshot.exists(){
                if let groupDict = snapshot.value as? [String: AnyObject]{
                    let group = Group(key: snapshot.key, groupDict: groupDict)
                    withBlock(group)
                }
            }
        })
        
    }
    
    /*
     func getTransactions(withBlock: @escaping (Transaction) -> Void) {
     let ref = FIRDatabase.database().reference()
     for id in transactionID {
     ref.child("Transactions").child(id).observe(.value, with: { (snapshot) in
     let curr = Transaction(key: id, transactionDict: snapshot.value as! [String : AnyObject])
     withBlock(curr)
     })
     }
     }
     */
    
    
    
    func rejectTransaction() {
        deleteTransaction()
    }
    
    /* In the feed for our pending requests, it will now look for transactions
     that have the approved value of "false". Once it is set to true, the history
     feed will now include this request*/
    
    func approveTransaction() {
        isApproved = true
        
        // update money
        getGroup(withBlock: { (group) -> Void in
            var total = group.total
            if let amnt = self.amount {
                total += amnt
            }
            let ref = FIRDatabase.database().reference()
            ref.child("Groups/\(group.groupID)").setValue(total)
            
        })
        
    }
}
