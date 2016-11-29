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
        profPicURL = profPicURL.replacingOccurrences(of: "Optional(", with: "")
        profPicURL = profPicURL.replacingOccurrences(of: ")", with: "")
        print(profPicURL)
        let imageRef = storageRef.child(profPicURL)

        
        imageRef.data(withMaxSize: 1 * 1024 * 1024, completion: { (data, error) -> Void in
            if (error != nil) {
                print("An error occured: \(error!)")
            } else {
                let image = UIImage(data: data!)
                withBlock(image!)
            }
        })
    }
    
    
    
}
