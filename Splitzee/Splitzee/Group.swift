//
//  Groups.swift
//  Splitzee
//
//  Created by Mohit Katyal on 11/10/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Group: Hashable, Equatable {
    
    //var groupPicID: String?
    var groupID: String = ""
    var memberIDs: [String] = []
    var adminIDs: [String] = []
    var transactionIDs: [String] = []
    var total: Double = 0
    var name: String = ""
    var picURL: String = ""
    var adminCode = ""
    var memberCode = ""
    
    var hashValue: Int {
        return self.groupID.hashValue
    }
    
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.groupID == rhs.groupID
    }
    
    init(key: String, groupDict: [String:AnyObject])
    {
        groupID = key
        
        if let name = groupDict[Constants.GroupFields.name] as? String {
            self.name = name
        }
        
        if let imageURL = groupDict[Constants.GroupFields.picURL] as? String {
            picURL = imageURL
        }
        
        if let member = groupDict[Constants.GroupFields.memberIDs] as? [String]{
            memberIDs = member
        }
        
        if let admin = groupDict[Constants.GroupFields.adminIDs] as? [String]{
            adminIDs = admin
        }
        
        if let transactions = groupDict[Constants.GroupFields.transactionIDs] as? [String]{
            transactionIDs = transactions
        }
        
        if let totalMoney = groupDict[Constants.GroupFields.total] as? Double{
            total = totalMoney
        }
        
        if let groupAdminCode = groupDict[Constants.GroupFields.adminCode] as? String {
            adminCode = groupAdminCode
        }
        
        if let groupMemberCode = groupDict[Constants.GroupFields.memberCode] as? String {
            memberCode = groupMemberCode
        }
    }
    
    init(name: String, total: Double?, picURL: String) {
        self.name = name
        
        if let balance = total {
            self.total = balance
        } else {
            self.total = 0.0
        }
        
        self.picURL = picURL
    }
    
    
    func pollForUsers(withBlock: @escaping (User) -> Void) {
        let ref = FIRDatabase.database().reference()
        for id in memberIDs {
            ref.child(Constants.DataNames.User).child(id).observe(.value, with: { (snapshot) in
                // Get user value
                let curr = User(key: id, userDict: snapshot.value as! [String:AnyObject])
                withBlock(curr)
            })
        }
    }
    
    func getGroupPic(withBlock: @escaping (UIImage) -> Void) {
        let storageRef = FIRStorage.storage().reference()
        let imageRef = storageRef.child(picURL)
        
        imageRef.data(withMaxSize: 1 * 1024 * 1024, completion: { (data, error) -> Void in
            if (error != nil) {
                print("An error occured: \(error)")
            } else {
                let image = UIImage(data: data!)
                withBlock(image!)
            }
        })
    }
    
    func getTransactions(withBlock: @escaping (Transaction) -> Void)  {

        let ref = FIRDatabase.database().reference()
        for id in transactionIDs  {
            ref.child(Constants.DataNames.Transaction).child(id).observeSingleEvent(of: .value, with:  { (snapshot) in
                //  Get user value
                print(snapshot.key)
                let curr = Transaction(key: id, transactionDict: snapshot.value as! [String:AnyObject])
                withBlock(curr)
            })
        }
    }
    
    func getTotal(withBlock: @escaping (Double) -> Void) {
        let rootRef = FIRDatabase.database().reference()
        let groupRef = rootRef.child(Constants.DataNames.Group)
        groupRef.child(groupID).child(Constants.GroupFields.total).observe(.value, with: { (snapshot) in
            // Get total value
            if let total = snapshot.value as? Double {
                withBlock(total)
            }
        })
        
    }
    
    func addToTotal(amount: Double) {
        total += amount
        let rootRef = FIRDatabase.database().reference()
        let groupRef = rootRef.child(Constants.DataNames.Group)
        groupRef.child(groupID).child(Constants.GroupFields.total).setValue(total)
    }
}
