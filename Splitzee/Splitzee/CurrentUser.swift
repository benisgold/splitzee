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
    var dbRef: FIRDatabaseReference!
    var currentGroupID: String = ""
    
    // Initiating variables
    
    init() {
        uid = FIRAuth.auth()!.currentUser!.uid
    }
    
    convenience init(key: String, currentUserDict: [String: AnyObject]) {
        self.init()
        dbRef = FIRDatabase.database().reference()
        
        uid = key
        
        
        if let username = currentUserDict[Constants.UserFields.name] as? String  {
            name = username
        }
        
        if let pic = currentUserDict[Constants.UserFields.profPicURL] as? String {
            profPicURL = pic
        }
        
        if let mail = currentUserDict[Constants.UserFields.email] as? String {
            email = mail
        }
        
        if let transaction = currentUserDict[Constants.UserFields.transactionIDs] as? [String] {
            transactionIDs = transaction
        }
        
        if let admin = currentUserDict[Constants.UserFields.groupAdminIDs] as? [String] {
            groupAdminIDs = admin
        }
        
        if let group = currentUserDict[Constants.UserFields.groupIDs] as? [String] {
            groupIDs = group
        }
        
    }
    
    convenience init(key: String, name: String, profPicURL: String, email: String, transactionIDs: [String], groupIDs: [String], groupAdminIDs: [String], currentGroupID: String) {
        self.init()
        dbRef = FIRDatabase.database().reference()
        uid = key
        self.name = name
        self.profPicURL = profPicURL
        self.email = email
        self.transactionIDs = transactionIDs
        self.groupIDs = groupIDs
        self.groupAdminIDs = groupAdminIDs
    }
    
    
    
    // Gets the profile picture for your own profile page
    func getProfPic(withBlock: @escaping (UIImage) -> Void)  {
        //        setData()
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
    func getTransactions(group: Group, withBlock: @escaping (Transaction) -> Void)  {
        //        setData()
        let ref = FIRDatabase.database().reference()
        for id in transactionIDs  {
            ref.child(Constants.DataNames.Transaction).child(id).observeSingleEvent(of: .value, with:  { (snapshot) in
                //  Get user value
                print(snapshot.value ?? snapshot.key)
                let trans = Transaction(key: id, transactionDict: snapshot.value as! [String:AnyObject])
                if trans.groupID == group.groupID {
                    withBlock(trans)
                }
                
            })
        }
    }
    
    
    
    // Gets all the groups for the sidebar
    func getGroups(withBlock: @escaping (Group) -> Void)  {
        //        setData()
        let ref = FIRDatabase.database().reference()
        for id in groupIDs  {
            ref.child(Constants.DataNames.Group).child(id).observeSingleEvent(of: .value, with:  { (snapshot) in
                //  Get user value
                let curr = Group(key: id, groupDict: snapshot.value as! [String: AnyObject])
                withBlock(curr)
            })
        }
    }
    
    // Gets all admin groups for the sidebar
    func getAdminGroups(withBlock: @escaping (Group) -> Void) {
        //        setData()
        let ref = FIRDatabase.database().reference()
        for id in groupAdminIDs {
            ref.child(Constants.DataNames.Group).child(id).observeSingleEvent(of: .value, with: { (snapshot) in
                let curr = Group(key: id, groupDict: snapshot.value as! [String:AnyObject])
                withBlock(curr)
            })
        }
    }
    
    // Gets the name for your own profile page
    func getName(withBlock: @escaping (User) -> Void)  {
        //        setData()
        let ref = FIRDatabase.database().reference()
        ref.child(Constants.DataNames.User).child(uid).observe(.value, with:  { snapshot -> Void in
            //  Get user name value
            if snapshot.exists() {
                if let userDict = snapshot.value as? [String: AnyObject]  {
                    let user = User(key: snapshot.key, userDict: userDict)
                    withBlock(user)
                }
            }
        })
    }
    
    func setCurrentGroup(_ groupID: String) {
        currentGroupID = groupID
    }
    
    func joinGroup(groupCode: String, withBlock: @escaping () -> Void) {
        let dbRef = FIRDatabase.database().reference()
        let userRef = dbRef.child(Constants.DataNames.User).child(uid)
        let groupRef = dbRef.child(Constants.DataNames.Group)
        groupRef.queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            let groupDict = snapshot.value as! [String:AnyObject]
            let key = snapshot.key
            let group = Group(key: key, groupDict: groupDict)
            
            if groupCode == group.memberCode || groupCode == group.adminCode {
                if groupCode == group.adminCode {
                    self.groupAdminIDs.append(key)
                    self.groupIDs.append(key)
                    group.memberIDs.append(key)
                    group.adminIDs.append(key)
                } else if groupCode == group.memberCode {
                    self.groupIDs.append(key)
                    group.memberIDs.append(key)
                }
                
                userRef.child(Constants.UserFields.groupIDs).setValue(self.groupIDs)
                userRef.child(Constants.UserFields.groupAdminIDs).setValue(self.groupAdminIDs)
                groupRef.child(group.groupID).child(Constants.GroupFields.memberIDs).setValue(group.memberIDs)
                groupRef.child(group.groupID).child(Constants.GroupFields.adminIDs).setValue(group.adminIDs)
                withBlock()
            }
            
        })
    }
    
}
