//
//  Groups.swift
//  Splitzee
//
//  Created by Mohit Katyal on 11/10/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import Foundation
import UIKit

class Group {
    
    //var groupPicID: String?
    var groupID: String?
    var memberIDs : [String]?
    var adminIDs : [String]?
    var transactionIDs : [String]?
    var total : Double?
    var name : String?
    var pic: String?
    

    init(key:String, userDict: [String: AnyObject])
    {
        let groupID = key
        
        
        if let member = userDict["memberIDs"] as? [String]{
            memberIDs = member
        }
        else
        {
            memberIDs = ["error"]
        }
        
        if let admin = userDict["adminIDs"] as? [String]{
            adminIDs = admin
        }
        else
        {
            adminIDs = ["error"]
        }
        
        if let transactions = userDict["transactionIDs"] as? [String]{
            transactionIDs = transactions
        }
        else
        {
            transactionIDs = ["error"]
        }
        
        if let totalMoney = userDict["total"] as? Double{
            total = totalMoney
        }
        else
        {
            total = 0
        }
    }
    
    init(name: String, total: Double?, pic: String) {
        self.name = name
        
        if let amnt = total {
            self.total = amnt
        } else {
            self.total = 0.0
        }
        
        self.pic = pic
    }
    
    func getAllUsers() {
        
    }
    
    func getGroupPic() {
        
    }
    
    func getTransactions() {
        
    }
    
    func getRequests() {
        
    }
        
}
