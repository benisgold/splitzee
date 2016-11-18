//
//  CreateAccountViewController.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/16/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {
    
    var background: UIImageView!
    var splitzeeLogo: UIImageView!
    var createYourAccount: UILabel!
    var plainDividingLineTop: UIImageView!
    var pictureButton: UIButton!
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
        
        // createYourAccount
        createYourAccount = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.0856, width: view.frame.width, height: view.frame.height * 0.043))
        createYourAccount.textColor = UIColor.white
        createYourAccount.text = "Create your account."
        createYourAccount.textAlignment = .center
        view.addSubview(createYourAccount)
        
        // plainDividingLineTop
        plainDividingLineTop = UIImageView(image: #imageLiteral(resourceName: "line"))
        plainDividingLineTop.frame = CGRect(x: view.frame.width * 0.098, y: view.frame.height * 0.146, width: view.frame.width * 0.804, height: view.frame.height * 0.01)
        plainDividingLineTop.contentMode = .scaleAspectFill
        self.view.addSubview(plainDividingLineTop)
        
        // pictureButton
        pictureButton = UIButton()
        pictureButton.frame = CGRect(x: 0.338 * view.frame.width, y: 0.180 * view.frame.height, width: 0.323 * view.frame.width, height: 0.186 * view.frame.height)
        pictureButton.setImage(#imageLiteral(resourceName: "selectNewPhoto"), for: .normal)
        pictureButton.contentMode = .scaleAspectFit
        view.addSubview(pictureButton)
        
        // plainDividingLineBottom
        plainDividingLineBottom = UIImageView(image: #imageLiteral(resourceName: "line"))
        plainDividingLineBottom.frame = CGRect(x: view.frame.width * 0.098, y: view.frame.height * 0.760 + (view.frame.height*0.0625), width: view.frame.width * 0.804, height: view.frame.height * 0.01)
        plainDividingLineBottom.contentMode = .scaleAspectFill
        self.view.addSubview(plainDividingLineBottom)
        
        // inputFullName
        inputFullName = UITextField()
        let inputFullNamePlaceholder = NSAttributedString(string: String(describing: "     Full name"), attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputFullName.attributedPlaceholder = inputFullNamePlaceholder
        inputFullName.frame = CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.329 + (view.frame.height*0.0625), width: view.frame.width * 0.841, height: view.frame.height * 0.057)
        inputFullName.backgroundColor = UIColor.white
        view.addSubview(inputFullName)
        // in progress!!!!! -------------- need to add picture to text
        
        // inputEmailOrUsername
        inputEmail = UITextField()
        let inputEmailPlaceholder = NSAttributedString(string: String(describing: "     Email or username"), attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputEmail.attributedPlaceholder = inputEmailPlaceholder
        inputEmail.frame = CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.409 + (view.frame.height*0.0625), width: view.frame.width * 0.841, height: view.frame.height * 0.057)
        inputEmail.backgroundColor = UIColor.white
        view.addSubview(inputEmail)
        // in progress!!!!! -------------- need to add picture to text
        
        // inputPassword
        inputPassword = UITextField()
        let inputPasswordPlaceholder = NSAttributedString(string: String(describing: "     Password"), attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputPassword.attributedPlaceholder = inputPasswordPlaceholder
        inputPassword.frame = CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.490 + (view.frame.height*0.0625), width: view.frame.width * 0.841, height: view.frame.height * 0.057)
        inputPassword.backgroundColor = UIColor.white
        view.addSubview(inputPassword)
        // in progress!!!!! -------------- need to add picture to text
        
        // inputConfirmPassword
        inputConfirmPassword = UITextField()
        let inputConfirmPasswordPlaceholder = NSAttributedString(string: String(describing: "     Confirm password"), attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        inputConfirmPassword.attributedPlaceholder = inputConfirmPasswordPlaceholder
        inputConfirmPassword.frame = CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.571 + (view.frame.height*0.0625), width: view.frame.width * 0.841, height: view.frame.height * 0.057)
        inputConfirmPassword.backgroundColor = UIColor.white
        view.addSubview(inputConfirmPassword)
        // in progress!!!!! -------------- need to add picture to text
        
        // createAccountButton
        createAccountButton = UIButton(frame: CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.651 + (view.frame.height*0.0625), width: view.frame.width * 0.841, height: view.frame.height * 0.068))
        createAccountButton.setTitle("CREATE ACCOUNT", for: .normal)
        createAccountButton.backgroundColor = constants.red
        view.addSubview(createAccountButton)
        
        // backToLoginButton
        backToLoginButton = UIButton(frame: CGRect(x: view.frame.width * 0.077, y: view.frame.height * 0.802 + (view.frame.height*0.0625), width: view.frame.width * 0.841, height: view.frame.height * 0.057))
        backToLoginButton.setTitle("Back to Login", for: .normal)
        backToLoginButton.backgroundColor = UIColor.clear
        backToLoginButton.layer.borderWidth = 1
        backToLoginButton.layer.borderColor = UIColor.white.cgColor
        
        backToLoginButton.addTarget(self, action: #selector(touchBackToLoginButton), for: .touchUpInside)
        self.performSegue(withIdentifier: "createAccountToSignIn", sender: backToLoginButton)
        view.addSubview(backToLoginButton)
    }

// -----------FUNCTIONS------------------------------------------------------------------------
    
    func touchBackToLoginButton(sender: UIButton!) {
        performSegue(withIdentifier: "createAccountToSignIn", sender: self)
    }

// -----------FIREBASE------------------------------------------------------------------------
    //Should Create a new account
    func createAccountPressed(_ sender: UIButton) {
        if (inputPassword.text != inputConfirmPassword.text) {
            // show popup!!
        } else {
            guard let email = inputEmail.text, let password = inputPassword.text, let name = inputFullName.text else {return}
            FIRAuth.auth()?.createUser(withEmail: email, password: password,  completion: { (user, error) in
                if let error = error{
                    print(error)
                    return
                } else {
                    self.setDisplayName(user)
                    AppState.sharedInstance.signedIn = true
                }
                
            })
        }
    }
    
    func setDisplayName(_ user: FIRUser?) {
        let changeRequest = user?.profileChangeRequest()
        changeRequest?.displayName = user?.email!.components(separatedBy: "@")[0]
        changeRequest?.commitChanges(completion: { (error) in
            if let error = error {
                print(error)
                return
            } else {
                self.signedIn(FIRAuth.auth()?.currentUser)
            }
        })
    }
    
    func signedIn(_ user: FIRUser?) {
        performSegue(withIdentifier: "signInToAdminPage", sender: self)
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
