//
//  NewAdminTransactionViewController.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/16/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit

class NewAdminTransactionViewController: UIViewController {
    
    var userSelectTextField: UITextField!
    var amountTextField: UITextField!
    var descriptionTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpUI() {
        
        userSelectTextField = UITextField(frame: CGRect(x: 0, y: 0.306*view.frame.height , width: view.frame.width, height: view.frame.height * 0.061))
        userSelectTextField.layer.masksToBounds = true
        userSelectTextField.layer.borderColor = UIColor.gray.cgColor
        userSelectTextField.layer.borderWidth = 1
        userSelectTextField.placeholder = "Enter name, @username, or select above"
        view.addSubview(userSelectTextField)
        
        amountTextField = UITextField(frame: CGRect(x: 0, y: 0.368*view.frame.height , width: view.frame.width, height: view.frame.height * 0.061))
        amountTextField.layer.masksToBounds = true
        amountTextField.layer.borderColor = UIColor.gray.cgColor
        amountTextField.layer.borderWidth = 1
        amountTextField.placeholder = "$0.00"
        view.addSubview(amountTextField)
        
        descriptionTextField = UITextField(frame: CGRect(x: 0, y: 0.431*view.frame.height , width: view.frame.width, height: view.frame.height * 0.164))
        descriptionTextField.layer.masksToBounds = true
        descriptionTextField.layer.borderColor = UIColor.gray.cgColor
        descriptionTextField.layer.borderWidth = 1
        descriptionTextField.placeholder = "Enter a short description"
        view.addSubview(descriptionTextField)
        
        
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
