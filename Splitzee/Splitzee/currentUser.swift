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

class CurrentUser{
    
    
    //User Variables
    var name: String?
    var profPicURL: String?
    var email: String?
    var transactionIDs: [String]?
    var groupAdminIDs: [String]?
    var groupMemberAmounts: [String : Double]?
    var uid: String?
    
    
    //Initiating variables
    
    init(key:String, currentUserDict: [String: AnyObject])
    {
        let uid = key
        
        
        if let username = currentUserDict["name"] as? String{
            name = username
        }
        else
        {
            name = "error"
        }
        
        if let pic = currentUserDict["profPicURL"] as? String{
            profPicURL = pic
        }
        else
        {
            profPicURL = "error"
        }
        
        if let mail = currentUserDict["email"] as? String{
            email = mail
        }
        else
        {
            email = "error"
        }
        
        if let transaction = currentUserDict["transactionIDs"] as? [String]{
            transactionIDs = transaction
        }
        else
        {
            transactionIDs = ["error"]
        }
        
        if let admin = currentUserDict["groupAdminIDs"] as? [String]{
            groupAdminIDs = admin
        }
        else
        {
            groupAdminIDs = ["error"]
        }
        
        if let member = currentUserDict["groupMemberAmounts"] as? [String:Double]{
            groupMemberAmounts = member
        }
        else
        {
            groupMemberAmounts = ["error": 0]
        }
        
        
    }
    
    //optional
    func logout() {
        
    }
    
    //optional
    func signIn() {
        
    }
    
    func getProfPic() {
    
    }
    
    func getTransactions() {
        
    }
    
    func getRequests() {
        
    }
    
    func getGroups() {
        
    }
    
    func getName() {
        
    }
    
    func sendNewRequest(amount: Double, memberID: String, groupID: String) {
        
    }
    
    func sendNewTransaction(amount: Double, memberID: String, groupID: String) {
        
    }
    
}
