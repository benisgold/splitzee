//
//  SignInViewController.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/16/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    var splitzeeLogo: UIImageView!
    var pleaseSignIn: UILabel!
    var plainDividingLine: UIImageView!
    var inputEmail: UITextField!
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
        UIApplication.shared.statusBarStyle = .lightContent
        setupUI()
        initializeTextFields()
        configureKeyboard()
    }
    
    func setupUI() {
        
        // background
        background = UIImageView(image: #imageLiteral(resourceName: "purpleFogBG"))
        background.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        self.view.addSubview(background)
        
        // splitzeeLogo
        splitzeeLogo = UIImageView(image: #imageLiteral(resourceName: "splitzeeStraight"))
        splitzeeLogo.frame = CGRect(x: view.frame.width * 0.052, y: view.frame.height * -0.045, width: view.frame.width, height: view.frame.height * 0.250)
        splitzeeLogo.contentMode = .scaleAspectFit
        self.view.addSubview(splitzeeLogo)
        
        // pleaseSignIn
        pleaseSignIn = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.230, width: view.frame.width, height: view.frame.height * 0.043))
        pleaseSignIn.textColor = UIColor.white
        pleaseSignIn.font = UIFont(name: "SFUIText-Light", size: 27)
        pleaseSignIn.text = "Sign in"
        pleaseSignIn.textAlignment = .center
        view.addSubview(pleaseSignIn)
        
        // plainDividingLine
        plainDividingLine = UIImageView(image: #imageLiteral(resourceName: "line"))
        plainDividingLine.frame = CGRect(x: view.frame.width * 0.098, y: view.frame.height * 0.283, width: view.frame.width * 0.804, height: view.frame.height * 0.01)
        plainDividingLine.contentMode = .scaleAspectFill
        self.view.addSubview(plainDividingLine)
        
        // inputEmail
        inputEmail = UITextField()
        let inputEmailPlaceholder = NSAttributedString(string: String(describing: "Email"), attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputEmail.font = UIFont(name: "SFUIText-Light", size: 14)
        inputEmail.attributedPlaceholder = inputEmailPlaceholder
        inputEmail.frame = CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.329, width: view.frame.width * 0.841, height: view.frame.height * 0.057)
        inputEmail.backgroundColor = UIColor.white
        inputEmail.autocapitalizationType = .none
        inputEmail.keyboardType = .emailAddress
        inputEmail.layer.cornerRadius = 3
        inputEmail.autocorrectionType = .no
        createInset(textField: inputEmail)
        view.addSubview(inputEmail)
        
//        // mailSymbol
//        let mailImage = UIImageView(image: #imageLiteral(resourceName: "mailSymbol"))
//        mailImage.frame = CGRect(x: 0.830 * view.frame.width, y: 0.344 * view.frame.height, width: 0.140 * view.frame.width, height: 0.038 * view.frame.height)
//        view.addSubview(mailImage)
        
        // inputPassword
        inputPassword = UITextField(frame: CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.410, width: view.frame.width * 0.841, height: view.frame.height * 0.057))
        inputPassword.font = UIFont(name: "SFUIText-Light", size: 14)
        let inputPasswordPlaceholder = NSAttributedString(string: String(describing: "Password"), attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputPassword.attributedPlaceholder = inputPasswordPlaceholder
        inputPassword.backgroundColor = UIColor.white
        inputPassword.textColor = UIColor.black
        inputPassword.layer.cornerRadius = 3
        inputPassword.isSecureTextEntry = true
        inputPassword.autocapitalizationType = .none
        inputPassword.autocorrectionType = .no
        createInset(textField: inputPassword)
        view.addSubview(inputPassword)
        // in progress!!!!! -------------- need to add picture to text
        
        // signinButton
        signInButton = UIButton(frame: CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.503, width: view.frame.width * 0.256, height: view.frame.height * 0.068))
        signInButton.setTitle("SIGN IN", for: .normal)
        signInButton.titleLabel?.font = UIFont(name: "SFUIText-Light", size: 18)
        signInButton.backgroundColor = constants.darkGray
        signInButton.layer.cornerRadius = 3
        signInButton.addTarget(self, action: #selector(touchSignInButton), for: .touchUpInside)
        view.addSubview(signInButton)
        
        // createAccountButton
        createAccountButton = UIButton(frame: CGRect(x: view.frame.width * 0.350, y: view.frame.height * 0.503, width: view.frame.width * 0.568, height: view.frame.height * 0.068))
        createAccountButton.setTitle("CREATE ACCOUNT", for: .normal)
        createAccountButton.titleLabel?.font = UIFont(name: "SFUIText-Light", size: 18)
        createAccountButton.backgroundColor = constants.red
        createAccountButton.layer.cornerRadius = 3
        createAccountButton.addTarget(self, action: #selector(touchCreateAccountButton), for: .touchUpInside)
        view.addSubview(createAccountButton)
        
        // forgotPassword
        forgotPassword = UILabel(frame: CGRect(x: view.frame.width * 0.325, y: view.frame.height * 0.586, width: view.frame.width * 0.330, height: view.frame.height * 0.030))
        forgotPassword.text = "Forgot password?"
        forgotPassword.font = UIFont(name: "SFUIText-Regular", size: 14)
        forgotPassword.textAlignment = .center
        forgotPassword.textColor = UIColor.white
        view.addSubview(forgotPassword)
        
        // orDividingLine
        orDividingLine = UIImageView(image: #imageLiteral(resourceName: "orLine"))
        orDividingLine.frame = CGRect(x: view.frame.width * 0.098, y: view.frame.height * 0.641
            , width: view.frame.width * 0.804, height: view.frame.height * 0.01)
        orDividingLine.contentMode = .scaleAspectFill
        self.view.addSubview(orDividingLine)
        
        // signinGoogle
        signInGoogle = UIButton(frame: CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.694, width: view.frame.width * 0.841, height: view.frame.height * 0.057))
        signInGoogle.setTitle("Sign in with Google", for: .normal)
        signInGoogle.titleLabel?.font = UIFont(name: "SFUIText-Regular", size: 18)
        signInGoogle.backgroundColor = UIColor.clear
        signInGoogle.layer.borderWidth = 1
        signInGoogle.layer.cornerRadius = 3
        signInGoogle.layer.borderColor = UIColor.white.cgColor
        view.addSubview(signInGoogle)
        
        // signinFacebook
        signInFacebook = UIButton(frame: CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.778, width: view.frame.width * 0.841, height: view.frame.height * 0.057))
        signInFacebook.setTitle("Sign in with Facebook", for: .normal)
        signInFacebook.titleLabel?.font = UIFont(name: "SFUIText-Regular", size: 18)
        signInFacebook.backgroundColor = UIColor.clear
        signInFacebook.layer.borderWidth = 1
        signInFacebook.layer.cornerRadius = 3
        signInFacebook.layer.borderColor = UIColor.white.cgColor
        view.addSubview(signInFacebook)

    }
    
    func initializeTextFields() {
        inputEmail.delegate = self
        inputPassword.delegate = self
    }
    
    
// ---------------FUNCTIONS---------------------------------------------------------------
    
    func touchCreateAccountButton(sender: UIButton!) {
        performSegue(withIdentifier: "signInToCreateAccount", sender: self)
    }
    
    func touchSignInButton(sender: UIButton!) {
        performSegue(withIdentifier: "signInToAdminPage", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func createInset(textField: UITextField) {
        let Inset = UITextView()
        Inset.frame = CGRect(x: 0, y: 0, width: 0.048 * view.frame.width, height: textField.frame.height)
        Inset.layer.cornerRadius = 3
        textField.leftView = Inset
        textField.leftViewMode = .always
        view.addSubview(Inset)
    }
    
    func configureKeyboard() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    
    
// ---------------FIREBASE----------------------------------------------------------------
    override func viewDidAppear(_ animated: Bool) {
        FIRAuth.auth()?.addStateDidChangeListener({ (auth : FIRAuth, user : FIRUser?) in
            if let user = user {
                self.signedIn(user)
            } else {
                print("Sign up or log in!")
            }
        })
    }
    
    func signedIn(_ user: FIRUser?) {
        AppState.sharedInstance.signedIn = true
        inputEmail.text = ""
        inputPassword.text = ""
        
        performSegue(withIdentifier: "signInToAdminPage", sender: self)
    }
    
    func logInClicked(sender: UIButton)
    {
        guard let email = inputEmail.text, let password = inputPassword.text else {return}
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error)
                return
            } else {
                self.signedIn(user)
            }
        }
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
