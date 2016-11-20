//
//  CreateGroupViewController.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/16/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController {
    
    var background: UIImageView!
    var whiteBoxInBackground: UILabel!
    var xButton: UIButton!
    var pictureButton: UIButton!
    var createButton: UIButton!
    var nameTextField: UITextField!
    var codeTextField: UITextField!
    let constants = Constants()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        addBackground()
        makeXButton()
        makePictureButton()
        makeCreateButton()
        makeNameTextField()
        makeCodeTextField()
    }
    
    func addBackground() {
        background = UIImageView(image: #imageLiteral(resourceName: "purpleFogBG"))
        background.frame = view.frame
        self.view.addSubview(background)
        
        whiteBoxInBackground = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.151, width: view.frame.width, height: view.frame.height * 0.542))
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
        view.addSubview(xButton)
    }
    
    func makePictureButton() {
        pictureButton = UIButton()
        pictureButton.frame = CGRect(x: 0.338 * view.frame.width, y: 0.313 * view.frame.height, width: 0.323 * view.frame.width, height: 0.186 * view.frame.height)
        pictureButton.setImage(#imageLiteral(resourceName: "selectNewPhoto"), for: .normal)
        pictureButton.contentMode = .scaleAspectFit
        view.addSubview(pictureButton)
    }
    
    func makeCreateButton() {
        createButton = UIButton()
        createButton.frame = CGRect(x: 0, y: 0.605 * view.frame.height, width: view.frame.width, height: 0.075 * view.frame.height)
        createButton.titleLabel?.font = UIFont(name: "SFUIText-Light", size: 20 )
        createButton.setTitle("Create Group", for: .normal)
        createButton.setTitleColor(.white, for: .normal)
        createButton.titleLabel?.textAlignment = .center
        createButton.layer.cornerRadius = 3
        createButton.backgroundColor = constants.mediumBlue
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
    
    func makeCodeTextField() {
        codeTextField = UITextField()
        codeTextField.frame = CGRect(x: 0, y: view.frame.height * 0.523, width: view.frame.width, height: 0.068 * view.frame.height)
        codeTextField.font = UIFont(name: "SFUIText-Light", size: 18)
        codeTextField.placeholder = "Access code"
        codeTextField.isSecureTextEntry = true
        codeTextField.autocorrectionType = .no
        codeTextField.textAlignment = .center
        codeTextField.backgroundColor = UIColor.white
        codeTextField.layer.borderWidth = 0.75
        codeTextField.layer.cornerRadius = 3
        codeTextField.layer.borderColor = constants.fontLightGray.cgColor
        view.addSubview(codeTextField)
    }
    
    
    
    
    
}
