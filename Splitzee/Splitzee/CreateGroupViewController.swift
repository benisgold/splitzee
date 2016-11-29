//
//  CreateGroupViewController.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/16/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit
import Firebase


class CreateGroupViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate ,UINavigationControllerDelegate {
    
    var background: UIImageView!
    var whiteBoxInBackground: UILabel!
    var xButton: UIButton!
    var pictureButton: UIButton!
    var createButton: UIButton!
    var nameTextField: UITextField!
    var memberCodeTextField: UITextField!
    var adminCodeTextField: UITextField!
    var userImage: UIImage!
    let constants = Constants()
    var currUser: CurrentUser!
    var alertView: UIAlertController!
    var createdGroup: Group?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        let dbRef = FIRDatabase.database().reference()
        let uid = FIRAuth.auth()?.currentUser?.uid
        if let uid = uid {
            dbRef.child(Constants.DataNames.User).child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                self.currUser = CurrentUser(key: uid, currentUserDict: snapshot.value as! [String: AnyObject])
                DispatchQueue.main.async {
                    self.setUpUI()
                    self.imagePicker.delegate = self
                    self.initializeTextFields()
                    self.configureKeyboard()
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    func setUpUI(){
        addBackground()
        makeXButton()
        makePictureButton()
        makeCreateButton()
        makeNameTextField()
        makeMemberCodeTextField()
        makeAdminCodeTextField()
    }
    
    func addBackground() {
        background = UIImageView(image: #imageLiteral(resourceName: "purpleFogBG"))
        background.frame = view.frame
        self.view.addSubview(background)
        
        whiteBoxInBackground = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.151, width: view.frame.width, height: view.frame.height * 0.65))
        whiteBoxInBackground.backgroundColor = UIColor.white
        view.addSubview(whiteBoxInBackground)
    }
    
    func makeXButton() {
        xButton = UIButton()
        xButton.frame = CGRect(x: 0.900 * view.frame.width, y: 0.175 * view.frame.height, width: 0.046 * view.frame.width, height: 0.046 * view.frame.width)
        xButton.titleLabel?.font = UIFont(name: "SFUIText-Regular", size: 22)
        xButton.setTitle("X", for: .normal)
        xButton.setTitleColor(constants.fontMediumGray, for: .normal)
        xButton.titleLabel?.textAlignment = .center
        xButton.addTarget(self, action: #selector(xButtonPressed), for: .touchUpInside)
        view.addSubview(xButton)
    }
    
    func makePictureButton() {
        pictureButton = UIButton()
        pictureButton.frame = CGRect(x: 0.338 * view.frame.width, y: 0.313 * view.frame.height, width: 0.323 * view.frame.width, height: 0.323 * view.frame.width)
        pictureButton.setImage(#imageLiteral(resourceName: "Picture"), for: .normal)
        pictureButton.contentMode = .scaleAspectFill
        pictureButton.layer.cornerRadius = 0.5 * pictureButton.frame.size.width
        pictureButton.clipsToBounds = true
        pictureButton.addTarget(self, action: #selector(loadImagesButtonTapped), for: .touchUpInside)
        view.addSubview(pictureButton)
    }
    
    func makeCreateButton() {
        createButton = UIButton()
        createButton.frame = CGRect(x: 0, y: 0.666 * view.frame.height, width: view.frame.width, height: 0.1 * view.frame.height)
        createButton.titleLabel?.font = UIFont(name: "SFUIText-Light", size: 20 )
        createButton.setTitle("Create Group", for: .normal)
        createButton.setTitleColor(.white, for: .normal)
        createButton.titleLabel?.textAlignment = .center
        createButton.layer.cornerRadius = 3
        createButton.backgroundColor = constants.mediumBlue
        createButton.addTarget(self, action: #selector(createGroup), for: .touchUpInside)
        view.addSubview(createButton)
    }
    
    func makeNameTextField() {
        nameTextField = UITextField()
        nameTextField.frame = CGRect(x: 0, y: 0.218 * view.frame.height, width: view.frame.width, height: 0.068 * view.frame.height)
        nameTextField.font = UIFont(name: "SFUIText-Regular", size: 22)
        nameTextField.placeholder = "Group name"
        nameTextField.textAlignment = .center
        nameTextField.autocorrectionType = .no
        nameTextField.backgroundColor = UIColor.white
        nameTextField.layer.cornerRadius = 3
        nameTextField.layer.borderWidth = 0.75
        nameTextField.layer.borderColor = constants.fontLightGray.cgColor
        view.addSubview(nameTextField)
    }
    
    func makeMemberCodeTextField() {
        memberCodeTextField = UITextField()
        memberCodeTextField.frame = CGRect(x: 0, y: view.frame.height * 0.523, width: view.frame.width, height: 0.068 * view.frame.height)
        memberCodeTextField.font = UIFont(name: "SFUIText-Light", size: 18)
        memberCodeTextField.placeholder = "Enter access code for members"
        memberCodeTextField.isSecureTextEntry = true
        memberCodeTextField.autocorrectionType = .no
        memberCodeTextField.textAlignment = .center
        memberCodeTextField.backgroundColor = UIColor.white
        memberCodeTextField.layer.borderWidth = 0.75
        memberCodeTextField.layer.cornerRadius = 3
        memberCodeTextField.layer.borderColor = constants.fontLightGray.cgColor
        view.addSubview(memberCodeTextField)
    }
    func makeAdminCodeTextField() {
        adminCodeTextField = UITextField()
        adminCodeTextField.frame = CGRect(x: 0, y: view.frame.height * 0.592, width: view.frame.width, height: 0.068 * view.frame.height)
        adminCodeTextField.font = UIFont(name: "SFUIText-Light", size: 18)
        adminCodeTextField.placeholder = "Enter access code for administrators"
        adminCodeTextField.isSecureTextEntry = true
        adminCodeTextField.autocorrectionType = .no
        adminCodeTextField.textAlignment = .center
        adminCodeTextField.backgroundColor = UIColor.white
        adminCodeTextField.layer.borderWidth = 0.75
        adminCodeTextField.layer.cornerRadius = 3
        adminCodeTextField.layer.borderColor = constants.fontLightGray.cgColor
        view.addSubview(adminCodeTextField)
    }
    
    //-------------------Controller---------------------------------------------------------------
    
    
    
    func initializeTextFields() {
        nameTextField.delegate = self
        memberCodeTextField.delegate = self
        adminCodeTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
    
    func alert(title: String, msg: String) {
        alertView = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.alertView.dismiss(animated: true, completion: nil)
        }))
        self.present(alertView, animated: true, completion: nil)
    }
    
    //--------------Adding Images to the Create an Account Button---------------------------------
    
    
    var imagePicker = UIImagePickerController()
    
    func loadImagesButtonTapped(sender: UIButton){
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let setImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userImage = setImage
            pictureButton.setImage(userImage, for: .normal)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func xButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func storeImage(id: String, withBlock: @escaping (String?) -> Void)
    {
        
        let storage = FIRStorage.storage()
        let storageRef = storage.reference(forURL: "gs://splitzee-ebff4.appspot.com")
        let imagesRef = storageRef.child("images/"+id)
        var data = NSData()
        if let img = userImage {
            data = UIImageJPEGRepresentation(img, 0.8)! as NSData
            
            let uploadTask = imagesRef.put(data as Data, metadata: nil) { metadata, error in
                if (error != nil) {
                    
                } else {
                    
                    withBlock(String(describing: metadata!.downloadURL()))
                }
            }
        }
    }
    
    
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // -----------FIREBASE------------------------------------------------------------------------
    
    
    
    //Sets display name of the user
    
    
    // Creates a new group
    func createGroup(_ sender: UIButton) {
        
        if ((nameTextField.text?.characters.count)! == 0 || (memberCodeTextField.text?.characters.count)! == 0 || (adminCodeTextField.text?.characters.count)! == 0 || (userImage == nil)) {
            alert(title: "Error", msg: "One or more fields have not been filled.")
        } else if (memberCodeTextField.text == adminCodeTextField.text) {
            alert(title: "Error", msg: "Member and Administrator access codes cannot be the same.")
        }
            //Stores the image in firebase database
        else {
            let rootRef = FIRDatabase.database().reference()
            let groupRef = rootRef.child(Constants.DataNames.Group)
            let key = groupRef.childByAutoId().key
            let userRef = rootRef.child(Constants.DataNames.User).child(currUser.uid)
            
            self.storeImage(id: key, withBlock: {(urlString) -> Void in
                
                if let urlString = urlString {
                    groupRef.child(key).child(Constants.GroupFields.name).setValue(self.nameTextField.text)
                    groupRef.child(key).child(Constants.GroupFields.memberCode).setValue(self.memberCodeTextField.text)
                    groupRef.child(key).child(Constants.GroupFields.adminCode).setValue(self.adminCodeTextField.text)
                    groupRef.child(key).child(Constants.GroupFields.picURL).setValue(urlString)
                    
                    groupRef.child(key).child(Constants.GroupFields.transactionIDs).setValue([])
                    var groupRefMemberIds: [String] = []
                    var groupRefAdminIds: [String] = []
                    groupRefMemberIds.append(self.currUser.uid)
                    groupRefAdminIds.append(self.currUser.uid)
                    groupRef.child(key).child(Constants.GroupFields.memberIDs).setValue(groupRefMemberIds)
                    groupRef.child(key).child(Constants.GroupFields.adminIDs).setValue(groupRefAdminIds)
                    groupRef.child(key).child(Constants.GroupFields.total).setValue(0.00)
                    
                    self.createdGroup = Group(name: self.nameTextField.text!, total: 0.00, picURL: urlString)
                    self.createdGroup?.transactionIDs = []
                    self.createdGroup?.memberIDs = [self.currUser.uid]
                    self.createdGroup?.adminIDs = [self.currUser.uid]
                    
                    
                    
                    
                    var memberIDs: [String] = []
                    var adminIDs: [String] = []
                    userRef.observeSingleEvent(of: .value, with: { (snapshot) in
                        let userDict = snapshot.value as! [String:AnyObject]
                        
                        if let groupMemberIDs = userDict[Constants.UserFields.groupIDs] as? [String] {
                            memberIDs = groupMemberIDs
                        }
                        
                        if let groupAdminIDs = userDict[Constants.UserFields.groupAdminIDs] as? [String] {
                            adminIDs = groupAdminIDs
                        }
                        
                        
                        memberIDs.append(key)
                        adminIDs.append(key)
                        
                        userRef.child(Constants.UserFields.groupIDs).setValue(memberIDs)
                        userRef.child(Constants.UserFields.groupAdminIDs).setValue(adminIDs)
                        
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                            self.performSegue(withIdentifier: "createGroupToAdminPage", sender: self)
                        }
                    })
                }
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createGroupToAdminPage" {
            let nextVC = segue.destination as! AdminPageViewController
            nextVC.group = createdGroup
        }
    }
}



