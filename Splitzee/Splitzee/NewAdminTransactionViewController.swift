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
    var descriptionTextField: UITextView!
    var payButton: UIButton!
    var requestButton: UIButton!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupCollectionView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpUI() {
        
        setupNavBar()
        
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
    
    func setupNavBar() {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.111))
        navBar.backgroundColor = UIColor.white
        let navTitle = UINavigationItem(title: "New Transaction")
        navBar.setItems([navTitle], animated: false)
        view.addSubview(navBar)
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: view.frame.height * 0.097, width: view.frame.width, height: view.frame.height * 0.203) , collectionViewLayout: layout)
        collectionView.register(AdminCollectionViewCell.self, forCellWithReuseIdentifier: "adminTransactionCell")
        collectionView.backgroundColor = UIColor.black
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
}
    
extension NewAdminTransactionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // should be returning the number of users
            return 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "adminTransactionCell", for: indexPath) as! AdminCollectionViewCell
            for subview in cell.contentView.subviews {
                subview.removeFromSuperview()
            }
            cell.awakeFromNib()
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            let adminTransactionCell = cell as! AdminCollectionViewCell
            // set UI stuff
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 0.25 * view.frame.width, height: 0.203 * view.frame.height )
        }
    }



