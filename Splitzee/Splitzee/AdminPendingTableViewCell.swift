//
//  AdminCollectionViewCell.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/16/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AdminPendingTableViewCell: UITableViewCell {
    
    var memberPicView: UIImageView!
    var memberNameLabel: UILabel!
    var descriptionLabel: UILabel!
    var rejectButton: UIButton!
    var approveButton: UIButton!
    let constants = Constants()
    let rootRef = FIRDatabase.database().reference()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        makeMemberPicView()
        makeMemberNameLabel()
        makeDescriptionLabel()
        makeRejectButton()
        makeApproveButton()
    }
    
    func makeMemberPicView() {
        memberPicView = UIImageView()
        memberPicView.frame = CGRect(x: 0.05 * contentView.frame.width, y: 0.05 * contentView.frame.height, width: 0.900 * contentView.frame.height, height: 0.900 * contentView.frame.height)
        memberPicView.clipsToBounds = true
        memberPicView.contentMode = .scaleAspectFill
        memberPicView.layer.cornerRadius = 0.5 * 0.900 * contentView.frame.height
        contentView.addSubview(memberPicView)
    }
    
    func makeMemberNameLabel() {
        memberNameLabel = UILabel()
        memberNameLabel.frame = CGRect(x: 0.251 * contentView.frame.width, y: 0.082 * contentView.frame.height, width: 0.749 * contentView.frame.width, height: 0.331 * contentView.frame.height)
        memberNameLabel.textColor = constants.fontMediumDarkBlue
        memberNameLabel.font = UIFont(name: "SFUIText-Semibold", size: 14)
        memberNameLabel.text = "Member Name"
        contentView.addSubview(memberNameLabel)
    }
    
    func makeDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.frame = CGRect(x: 0.251 * contentView.frame.width, y: 0.336 * contentView.frame.height, width: 0.696 * contentView.frame.width, height: 0.331 * contentView.frame.height)
        descriptionLabel.textColor = UIColor.blue
        descriptionLabel.textColor = constants.fontMediumDarkBlue
        descriptionLabel.font = UIFont(name: "SFUIText-LightItalic", size: 12)
        descriptionLabel.text = "Description"
        contentView.addSubview(descriptionLabel)
    }
    
    func makeRejectButton() {
        rejectButton = UIButton()
        rejectButton.frame = CGRect(x: 0.248 * contentView.frame.width, y: 0.672 * contentView.frame.height, width: 0.340 * contentView.frame.width, height: 0.328 * contentView.frame.height)
        rejectButton.setTitle("Reject", for: .normal)
        rejectButton.layer.borderColor = UIColor.blue.cgColor
        rejectButton.layer.borderColor = constants.lightBlue.cgColor
        rejectButton.titleLabel?.textColor = constants.fontMediumDarkBlue
        rejectButton.titleLabel?.font = UIFont(name: "SFUIText-Medium", size: 10)
        rejectButton.layer.cornerRadius = 3
        contentView.addSubview(rejectButton)
    }
    
    func makeApproveButton() {
        approveButton = UIButton()
        approveButton.frame = CGRect(x: 0.603 * contentView.frame.width, y: 0.672 * contentView.frame.height, width: 0.340 * contentView.frame.width, height: 0.328 * contentView.frame.height)
        approveButton.titleLabel?.textColor = UIColor.white
        approveButton.titleLabel?.font = UIFont(name: "SFUIText-Medium", size: 10)
        approveButton.layer.cornerRadius = 3
        approveButton.setTitle("APPROVE!!", for: .normal)
        approveButton.backgroundColor = constants.red
        contentView.addSubview(approveButton)
    }
    
}
 
