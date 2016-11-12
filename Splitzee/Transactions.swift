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

class Transactions{
    
    var transactionID: String?
    var toMember: Bool?
    var memberID: String?
    var groupID: String?
    var amount: Double?
    
    
    init(key:String, userDict: [String: AnyObject])
    {
        let transactionID = key
        
        
        if let group = userDict["groupID"] as? String{
            groupID = group
        }
        else
        {
            groupID = "error"
        }
        
        if let sendToMember = userDict["toMember"] as? Bool{
            toMember = sendToMember
        }
        else
        {
            toMember = false
        }
        
        if let member = userDict["memberID"] as? String{
            memberID = member
        }
        else
        {
            memberID = "error"
        }
        
        if let amountSent = userDict["amount"] as? Double{
            amount = amountSent
        }
        else
        {
            amount = 0
        }
        
      
    }
    
}
