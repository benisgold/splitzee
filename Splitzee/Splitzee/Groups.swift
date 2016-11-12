//
//  Groups.swift
//  Splitzee
//
//  Created by Mohit Katyal on 11/10/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import Foundation

class Group {
    
    //var groupPicID: String?
    var groupID: String?
    var memberIDs : [String]?
    var adminIDs : [String]?
    var transactionIDs : [String]?
    var total : Double?
    
    

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
    
    
}
