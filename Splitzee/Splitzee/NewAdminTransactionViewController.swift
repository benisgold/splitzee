//
//  NewAdminTransactionViewController.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/16/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class NewAdminTransactionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextFieldDelegate{
    
    var background: UIImageView!
  //var userSelectTextField: UITextField!
    var amountTextField: UITextField!
    var descriptionTextField: UITextView!
    var payButton: UIButton!
    var requestButton: UIButton!
    var collectionView: UICollectionView!
    let constants = Constants()
    var groupID: String!
    var xButton: UIButton!
    
    
    var rootRef: FIRDatabaseReference?
    var membersList = [User]()
    var selectedMembers = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureKeyboard()
        setUpUI()
        pollForUsers()
        setupCollectionView()
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpUI() {
        
        background = UIImageView(image: #imageLiteral(resourceName: "whiteBlueGradientBG"))
        background.frame = view.frame
        self.view.addSubview(background)
        
        setupNavBar()
        
//        userSelectTextField = UITextField(frame: CGRect(x: 0, y: 0.306 * view.frame.height , width: view.frame.width, height: view.frame.height * 0.061))
//        userSelectTextField.layer.masksToBounds = true
//        userSelectTextField.backgroundColor = UIColor.white
//        userSelectTextField.layer.borderColor = constants.fontLightGray.cgColor
//        userSelectTextField.layer.borderWidth = 1
//        userSelectTextField.placeholder = "     Enter name, @username, or select above"
//        view.addSubview(userSelectTextField)
//        
        amountTextField = UITextField(frame: CGRect(x: 0, y: 0.367 * view.frame.height , width: view.frame.width, height: view.frame.height * 0.061))
        amountTextField.layer.masksToBounds = true
        amountTextField.backgroundColor = UIColor.white
        amountTextField.layer.borderColor = constants.fontLightGray.cgColor
        amountTextField.placeholder = "$0.00"
        amountTextField.delegate = self
        amountTextField.font = UIFont(name: "SFUIText-Regular", size: 16)
        createInset(textField: amountTextField)
        view.addSubview(amountTextField)
        
        descriptionTextField = UITextView(frame: CGRect(x: 0, y: 0.428 * view.frame.height , width: view.frame.width, height: view.frame.height * 0.164))
        descriptionTextField.layer.masksToBounds = true
        descriptionTextField.backgroundColor = UIColor.white
        descriptionTextField.layer.borderColor = constants.fontLightGray.cgColor
        descriptionTextField.layer.borderWidth = 1
        descriptionTextField.delegate = self
        descriptionTextField.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        descriptionTextField.font = UIFont(name: "SFUIText-Regular", size: 14)
        descriptionTextField.text = "Add a short description of the transaction"
        descriptionTextField.textColor = constants.fontLightGray
        view.addSubview(descriptionTextField)
        
        payButton = UIButton(frame: CGRect(x: 0, y: 0.590*view.frame.height , width: 0.4985 * view.frame.width, height: view.frame.height * 0.089))
        payButton.layer.masksToBounds = true
        payButton.backgroundColor = constants.mediumBlue
        payButton.setTitle("Pay", for: .normal)
        payButton.setTitleColor(UIColor.white, for: .normal)
        payButton.layer.cornerRadius = 3
        payButton.addTarget(self, action: #selector(pressPay), for: .touchUpInside)
        view.addSubview(payButton)
        
        requestButton = UIButton(frame: CGRect(x: 0.5015 * view.frame.width, y: 0.590 * view.frame.height , width: 0.4985 * view.frame.width, height: view.frame.height * 0.089))
        requestButton.layer.masksToBounds = true
        requestButton.setTitle("Request", for: .normal)
        requestButton.backgroundColor = constants.mediumBlue
        requestButton.setTitleColor(UIColor.white, for: .normal)
        requestButton.layer.cornerRadius = 3
        payButton.addTarget(self, action: #selector(pressRequest), for: .touchUpInside)
        view.addSubview(requestButton)
        
        xButton = UIButton()
        xButton.frame = CGRect(x: 0.900 * view.frame.width, y: 0.175 * view.frame.height, width: 0.046 * view.frame.width, height: 0.046 * view.frame.width)
        xButton.setImage(#imageLiteral(resourceName: "X Button"), for: .normal)
        xButton.imageView?.contentMode = .scaleAspectFill
        xButton.addTarget(self, action: #selector(xButtonPressed), for: .touchUpInside)
        view.addSubview(xButton)
    }
    
    func setupNavBar() {
        self.title = "New Transaction"
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0 , y: 80, width: 0.988 * view.frame.width, height: view.frame.height * 0.367 - 80) , collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewAdminTransactionCollectionViewCell.self, forCellWithReuseIdentifier: "adminTransactionCell")
        collectionView.backgroundColor = UIColor.clear
        
        view.addSubview(collectionView)
    }
    
    
    
    //-------------------- Functions---------------------------------------------------
    
    func createInset(textField: UITextField) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func configureKeyboard() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    func pollForUsers(){
        rootRef = FIRDatabase.database().reference()
        if let rootRef = rootRef {
            rootRef.child(Constants.DataNames.User).queryOrderedByKey().observe(.childAdded, with: {
                snapshot in
                let userKey = snapshot.key as String
                let userDict = snapshot.value as? [String: AnyObject]
                let user = User(key: userKey, userDict: userDict!)
                self.membersList.insert(user, at: 0)
            })
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                
            }
        }
    }
    
    func pressPay(sender: UIButton!)
    {
        for member in selectedMembers {
            var amt = amountTextField.text!
            amt.remove(at: (amt.startIndex))
            let amount: Double = ((Double)(amt)!*(-1))
            let dsc = descriptionTextField.text!
            newTransaction(amt: (String)(amount), memberID: member.uid, dsc: dsc, groupToMember: true, isApproved: true)
        }
    }
    
    
    
    func pressRequest(sender: UIButton)
    {
        for member in selectedMembers {
            var amt = amountTextField.text!
            amt.remove(at: (amt.startIndex))
            let amount: Double = (Double)(amt)!
            let dsc = descriptionTextField.text!
            newTransaction(amt: (String)(amount), memberID: member.uid, dsc: dsc, groupToMember: true, isApproved: false)
        }
    }
    
    func xButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func newTransaction(amt: String, memberID: String, dsc: String, groupToMember: Bool, isApproved: Bool) {
        let transactionDict: [String:AnyObject]
        
        transactionDict = ["amount": amt as AnyObject, "memberID": memberID as AnyObject, "groupID": groupID as AnyObject, "groupToMember": groupToMember as AnyObject, "isApproved": isApproved as AnyObject, "description": dsc as AnyObject]
        
        let transaction = Transaction(key: "", transactionDict: transactionDict)
        transaction.addToDatabase()
        
        dismiss(animated: true, completion: nil)
    }
    
    
    //-------------------Setting up collectionView--------------------
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // should be returning the number of users
        return membersList.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "adminTransactionCell", for: indexPath) as! NewAdminTransactionCollectionViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let adminTransactionCell = cell as! NewAdminTransactionCollectionViewCell
        
        //Sets the names for all the members
        adminTransactionCell.userName.text = membersList[indexPath.row].name
        
        //sets profile pictures for all the members
        membersList[indexPath.row].getProfilePic(withBlock:{(UIImage) -> Void in
                adminTransactionCell.userImage.image = UIImage
            })
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0.275*view.frame.width , height: 0.367*view.frame.height )
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? NewAdminTransactionCollectionViewCell
        if cell?.backgroundColor == UIColor.black {
            cell?.backgroundColor = UIColor.clear
            selectedMembers = selectedMembers.filter { $0.uid != selectedMembers[indexPath.row].uid }
        } else {
            cell?.backgroundColor = UIColor.black
            selectedMembers.append(membersList[indexPath.row])
        }
    }
    
}

extension NewAdminTransactionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == constants.fontLightGray || textView.text != "" {
            textView.text = ""
            textView.textColor = UIColor.black
        } else if textView.text == "" {
            textView.text = "Add a short description of the transaction"
            textView.textColor = constants.fontLightGray
        }
    }
}



