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
    var requestIDs: [String] = []
    var total: Double = 0
    var name: String = ""
    var picURL: String = ""
    
    var hashValue: Int {
        return self.groupID.hashValue
    }
    
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.groupID == rhs.groupID
    }
    
    init(key: String, groupDict: [String:AnyObject])
    {
        groupID = key
        
        if let name = groupDict["name"] as? String {
            self.name = name
        }
        
        if let imageURL = groupDict["picURL"] as? String {
            picURL = imageURL
        }
        
        if let member = groupDict["memberIDs"] as? [String]{
            memberIDs = member
        }
        
        if let admin = groupDict["adminIDs"] as? [String]{
            adminIDs = admin
        }
        
        if let transactions = groupDict["transactionIDs"] as? [String]{
            transactionIDs = transactions
        }
        
        if let requests = groupDict["requestIDs"] as? [String]{
            requestIDs = requests
        }
        
        if let totalMoney = groupDict["total"] as? Double{
            total = totalMoney
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
            ref.child("Users").child(id).observe(.value, with: { (snapshot) in
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
    
    func getTransactions(withBlock: @escaping (Transaction) -> Void) {
        let ref = FIRDatabase.database().reference()
        for id in transactionIDs {
            ref.child("Transactions").child(id).observe(.value, with: { (snapshot) in
                // Get user value
                let curr = Transaction(key: id, transactionDict: snapshot.value as! [String : AnyObject])
                withBlock(curr)
            })
        }
    }
}
