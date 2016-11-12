//
//  Users.swift
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

class currentUser{
    
    
    //User Variables
    var name: String?
    var profPicURL: String?
    var email: String?
    var transactionIDs: [String]?
    var groupAdminIDs: [String]?
    var groupMemberAmounts: [String : Double]?
    var uid: String?
    
    
    //Initiating variables
    
    init(key:String, userDict: [String: AnyObject])
    {
        let uid = key
        
        
        if let username = userDict["name"] as? String{
            name = username
        }
        else
        {
            name = "error"
        }
        
        if let pic = userDict["profPicURL"] as? String{
            profPicURL = pic
        }
        else
        {
            profPicURL = "error"
        }
        
        if let mail = userDict["email"] as? String{
            email = mail
        }
        else
        {
            email = "error"
        }
        
        if let transaction = userDict["transactionIDs"] as? [String]{
            transactionIDs = transaction
        }
        else
        {
            transactionIDs = ["error"]
        }
        
        if let admin = userDict["groupAdminIDs"] as? [String]{
            groupAdminIDs = admin
        }
        else
        {
            groupAdminIDs = ["error"]
        }
        
        if let member = userDict["groupMemberAmounts"] as? [String:Double]{
            groupMemberAmounts = member
        }
        else
        {
            groupMemberAmounts = ["error": 0]
        }
        
        
    }
    
    
    
    
    
    
    
}
