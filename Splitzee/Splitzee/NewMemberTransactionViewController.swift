//
//  NewMemberTransactionViewController.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/16/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit

class NewMemberTransactionViewController: UIViewController {
    var userSelectTextField: UITextField!
    var amountTextField: UITextField!
    var descriptionTextField: UITextView!
    var payButton: UIButton!
    var requestButton: UIButton!
    var groupImage: UIImageView!
    var groupLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavBar() {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.111))
        navBar.backgroundColor = UIColor.white
        let navTitle = UINavigationItem(title: "New Transaction")
        navBar.setItems([navTitle], animated: false)
        view.addSubview(navBar)
    }
    
    func setUpUI() {
        
        setupNavBar()
        
        groupImage = UIImageView(frame: CGRect(x: 0.185*view.frame.width, y: 0.121*view.frame.height, width: 0.194*view.frame.width, height: 0.194*view.frame.height))
        groupImage.contentMode = .scaleAspectFill
        groupImage.image = #imageLiteral(resourceName: "selectNewPhoto")// Should have the group image
        self.groupImage.layer.cornerRadius = 0.5*self.groupImage.frame.size.width
        self.groupImage.clipsToBounds = true
        view.addSubview(groupImage)
        
        groupLabel = UILabel(frame: CGRect(x: 0, y: 0.597*view.frame.height , width: 0.5*view.frame.width, height: view.frame.height * 0.089))
        groupLabel.layer.masksToBounds = true
        groupLabel.layer.borderColor = UIColor.gray.cgColor
        groupLabel.layer.borderWidth = 1
        groupLabel.text = "International Justice League of Super Acquaintances" // Should have the group name
        view.addSubview(groupLabel)
        
        userSelectTextField = UITextField(frame: CGRect(x: 0, y: 0.306*view.frame.height , width: view.frame.width, height: view.frame.height * 0.061))
        userSelectTextField.layer.masksToBounds = true
        userSelectTextField.layer.borderColor = UIColor.gray.cgColor
        userSelectTextField.layer.borderWidth = 1
        userSelectTextField.placeholder = "     Enter name, @username, or select above"
        view.addSubview(userSelectTextField)
        
        amountTextField = UITextField(frame: CGRect(x: 0, y: 0.367*view.frame.height , width: view.frame.width, height: view.frame.height * 0.061))
        amountTextField.layer.masksToBounds = true
        amountTextField.layer.borderColor = UIColor.gray.cgColor
        amountTextField.layer.borderWidth = 1
        amountTextField.placeholder = "     $0.00"
        view.addSubview(amountTextField)
        
        descriptionTextField = UITextView(frame: CGRect(x: 0, y: 0.430*view.frame.height , width: view.frame.width, height: view.frame.height * 0.164))
        descriptionTextField.layer.masksToBounds = true
        descriptionTextField.layer.borderColor = UIColor.gray.cgColor
        descriptionTextField.layer.borderWidth = 1
        descriptionTextField.text = "Add a short description of the transaction"
        view.addSubview(descriptionTextField)
        
        payButton = UIButton(frame: CGRect(x: 0, y: 0.597*view.frame.height , width: 0.5*view.frame.width, height: view.frame.height * 0.089))
        payButton.layer.masksToBounds = true
        payButton.layer.borderColor = UIColor.gray.cgColor
        payButton.layer.borderWidth = 1
        payButton.setTitle("Confirm Payment", for: .normal)
        view.addSubview(payButton)
        
        requestButton = UIButton(frame: CGRect(x: 0.5*view.frame.width, y: 0.597*view.frame.height , width: 0.5*view.frame.width, height: view.frame.height * 0.089))
        requestButton.layer.masksToBounds = true
        requestButton.layer.borderColor = UIColor.gray.cgColor
        requestButton.layer.borderWidth = 1
        requestButton.setTitle("Request Reimbursement", for: .normal)
        view.addSubview(requestButton)
        
    }
    
    
}
