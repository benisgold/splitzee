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
    var transactionIDs: [String]? = []
    var groupIDs: [String]? = []
    var groupAdminIDs: [String]? = []
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
        
        if let admin = currentUserDict["adminIDs"] as? [String] {
            groupAdminIDs = admin
        }
        
        if let group = currentUserDict["memberIDs"] as? [String] {
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
    
    
    
    
    //    func setData() {
    //        dbRef = FIRDatabase.database().reference()
    //        dbRef.child("User").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
    //            // Get user value
    //            print("DATA VALUEEEE:")
    //            print(snapshot.value)
    //
    //        }) { (error) in
    //            print(error.localizedDescription)
    //        }
    //    }
    //
    
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
    func getTransactions(withBlock: @escaping (Transaction) -> Void)  {
        //        setData()
        let ref = FIRDatabase.database().reference()
        for id in transactionIDs!  {
            ref.child("Transactions").child(id).observeSingleEvent(of: .value, with:  { (snapshot) in
                //  Get user value
                let curr = Transaction(key: id, transactionDict: snapshot.value as! [String:AnyObject])
                withBlock(curr)
            })
        }
    }
    
    // Gets all the groups for the sidebar
    func getGroups(withBlock: @escaping (Group) -> Void)  {
        //        setData()
        let ref = FIRDatabase.database().reference()
        for id in groupIDs!  {
            ref.child("Group").child(id).observeSingleEvent(of: .value, with:  { (snapshot) in
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
        for id in groupAdminIDs! {
            ref.child("Group").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
                let curr = Group(key: id, groupDict: snapshot.value as! [String:AnyObject])
                withBlock(curr)
            })
        }
    }
    
    // Gets the name for your own profile page
    func getName(withBlock: @escaping (User) -> Void)  {
        //        setData()
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
    
    func setCurrentGroup(_ groupID: String) {
        currentGroupID = groupID
    }
    
    func joinGroup(groupCode: String) {
        let dbRef = FIRDatabase.database().reference()
        dbRef.child("Group").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            let groupDict = snapshot.value as! [String:AnyObject]
            let key = snapshot.key 
            let groupAdminCode = groupDict["adminCode"] as! String
            let groupMemberCode = groupDict["memberCode"] as! String
            if groupCode == groupAdminCode {
                self.groupAdminIDs?.append(key)
            } else if groupCode == groupMemberCode {
                self.groupAdminIDs?.append(key)
                self.groupIDs?.append(key)
            }
        })
    }
    
}
