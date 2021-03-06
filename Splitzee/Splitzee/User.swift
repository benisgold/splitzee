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

class User {
    
    
    // User Variables
    var name: String = ""
    var profPicURL: String = ""
    var uid: String = ""
    
    
    // Initiating variables
    init(key:String, userDict: [String: AnyObject])
    {
        uid = key
        
        
        if let username = userDict[Constants.UserFields.name] as? String{
            name = username
        }
        
        if let pic = userDict[Constants.UserFields.profPicURL] as? String{
            profPicURL = pic
        }
        
    }
    
    
    
    func getProfilePic(withBlock: @escaping (UIImage) -> Void) {
        let storageRef = FIRStorage.storage().reference()
        let imageRef = storageRef.child("images/"+uid)
        
        imageRef.data(withMaxSize: 3 * 1024 * 1024, completion: { (data, error) -> Void in
            if (error != nil) {
                print("An error occured: \(error!)")
                withBlock(#imageLiteral(resourceName: "Group"))
            } else {
                let image = UIImage(data: data!)
                withBlock(image!)
            }
        })
    }
    
    
    
}
