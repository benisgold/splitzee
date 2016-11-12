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
    var groupIDs: [String]?
    var groupAdminIDs: [String]?
    var groupMemberAmounts: [String : Double]?
    var requestIDs: [String] = []
    var uid: String?
    
    
    //Initiating variables
    
    init(key:String, currentUserDict: [String: AnyObject])
    {
        uid = key
        
        
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
    
    func getProfPic(withBlock: @escaping (UIImage) -> Void) {
        let storageRef = FIRStorage.storage().reference()
        let imageRef = storageRef.child(profPicURL!)
        
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
        for id in transactionIDs! {
            ref.child("Transactions").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let curr = Transaction(key: id, transactionDict: snapshot.value as! [String : AnyObject])
                withBlock(curr)
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    func getRequests(withBlock: @escaping (Request) -> Void) {
        let ref = FIRDatabase.database().reference()
        for id in requestIDs {
            ref.child("Requests").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let curr = Request(key: id, requestDict: snapshot.value as! [String : AnyObject])
                withBlock(curr)
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    func getGroups(withBlock: @escaping (Group) -> Void) {
        let ref = FIRDatabase.database().reference()
        for id in groupIDs! {
            ref.child("Groups").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let curr = Group(key: id, groupDict: snapshot.value as! [String: AnyObject])
                withBlock(curr)
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    func getName(withBlock: (User) -> Void) {
        
    }
    
    func sendNewRequest(amount: Double, memberID: String, groupID: String) {
        
    }
    
    func sendNewTransaction(amount: Double, memberID: String, groupID: String) {
        
    }
    
}
