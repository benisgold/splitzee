//
//  DetailViewController.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/16/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var background: UIImageView!
    var groupPicture: UIImageView!
    var backButton: UIButton!
    var amountLabel: UILabel!
    var descriptionLabel: UILabel!
    var rejectButton: UIButton!
    var approveButton: UIButton!
    let constants = Constants()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBackground()
        makeNavBar()
        makeGroupPicture()
        makeBackButton()
        makeAmountLabel()
        makeDescriptionLabel()
        makeRejectButton()
        makeApproveButton()
    }
    
    func addBackground() {
        background = UIImageView(image: #imageLiteral(resourceName: "whiteBlueGradientBG"))
        background.frame = view.frame
        self.view.addSubview(background)
    }
    
    func makeNavBar() {
        self.title = "What's going on?" // change to group name
    }
    
    func makeGroupPicture() {
        groupPicture = UIImageView()
        groupPicture.frame = CGRect(x: 0.337 * view.frame.width, y: 0.135 * view.frame.height, width: 0.327 * view.frame.width, height: 0.327 * view.frame.width)
        groupPicture.contentMode = .scaleAspectFill
        groupPicture.layer.cornerRadius = 0.5 * groupPicture.frame.size.width
        groupPicture.clipsToBounds = true
        groupPicture.image = #imageLiteral(resourceName: "selectNewPhoto")
        view.addSubview(groupPicture)
    }
    
    func makeBackButton() {
        backButton = UIButton()
        backButton.frame = CGRect(x: 0.043 * view.frame.width, y: 0.291 * view.frame.height, width: 0.063 * view.frame.width, height: 0.031 * view.frame.height)
        backButton.setTitle("<-", for: .normal)
        backButton.setTitleColor(constants.fontMediumDarkBlue, for: .normal)
        view.addSubview(backButton)
    }
    
    func makeAmountLabel() {
        amountLabel = UILabel()
        amountLabel.frame = CGRect(x: 0, y: 0.342 * view.frame.height, width: view.frame.width, height: 0.061 * view.frame.height)
        amountLabel.text = "Dollar amount here"
        amountLabel.textAlignment = .center
        amountLabel.textColor = constants.fontMediumBlue
        amountLabel.layer.borderWidth = 0.5
        amountLabel.layer.borderColor = constants.fontLightGray.cgColor
        view.addSubview(amountLabel)
    }
    
    func makeDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.frame = CGRect(x: 0, y: 0.404 * view.frame.height, width: view.frame.width, height: 0.164 * view.frame.height)
        descriptionLabel.text = "Description here"
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 5
        descriptionLabel.textColor = constants.fontDarkGray
        view.addSubview(descriptionLabel)
    }
    
    func makeApproveButton() {
        approveButton = UIButton(frame: CGRect(x: view.frame.width * 0.5, y: view.frame.height * 0.569, width: view.frame.width * 0.490, height: view.frame.height * 0.075))
        approveButton.setImage(#imageLiteral(resourceName: "approveAction"), for: .normal)
        view.addSubview(approveButton)
    }
    
    func makeRejectButton() {
        approveButton = UIButton(frame: CGRect(x: view.frame.width * 0.012, y: view.frame.height * 0.569, width: view.frame.width * 0.490, height: view.frame.height * 0.075))
        approveButton.setImage(#imageLiteral(resourceName: "rejectAction"), for: .normal)
        view.addSubview(approveButton)
    }
    
}
