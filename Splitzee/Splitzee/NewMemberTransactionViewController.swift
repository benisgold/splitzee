//
//  NewMemberTransactionViewController.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/16/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit
import Firebase

class NewMemberTransactionViewController: UIViewController {
    
    var amountTextField: UITextField!
    var descriptionTextField: UITextView!
    var payButton: UIButton!
    var requestButton: UIButton!
    var xButton: UIButton!
    var groupImage: UIImageView!
    var groupLabel: UILabel!
    var alertWrongFormat: UIAlertController!
    var currUser: CurrentUser!
    var group: Group!
    let constants = Constants()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dbRef = FIRDatabase.database().reference()
        let uid = FIRAuth.auth()?.currentUser?.uid
        if let uid = uid {
            dbRef.child(Constants.DataNames.User).child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                self.currUser = CurrentUser(key: uid, currentUserDict: snapshot.value as! [String: AnyObject])
                DispatchQueue.main.async {
                    self.currUser.setCurrentGroup(self.group.groupID)
                    self.setUpUI()
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavBar() {
        self.title = "New Transaction"
    }
    
    func setUpUI() {
        
        setupNavBar()
        
        groupImage = UIImageView(frame: CGRect(x: 0.326 * view.frame.width, y: 0.145 * view.frame.height, width: 0.345 * view.frame.width, height: 0.160 * view.frame.height))
        groupImage.contentMode = .scaleAspectFit
        groupImage.clipsToBounds = true
        
        getGroup(withBlock: {(currGroup) -> Void in
            currGroup.getGroupPic(withBlock: {(image) -> Void in
            self.groupImage.image = image
                
            })
        })
        
        view.addSubview(groupImage)
        
        groupLabel = UILabel(frame: CGRect(x: 0, y: 0.306 * view.frame.height , width: view.frame.width, height: view.frame.height * 0.061))
        groupLabel.layer.masksToBounds = true
        groupLabel.textColor = constants.fontDarkGray
        groupLabel.textAlignment = .center
        
        getGroup(withBlock: {(currGroup) -> Void in
                self.groupLabel.text = currGroup.name
            })
        
        view.addSubview(groupLabel)
        
        amountTextField = UITextField(frame: CGRect(x: 0, y: 0.367 * view.frame.height , width: view.frame.width, height: view.frame.height * 0.061))
        amountTextField.layer.masksToBounds = true
        amountTextField.backgroundColor = UIColor.white
        amountTextField.layer.borderColor = constants.fontLightGray.cgColor
        amountTextField.layer.borderWidth = 1
        amountTextField.placeholder = "     $0.00"
        view.addSubview(amountTextField)
        
        descriptionTextField = UITextView(frame: CGRect(x: 15, y: 0.426 * view.frame.height , width: view.frame.width, height: view.frame.height * 0.164))
        descriptionTextField.layer.masksToBounds = true
        descriptionTextField.backgroundColor = UIColor.white
        descriptionTextField.layer.borderColor = constants.fontWhite.cgColor
        descriptionTextField.layer.borderWidth = 1
        descriptionTextField.delegate = self
        descriptionTextField.text = "     Add a short description of the transaction"
        descriptionTextField.textColor = constants.fontLightGray
        view.addSubview(descriptionTextField)
        
        payButton = UIButton(frame: CGRect(x: 0, y: 0.597*view.frame.height , width: 0.4985 * view.frame.width, height: view.frame.height * 0.089))
        payButton.layer.masksToBounds = true
        payButton.backgroundColor = constants.mediumBlue
        payButton.setTitle("Confirm Payment", for: .normal)
        payButton.setTitleColor(UIColor.white, for: .normal)
        payButton.layer.cornerRadius = 2
        payButton.addTarget(self, action: #selector(pay), for: .touchUpInside)
        view.addSubview(payButton)
        
        requestButton = UIButton(frame: CGRect(x: 0.5015 * view.frame.width, y: 0.597 * view.frame.height , width: 0.4985 * view.frame.width, height: view.frame.height * 0.089))
        requestButton.layer.masksToBounds = true
        requestButton.setTitle("Request Money", for: .normal)
        requestButton.backgroundColor = constants.mediumBlue
        requestButton.setTitleColor(UIColor.white, for: .normal)
        requestButton.layer.cornerRadius = 2
        requestButton.addTarget(self, action: #selector(request), for: .touchUpInside)
        view.addSubview(requestButton)
        
        xButton = UIButton()
        xButton.frame = CGRect(x: 0.900 * view.frame.width, y: 0.175 * view.frame.height, width: 0.046 * view.frame.width, height: 0.046 * view.frame.width)
        xButton.titleLabel?.font = UIFont(name: "SFUIText-Regular", size: 22)
        xButton.setTitle("X", for: .normal)
        xButton.setTitleColor(constants.fontMediumGray, for: .normal)
        xButton.titleLabel?.textAlignment = .center
        xButton.addTarget(self, action: #selector(xButtonPressed), for: .touchUpInside)
        view.addSubview(xButton)
    }
    
    func pay() {
        if (checkFormat()) {
            var amt = amountTextField.text!
            amt.remove(at: (amt.startIndex))
            let amount: Double = (Double)(amt)!
            let dsc = descriptionTextField.text!
            newTransaction((String)(amount), (String) (dsc), true)
        }
    }
    
    func request() {
        if (checkFormat()) {
            var amt = amountTextField.text!
            amt.remove(at: (amt.startIndex))
            let amount: Double = (Double)(amt)!
            let dsc = descriptionTextField.text!
            newTransaction((String)(amount), (String) (dsc), false)
        }
    }
    
    func newTransaction(_ amt: String, _ dsc: String, _ groupToMember: Bool) {
        let transactionDict: [String:AnyObject]
        let amount = Double(amt)
        transactionDict = [Constants.TransactionFields.amount: amount as AnyObject, Constants.TransactionFields.memberID: currUser.uid as AnyObject, Constants.TransactionFields.groupID: currUser.currentGroupID as AnyObject, Constants.TransactionFields.groupToMember: groupToMember as AnyObject, Constants.TransactionFields.isApproved: false as AnyObject, Constants.TransactionFields.description: dsc as AnyObject]
        let transaction = Transaction(key: "", transactionDict: transactionDict)
        transaction.addToDatabase()
        dismiss(animated: true, completion: nil)
    }
    
    func checkFormat() -> Bool {
        if (amountTextField.text?.isEmpty)! {
            alert(msg: "Please input an amount.")
            return false
        } else if (descriptionTextField.text.isEmpty) {
            alert(msg: "Please input a description.")
            return false
        } else if (amountTextField.text?.commonPrefix(with: "$") != "$") {
            alert(msg: "The amount does not have the correct format: $0.00")
            return false
        } else {
            return true
        }
    }
    
    func xButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func alert(msg: String) {
        alertWrongFormat = UIAlertController(title: "Error", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alertWrongFormat.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.alertWrongFormat.dismiss(animated: true, completion: nil)
        }))
        self.present(alertWrongFormat, animated: true, completion: nil)
    }
    //-------Firebase----------------------------
    
func getGroup(withBlock: @escaping (Group) -> Void) {
        let ref = FIRDatabase.database().reference()
        ref.child("Group/\(currUser.currentGroupID)").observe(.value, with: { snapshot -> Void in
            // Get user value
            if snapshot.exists(){
                if let groupDict = snapshot.value as? [String: AnyObject]{
                    let group = Group(key: snapshot.key, groupDict: groupDict)
                    withBlock(group)
                }
            }
        })
    }
 
    
}

//--------------------------------------------

extension NewMemberTransactionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == constants.fontLightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
}




