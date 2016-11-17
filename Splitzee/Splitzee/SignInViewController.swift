//
//  SignInViewController.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/16/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    var splitzeeLogo: UIImageView!
    var pleaseSignIn: UILabel!
    var plainDividingLine: UIImageView!
    var inputEmailOrUsername: UITextField!
    var inputPassword: UITextField!
    var signInButton: UIButton!
    var createAccountButton: UIButton!
    var forgotPassword: UILabel!
    var orDividingLine: UIImageView!
    var signInGoogle: UIButton!
    var signInFacebook: UIButton!
    var background: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupUI() {
        
        // background
        background = UIImageView(image: #imageLiteral(resourceName: "purpleFogBG"))
        background.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        self.view.addSubview(background)
        
        // splitzeeLogo
        splitzeeLogo = UIImageView(image: #imageLiteral(resourceName: "splitzeeStraight"))
        splitzeeLogo.frame = CGRect(x: 0, y: 131, width: view.frame.width*0.389, height: view.frame.height*0.205)
        self.view.addSubview(splitzeeLogo)
        
        // pleaseSignIn
        
        // plainDividingLine
        plainDividingLine = UIImageView(image: #imageLiteral(resourceName: "line"))
        plainDividingLine.frame = CGRect(x: 40, y: 208, width: 338, height: 3)
        self.view.addSubview(plainDividingLine)
        
        // inputEmailOrUsername
        inputEmailOrUsername = UITextField()
        let inputEmailOrUsernamePlaceholder = NSAttributedString(string: "Email or username", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputEmailOrUsername.attributedPlaceholder = inputEmailOrUsernamePlaceholder
        inputEmailOrUsername.frame = CGRect(x: view.frame.width*0.077, y: view.frame.height*0.329, width: view.frame.width*0.845, height: view.frame.height*0.057)
        // in progress!!!!! --------------
        
        // inputPassword
        
        // signinButton
        
        // createAccountButton
        
        // forgotPassword
        
        // orDividingLine
        
        // signinGoogle
        
        // signinFacebook
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
