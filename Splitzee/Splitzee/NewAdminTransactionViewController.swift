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
    var amountTextField: UITextField!
    var descriptionTextField: UITextView!
    var payButton: UIButton!
    var requestButton: UIButton!
    var collectionView: UICollectionView!
    let constants = Constants()
    var group: Group!
    
    var rootRef: FIRDatabaseReference?
    var membersList = [User]()
    var selectedMembers = [User]()
    var greyImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureKeyboard()
        setUpUI()
        setMemberList()
        setupCollectionView()
        view.bringSubview(toFront: collectionView)
        
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
        requestButton.addTarget(self, action: #selector(pressRequest), for: .touchUpInside)
        view.addSubview(requestButton)
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
    
    
    
    // Functions---------------------------------------------------
    
    func createInset(textField: UITextField) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    
    @objc(textView:shouldChangeTextInRange:replacementText:) func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func configureKeyboard() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    func setMemberList(){
        group.pollForUsers(withBlock: { user in
            self.membersList.append(user)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
    
    func pressPay(sender: UIButton!)
    {
        for member in selectedMembers {
            var amt = amountTextField.text!
            amt.remove(at: (amt.startIndex))
            let amount: Double = ((Double)(amt)!*(-1))
            group.addToTotal(amount: amount)
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
    
    func newTransaction(amt: String, memberID: String, dsc: String, groupToMember: Bool, isApproved: Bool) {
        let transactionDict: [String:AnyObject]
        
        transactionDict = ["amount": amt as AnyObject, "memberID": memberID as AnyObject, "groupID": group.groupID as AnyObject, "groupToMember": groupToMember as AnyObject, "isApproved": isApproved as AnyObject, "description": dsc as AnyObject]
        
        let transaction = Transaction(key: "", transactionDict: transactionDict)
        transaction.addToDatabase(withBlock: {
            if let navigationController = self.navigationController {
                navigationController.popViewController(animated: true)
            }
        })
        
    }
    
    
    //-------------------Setting up collectionView--------------------
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // should be returning the number of users
        print("count:" + String(membersList.count))
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
        membersList[indexPath.row].getProfilePic(withBlock:{(image) -> Void in
            print(image)
            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(self.imageTapped(recog:)))
            adminTransactionCell.userImage.isUserInteractionEnabled = true
            adminTransactionCell.userImage.tag = indexPath.row
            adminTransactionCell.userImage.tintColor = UIColor.clear
            adminTransactionCell.userImage.addGestureRecognizer(tapGestureRecognizer)
            adminTransactionCell.userImage.image = image.alpha(value: 0.95)
        })
    }
    
    func imageTapped(recog: UITapGestureRecognizer) {
        
        let imageView = recog.view as! UIImageView
        
        if imageView.tintColor == UIColor.clear {
            imageView.tintColor = UIColor.gray
            greyImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageView.frame.width, height: imageView.frame.height))
            greyImageView.image = #imageLiteral(resourceName: "Group").alpha(value: 0.5)
            imageView.addSubview(greyImageView)
            selectedMembers.append(membersList[imageView.tag])
            
        } else {
            imageView.tintColor = UIColor.clear
            for view in imageView.subviews {
                if view.isKind(of: UIImageView.self) {
                    view.removeFromSuperview()
                }
            }
            selectedMembers = selectedMembers.filter { $0.uid != membersList[imageView.tag].uid }
        }
        
        //imageView.image = imageView.image?.alpha(value: 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0.275*view.frame.width , height: 0.367*view.frame.height )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? NewAdminTransactionCollectionViewCell
        if cell?.backgroundColor == UIColor.black {
            cell?.backgroundColor = UIColor.clear
            selectedMembers = selectedMembers.filter { $0.uid != membersList[indexPath.row].uid }
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

extension UIImage{
    
    func alpha(value:CGFloat)->UIImage
    {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
    }
}



