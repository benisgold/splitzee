//
//  CreateGroupViewController.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/16/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController {
    
    var xButton: UIButton!
    var pictureButton: UIButton!
    var createButton: UIButton!
    var nameTextField: UITextField!
    var codeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeXButton()
        makePictureButton()
        makeCreateButton()
        makeNameTextField()
        makeCodeTextField()
    }
    
    func makeXButton() {
        xButton = UIButton()
        xButton.frame = CGRect(x: 0.879 * view.frame.width, y: 0.175 * view.frame.height, width: 0.046 * view.frame.width, height: 0.046 * view.frame.width)
        xButton.setTitle("X", for: .normal)
        xButton.setTitleColor(.black, for: .normal)
        xButton.titleLabel?.textAlignment = .center
        view.addSubview(xButton)
    }
    
    func makePictureButton() {
        pictureButton = UIButton()
        pictureButton.frame = CGRect(x: 0.356 * view.frame.width, y: 0.398 * view.frame.height, width: 0.267 * view.frame.width, height: 0.043 * view.frame.height)
        pictureButton.setTitle("Select Group\nPhoto", for: .normal)
        pictureButton.titleLabel?.numberOfLines = 2
        pictureButton.setTitleColor(.black, for: .normal)
        pictureButton.titleLabel?.textAlignment = .center
        view.addSubview(pictureButton)
    }
    
    func makeCreateButton() {
        createButton = UIButton()
        createButton.frame = CGRect(x: 0, y: 0.605 * view.frame.height, width: view.frame.width, height: 0.075 * view.frame.height)
        createButton.setTitle("Create Group", for: .normal)
        createButton.setTitleColor(.black, for: .normal)
        createButton.titleLabel?.textAlignment = .center
        view.addSubview(createButton)
    }
    
    func makeNameTextField() {
        nameTextField = UITextField()
        nameTextField.frame = CGRect(x: 0, y: 0.218 * view.frame.height, width: view.frame.width, height: 0.068 * view.frame.height)
        nameTextField.placeholder = "Set Group Name"
        nameTextField.textAlignment = .center
        view.addSubview(nameTextField)
    }
    
    func makeCodeTextField() {
        codeTextField = UITextField()
        codeTextField.frame = CGRect(x: 0, y: 0.523 * view.frame.height, width: view.frame.width, height: 0.068 * view.frame.height)
        codeTextField.placeholder = "Set group access code"
        codeTextField.textAlignment = .center
        view.addSubview(codeTextField)
    }
    
}
