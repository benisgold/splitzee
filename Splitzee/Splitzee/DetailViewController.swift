//
//  DetailViewController.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/16/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var groupPicture: UIImageView!
    var backButton: UIButton!
    var amountLabel: UILabel!
    var descriptionLabel: UILabel!
    var rejectButton: UIButton!
    var approveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeNavBar()
        makeGroupPicture()
        makeBackButton()
        makeAmountLabel()
        makeDescriptionLabel()
        makeRejectButton()
        makeApproveButton()
    }
    
    func makeNavBar() {
        let navBar = UINavigationBar()
        navBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.111)
        navBar.backgroundColor = UIColor.white
        let navTitle = UINavigationItem(title: "What's going on?") // change to group name
        navBar.setItems([navTitle], animated: false)
        view.addSubview(navBar)
    }
    
    func makeGroupPicture() {
        groupPicture = UIImageView()
        groupPicture.frame = CGRect(x: 0.337 * view.frame.width, y: 0.135 * view.frame.height, width: 0.327 * view.frame.width, height: 0.327 * view.frame.width)
        groupPicture.image = UIImage(named: "")
        view.addSubview(groupPicture)
    }
    
    func makeBackButton() {
        backButton = UIButton()
        backButton.frame = CGRect(x: 0.043 * view.frame.width, y: 0.291 * view.frame.height, width: 0.063 * view.frame.width, height: 0.031 * view.frame.height)
        view.addSubview(backButton)
    }
    
    func makeAmountLabel() {
        amountLabel = UILabel()
        amountLabel.frame = CGRect(x: 0, y: 0.342 * view.frame.height, width: view.frame.width, height: 0.061 * view.frame.height)
        amountLabel.text = "Dollar amount here (fix me)"
        amountLabel.textAlignment = .center
        view.addSubview(amountLabel)
    }
    
    func makeDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.frame = CGRect(x: 0, y: 0.404 * view.frame.height, width: view.frame.width, height: 0.164 * view.frame.height)
        descriptionLabel.text = "Description here (fix me)"
        descriptionLabel.textAlignment = .center    // Centered or not???
        view.addSubview(descriptionLabel)
    }
    
    func makeApproveButton() {
        
    }
    
    func makeRejectButton() {
        
    }
    
}
