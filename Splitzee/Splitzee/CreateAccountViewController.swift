//
//  CreateAccountViewController.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/16/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    var background: UIImageView!
    var splitzeeLogo: UIImageView!
    var createYourAccount: UILabel!
    var plainDividingLineTop: UIImageView!
    var plainDividingLineBottom: UIImageView!
    var inputFullName: UITextField!
    var inputEmail: UITextField!
    var inputPassword: UITextField!
    var inputConfirmPassword: UITextField!
    var createAccountButton: UIButton!
    var backToLoginButton: UIButton!
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
        createYourAccount = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.245, width: view.frame.width, height: view.frame.height * 0.043))
        createYourAccount.textColor = UIColor.white
        createYourAccount.text = "Create your account."
        createYourAccount.textAlignment = .center
        view.addSubview(createYourAccount)
        
        // plainDividingLineTop
        plainDividingLineTop = UIImageView(image: #imageLiteral(resourceName: "line"))
        plainDividingLineTop.frame = CGRect(x: view.frame.width * 0.098, y: view.frame.height * 0.283, width: view.frame.width * 0.804, height: view.frame.height * 0.01)
        plainDividingLineTop.contentMode = .scaleAspectFill
        self.view.addSubview(plainDividingLineTop)
        
        // plainDividingLineBottom
        plainDividingLineBottom = UIImageView(image: #imageLiteral(resourceName: "line"))
        plainDividingLineBottom.frame = CGRect(x: view.frame.width * 0.098, y: view.frame.height * 0.760, width: view.frame.width * 0.804, height: view.frame.height * 0.01)
        plainDividingLineBottom.contentMode = .scaleAspectFill
        self.view.addSubview(plainDividingLineBottom)
        
        // inputFullName
        inputFullName = UITextField()
        let inputFullNamePlaceholder = NSAttributedString(string: String(describing: "Full name"), attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputFullName.attributedPlaceholder = inputFullNamePlaceholder
        inputFullName.frame = CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.329, width: view.frame.width * 0.841, height: view.frame.height * 0.057)
        inputFullName.backgroundColor = UIColor.white
        view.addSubview(inputFullName)
        // in progress!!!!! -------------- need to add picture to text
        
        // inputEmailOrUsername
        inputEmail = UITextField()
        let inputEmailPlaceholder = NSAttributedString(string: String(describing: "Email or username"), attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputEmail.attributedPlaceholder = inputEmailPlaceholder
        inputEmail.frame = CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.409, width: view.frame.width * 0.841, height: view.frame.height * 0.057)
        inputEmail.backgroundColor = UIColor.white
        view.addSubview(inputEmail)
        // in progress!!!!! -------------- need to add picture to text
        
        // inputPassword
        inputPassword = UITextField()
        let inputPasswordPlaceholder = NSAttributedString(string: String(describing: "Password"), attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputPassword.attributedPlaceholder = inputPasswordPlaceholder
        inputPassword.frame = CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.490, width: view.frame.width * 0.841, height: view.frame.height * 0.057)
        inputPassword.backgroundColor = UIColor.white
        view.addSubview(inputPassword)
        // in progress!!!!! -------------- need to add picture to text
        
        // inputConfirmPassword
        inputConfirmPassword = UITextField()
        let inputConfirmPasswordPlaceholder = NSAttributedString(string: String(describing: "Confirm password"), attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputConfirmPassword.attributedPlaceholder = inputConfirmPasswordPlaceholder
        inputConfirmPassword.frame = CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.571, width: view.frame.width * 0.841, height: view.frame.height * 0.057)
        inputConfirmPassword.backgroundColor = UIColor.white
        view.addSubview(inputConfirmPassword)
        // in progress!!!!! -------------- need to add picture to text
        
        // createAccountButton
        createAccountButton = UIButton(frame: CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.651, width: view.frame.width * 0.841, height: view.frame.height * 0.068))
        createAccountButton.setTitle("CREATE ACCOUNT", for: .normal)
        createAccountButton.backgroundColor = constants.red
        view.addSubview(createAccountButton)
        
        // backToLoginButton
        backToLoginButton = UIButton(frame: CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.802, width: view.frame.width * 0.841, height: view.frame.height * 0.057))
        backToLoginButton.setTitle("Back to Login", for: .normal)
        backToLoginButton.backgroundColor = UIColor.clear
        backToLoginButton.layer.borderWidth = 1
        backToLoginButton.layer.borderColor = UIColor.white.cgColor
        view.addSubview(backToLoginButton)
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
