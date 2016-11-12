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
    var toMember: Bool?
    var memberID: String?
    var groupID: String?
    var amount: Double?
    
    
    init(key:String, transactionDict: [String: AnyObject])
    {
        transactionID = key
        
        
        if let group = transactionDict["groupID"] as? String{
            groupID = group
        }
        else
        {
            groupID = "error"
        }
        
        if let sendToMember = transactionDict["toMember"] as? Bool{
            toMember = sendToMember
        }
        else
        {
            toMember = false
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
        
      
    }
    
}
