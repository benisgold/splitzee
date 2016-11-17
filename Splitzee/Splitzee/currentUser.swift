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
    var name: String = ""
    var profPicURL: String = ""
    var email: String = ""
    var transactionIDs: [String] = []
    var groupIDs: [String] = []
    var groupAdminIDs: [String] = []
    var groupMemberAmounts: [String : Double] = [:]
    var requestIDs: [String] = []
    var uid: String = ""
    
    //Initiating variables
    
    init(key:String, currentUserDict: [String: AnyObject])
    {
        uid = key
        
        
        if let username = currentUserDict["name"] as? String{
            name = username
        }
        
        if let pic = currentUserDict["profPicURL"] as? String{
            profPicURL = pic
        }
        
        if let mail = currentUserDict["email"] as? String{
            email = mail
        }
        
        if let transaction = currentUserDict["transactionIDs"] as? [String]{
            transactionIDs = transaction
        }
        
        if let admin = currentUserDict["groupAdminIDs"] as? [String]{
            groupAdminIDs = admin
        }
        
        if let member = currentUserDict["groupMemberAmounts"] as? [String:Double]{
            groupMemberAmounts = member
        }
        
    }
    
    //optional
    func logout() {
        
    }
    
    //optional
    func signIn() {
        
    }
    
    
    //Gets the profile picture for your own profile page
    func getProfPic(withBlock: @escaping (UIImage) -> Void) {
        let storageRef = FIRStorage.storage().reference()
        let imageRef = storageRef.child(profPicURL)
        
        imageRef.data(withMaxSize: 1 * 1024 * 1024, completion: { (data, error) -> Void in
            if (error != nil) {
                print("An error occured: \(error)")
            } else {
                let image = UIImage(data: data!)
                withBlock(image!)
            }
        })
    }
    
    
    //Gets all the transactions for the history
    func getTransactions(withBlock: @escaping (Transaction) -> Void) {
        let ref = FIRDatabase.database().reference()
        for id in transactionIDs {
            ref.child("Transactions").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let curr = Transaction(key: id, transactionDict: snapshot.value as! [String : AnyObject])
                withBlock(curr)
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    //Gets requests to be approved or not
//    func getRequests(withBlock: @escaping (Request) -> Void) {
//        let ref = FIRDatabase.database().reference()
//        for id in requestIDs {
//            ref.child("Requests").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
//                // Get user value
//                let curr = Request(key: id, requestDict: snapshot.value as! [String : AnyObject])
//                withBlock(curr)
//            }) { (error) in
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    //Gets all the groups for the sidebar
    func getGroups(withBlock: @escaping (Group) -> Void) {
        let ref = FIRDatabase.database().reference()
        for id in groupIDs {
            ref.child("Groups").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let curr = Group(key: id, groupDict: snapshot.value as! [String: AnyObject])
                withBlock(curr)
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    //Gets the name for your own profile page
    func getName(withBlock: @escaping (User) -> Void) {
        let ref = FIRDatabase.database().reference()
        ref.child("User").child(uid).observe(.value, with: { snapshot -> Void in
            // Get user name value
            if snapshot.exists(){
                if let userDict = snapshot.value as? [String: AnyObject] {
                    let user = User(key: snapshot.key, userDict: userDict)
                    withBlock(user)
                }
            }
        })
    }
    
//    func sendNewRequest(amount: Double, memberID: String, groupID: String, groupToMember: Bool) {
//    
//        let ref = FIRDatabase.database().reference()
//        let key = ref.child("Requests").childByAutoId().key
//        ref.child("Requests/\(key)").setValue(["Amount": amount, "Member": memberID, "Group": groupID, "toMember": groupToMember])
//      
//        
//        
//    }
    

    func sendNewTransaction(amount: Double, memberID: String, groupID: String, groupToMember: Bool) {
        
        let ref = FIRDatabase.database().reference()
        let key = ref.child("Transactions").childByAutoId().key
        ref.child("Transactions/\(key)").setValue(["Amount": amount, "Member": memberID, "Group": groupID, "toMember": groupToMember])
        
    }
    
}
