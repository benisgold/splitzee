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
    let constants = Constants()
    
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
        splitzeeLogo.frame = CGRect(x: view.frame.width * 0.052, y: view.frame.height * -0.01, width: view.frame.width, height: view.frame.height * 0.250)
        splitzeeLogo.contentMode = .scaleAspectFit
        self.view.addSubview(splitzeeLogo)
        
        // pleaseSignIn
        pleaseSignIn = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.245, width: view.frame.width, height: view.frame.height * 0.043))
        pleaseSignIn.textColor = UIColor.white
        pleaseSignIn.text = "Please sign in."
        pleaseSignIn.textAlignment = .center
        view.addSubview(pleaseSignIn)
        
        // plainDividingLine
        plainDividingLine = UIImageView(image: #imageLiteral(resourceName: "line"))
        plainDividingLine.frame = CGRect(x: view.frame.width * 0.098, y: view.frame.height * 0.283, width: view.frame.width * 0.804, height: view.frame.height * 0.01)
        plainDividingLine.contentMode = .scaleAspectFill
        self.view.addSubview(plainDividingLine)
        
        // inputEmailOrUsername
        inputEmailOrUsername = UITextField()
        let inputEmailOrUsernamePlaceholder = NSAttributedString(string: String(describing: "     Email or username"), attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputEmailOrUsername.attributedPlaceholder = inputEmailOrUsernamePlaceholder
        inputEmailOrUsername.frame = CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.329, width: view.frame.width * 0.841, height: view.frame.height * 0.057)
        inputEmailOrUsername.backgroundColor = UIColor.white
        view.addSubview(inputEmailOrUsername)
        // in progress!!!!! -------------- need to add picture to text
        
        // inputPassword
        inputPassword = UITextField(frame: CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.410, width: view.frame.width * 0.841, height: view.frame.height * 0.057))
        let inputPasswordPlaceholder = NSAttributedString(string: String(describing: "     Password"), attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputPassword.attributedPlaceholder = inputPasswordPlaceholder
        inputPassword.backgroundColor = UIColor.white
        view.addSubview(inputPassword)
        // in progress!!!!! -------------- need to add picture to text
        
        // signinButton
        signInButton = UIButton(frame: CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.503, width: view.frame.width * 0.256, height: view.frame.height * 0.068))
        signInButton.setTitle("SIGN IN", for: .normal)
        signInButton.backgroundColor = constants.darkGray
        view.addSubview(signInButton)
        
        // createAccountButton
        createAccountButton = UIButton(frame: CGRect(x: view.frame.width * 0.350, y: view.frame.height * 0.503, width: view.frame.width * 0.568, height: view.frame.height * 0.068))
        createAccountButton.setTitle("CREATE ACCOUNT", for: .normal)
        createAccountButton.backgroundColor = constants.red
        view.addSubview(createAccountButton)
        
        // forgotPassword
        forgotPassword = UILabel(frame: CGRect(x: view.frame.width * 0.325, y: view.frame.height * 0.586, width: view.frame.width * 0.330, height: view.frame.height * 0.030))
        forgotPassword.text = "Forgot password?"
        forgotPassword.textAlignment = .center
        forgotPassword.textColor = UIColor.white
        view.addSubview(forgotPassword)
        
        // orDividingLine
        orDividingLine = UIImageView(image: #imageLiteral(resourceName: "orLine"))
        orDividingLine.frame = CGRect(x: view.frame.width * 0.098, y: view.frame.height * 0.650, width: view.frame.width * 0.804, height: view.frame.height * 0.01)
        orDividingLine.contentMode = .scaleAspectFill
        self.view.addSubview(orDividingLine)
        
        // signinGoogle
        signInGoogle = UIButton(frame: CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.694, width: view.frame.width * 0.841, height: view.frame.height * 0.057))
        signInGoogle.setTitle("Sign in with Google", for: .normal)
        signInGoogle.backgroundColor = UIColor.clear
        signInGoogle.layer.borderWidth = 1
        signInGoogle.layer.borderColor = UIColor.white.cgColor
        view.addSubview(signInGoogle)
        
        // signinFacebook
        signInFacebook = UIButton(frame: CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.778, width: view.frame.width * 0.841, height: view.frame.height * 0.057))
        signInFacebook.setTitle("Sign in with Facebook", for: .normal)
        signInFacebook.backgroundColor = UIColor.clear
        signInFacebook.layer.borderWidth = 1
        signInFacebook.layer.borderColor = UIColor.white.cgColor
        view.addSubview(signInFacebook)

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
