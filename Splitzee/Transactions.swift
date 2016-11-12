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

class Transaction{
    
    var transactionID: String?
    var groupToMember: Bool?
    var memberID: String?
    var groupID: String?
    var amount: Double?
    
    
    init(key: String, transactionDict: [String: AnyObject])
    {
        transactionID = key
        
        
        if let group = transactionDict["groupID"] as? String{
            groupID = group
        }
        else
        {
            groupID = "error"
        }
        
        if let sendToMember = transactionDict["groupToMember"] as? Bool{
            groupToMember = sendToMember
        }
        else
        {
            groupToMember = false
        }
        
        if let member = transactionDict["memberID"] as? String{
            memberID = member
        }
        else
        {
            memberID = "error"
        }
        
        if let amountSent = transactionDict["amount"] as? Double{
            amount = amountSent
        }
        else
        {
            amount = 0
        }
        
        //Update Money for Group
        
        let ref = FIRDatabase.database().reference()
        
        
        ref.child("Transactions/\(transactionID)").setValue()

      
    }
    
    
    init(amount: Double, memberID: String, groupID: String, groupToMember: Bool)
    {
        self.amount = amount
        self.memberID = memberID
        self.groupID = groupID
        self.groupToMember = groupToMember
    }
    
    
    func deleteTransactions(){
        let ref = FIRDatabase.database().reference()
        ref.child("Transactions/\(transactionID)").removeValue()
    }
    
    
    func getUser(withBlock: @escaping (User) -> Void ){
        let ref = FIRDatabase.database().reference()
        ref.child("Members/\(memberID!)").observe(.value, with: { snapshot -> Void in
            // Get user value
            if snapshot.exists(){
                if let userDict = snapshot.value as? [String: AnyObject]{
                    let user = User(key: snapshot.key, userDict: userDict)
                    withBlock(user)
                }
            }
        })
        
    }

    
}
