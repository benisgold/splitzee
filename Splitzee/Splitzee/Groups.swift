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

class Group {
    
    //var groupPicID: String?
    var groupID: String = ""
    var memberIDs : [String] = []
    var adminIDs : [String] = []
    var transactionIDs : [String] = []
    var requestIDs : [String] = []
    var total : Double = 0
    var name : String = ""
    var picURL: String = ""

    init(key:String, groupDict: [String: AnyObject])
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
    
    
    func getAllUsers() -> [User] {
        let ref = FIRDatabase.database().reference()
        var users : [User] = []
        for id in memberIDs {
            ref.child("Users").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let curr = User(key: id, userDict: snapshot.value as! [String : AnyObject])
                users.append(curr)
            }) { (error) in
                print(error.localizedDescription)
            }
        }
        return users
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
    
    func getTransactions() -> [Transaction] {
        let ref = FIRDatabase.database().reference()
        var transactions : [Transaction] = []
        for id in transactionIDs {
            ref.child("Transactions").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let curr = Transaction(key: id, transactionDict: snapshot.value as! [String : AnyObject])
                transactions.append(curr)
            }) { (error) in
                print(error.localizedDescription)
            }
        }
        return transactions
    }
    
    func getRequests() -> [Request] {
        let ref = FIRDatabase.database().reference()
        var requests : [Request] = []
        for id in requestIDs {
            ref.child("Requests").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let curr = Request(key: id, requestDict: snapshot.value as! [String : AnyObject])
                requests.append(curr)
            }) { (error) in
                print(error.localizedDescription)
            }
        }
        return requests
    }
        
}
