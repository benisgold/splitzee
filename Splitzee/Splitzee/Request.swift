//
//  Request.swift
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

class Request{
    
    var requestID : String?
    var memberID: String?
    var groupToMember: Bool?
    var groupID: String?
    var amount: Double?
    
    init(key:String, requestDict: [String: AnyObject])
    {
        let transactionID = key
        
        
        if let group = requestDict["groupID"] as? String{
            groupID = group
        }
        else
        {
            groupID = "error"
        }
        
        if let sendToMember = requestDict["groupToMember"] as? Bool{
            groupToMember = sendToMember
        }
        else
        {
            groupToMember = false
        }
        
        if let member = requestDict["memberID"] as? String{
            memberID = member
        }
        else
        {
            memberID = "error"
        }
        
        if let amountSent = requestDict["amount"] as? Double{
            amount = amountSent
        }
        else
        {
            amount = 0
        }
        
        
    }
    
    
    init(amount: Double, memberID: String, groupID: String, groupToMember: Bool)
    {
        self.amount = amount
        self.memberID = memberID
        self.groupID = groupID
        self.groupToMember = groupToMember
    }
    
    
    
    
    func deleteRequest(){
        
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
    
    
    func approveRequest(){
    
    }
    
    
    
    func rejectRequest(){
        
    }
    
}
