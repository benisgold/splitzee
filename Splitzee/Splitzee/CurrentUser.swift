//
//    Users.swift
//    Splitzee
//
//    Created by Mohit Katyal on 11/10/16.
//    Copyright © 2016 Mohit Katyal. All rights reserved.
//
import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class CurrentUser {
    
    
    // User Variables
    var name: String = ""
    var profPicURL: String = ""
    var email: String = ""
    var transactionIDs: [String] = []
    var groupIDs: [String] = []
    var groupAdminIDs: [String] = []
    var uid: String = ""
    var currentGroupID: String = ""
    var dbRef: FIRDatabaseReference!
    
    // Initiating variables
    
    init(key: String, currentUserDict: [String: AnyObject]) {
        uid = key
        
        
        if let username = currentUserDict["name"] as? String  {
            name = username
        }
        
        if let pic = currentUserDict["profPicURL"] as? String {
            profPicURL = pic
        }
        
        if let mail = currentUserDict["email"] as? String {
            email = mail
        }
        
        if let transaction = currentUserDict["transactionIDs"] as? [String] {
            transactionIDs = transaction
        }
        
        if let admin = currentUserDict["groupAdminIDs"] as? [String] {
            groupAdminIDs = admin
        }
        
        if let group = currentUserDict["groupIDs"] as? [String] {
            groupIDs = group
        }
        
    }
    
    init(key: String, name: String, profPicURL: String, email: String, transactionIDs: [String], groupIDs: [String], groupAdminIDs: [String], currentGroupID: String) {
        uid = key
        self.name = name
        self.profPicURL = profPicURL
        self.email = email
        self.transactionIDs = transactionIDs
        self.groupIDs = groupIDs
        self.groupAdminIDs = groupAdminIDs
        self.currentGroupID = currentGroupID
    }
    
    init() {
        dbRef = FIRDatabase.database().reference()
        uid = (FIRAuth.auth()?.currentUser?.uid)!
    }
    
    // optional
    func logout()  {
        
    }
    
    // optional
    func signIn()  {
        
    }
    
    func setData() {
        dbRef.child("User").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.name = (value?["name"] as? String)!
            self.profPicURL = (value?["profPicURL"] as? String)!
            self.email = (value?["email"] as? String)!
            self.transactionIDs = (value?["transactionIDs"] as? [String])!
            self.groupIDs = (value?["groupIDs"] as? [String])!
            self.groupAdminIDs = (value?["groupAdminIDs"] as? [String])!
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    // Gets the profile picture for your own profile page
    func getProfPic(withBlock: @escaping (UIImage) -> Void)  {
        setData()
        let storageRef = FIRStorage.storage().reference()
        let imageRef = storageRef.child(profPicURL)
        
        imageRef.data(withMaxSize: 1 * 1024 * 1024, completion:  { (data, error) -> Void in
            if (error != nil)  {
                print("An error occured: \(error)")
            } else  {
                let image = UIImage(data: data!)
                withBlock(image!)
            }
        })
    }
    
    
    // Gets all the transactions for the history
    func getTransactions(withBlock: @escaping (Transaction) -> Void)  {
        setData()
        let ref = FIRDatabase.database().reference()
        for id in transactionIDs  {
            ref.child("Transactions").child(id).observeSingleEvent(of: .value, with:  { (snapshot) in
                //  Get user value
                let curr = Transaction(key: id, transactionDict: snapshot.value as! [String:AnyObject])
                withBlock(curr)
            })
        }
    }
    
    // Gets all the groups for the sidebar
    func getGroup(withBlock: @escaping (Group) -> Void)  {
        setData()
        let ref = FIRDatabase.database().reference()
        for id in groupIDs  {
            ref.child("Groups").child(id).observeSingleEvent(of: .value, with:  { (snapshot) in
                //  Get user value
                let curr = Group(key: id, groupDict: snapshot.value as! [String: AnyObject])
                withBlock(curr)
            })
        }
    }
    
    // Gets the name for your own profile page
    func getName(withBlock: @escaping (User) -> Void)  {
        setData()
        let ref = FIRDatabase.database().reference()
        ref.child("User").child(uid).observe(.value, with:  { snapshot -> Void in
            //  Get user name value
            if snapshot.exists() {
                if let userDict = snapshot.value as? [String: AnyObject]  {
                    let user = User(key: snapshot.key, userDict: userDict)
                    withBlock(user)
                }
            }
        })
    }
    
    func sendNewTransaction(amount: Double, memberID: String, groupID: String, groupToMember: Bool)  {
        let ref = FIRDatabase.database().reference()
        let key = ref.child("Transactions").childByAutoId().key
        ref.child("Transactions/\(key)").setValue(["Amount": amount, "Member": memberID, "Group": groupID, "toMember": groupToMember])
        
    }
    
}
