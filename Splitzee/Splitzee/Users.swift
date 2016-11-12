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

class User{


    //User Variables
    var name: String?
    var profPicURL: String?
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
        
    
    }
  

    
    func getProfilePicture(){
        
    }
    
    
    
}
