//
//  AdminCollectionViewCell.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/16/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit

class AdminPendingTableViewCell: UITableViewCell {
    
    var memberPicView: UIImageView!
    var memberNameLabel: UILabel!
    var descriptionLabel: UILabel!
    var rejectButton: UIButton!
    var approveButton: UIButton!
    let constants = Constants()
    
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
        memberPicView.frame = CGRect(x: 0.041 * contentView.frame.width, y: 0.155 * contentView.frame.height, width: 0.188 * contentView.frame.width, height: 0.188 * contentView.frame.width)
        contentView.addSubview(memberPicView)
    }
    
    func makeMemberNameLabel() {
        memberNameLabel = UILabel()
        memberNameLabel.frame = CGRect(x: 0.251 * contentView.frame.width, y: 0.082 * contentView.frame.height, width: 0.176 * contentView.frame.width, height: 0.173 * contentView.frame.height)
        memberNameLabel.textColor = constants.fontMediumDarkBlue
        memberNameLabel.font = UIFont(name: "SFUIText-Semibold", size: 16)
        contentView.addSubview(memberNameLabel)
    }
    
    func makeDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.frame = CGRect(x: 0.251 * contentView.frame.width, y: 0.273 * contentView.frame.height, width: 0.696 * contentView.frame.width, height: 0.291 * contentView.frame.height)
        descriptionLabel.textColor = constants.fontMediumDarkBlue
        memberNameLabel.font = UIFont(name: "SFUIText-LightItalic", size: 14)
        contentView.addSubview(descriptionLabel)
    }
    
    func makeRejectButton() {
        rejectButton = UIButton()
        rejectButton.frame = CGRect(x: 0.248 * contentView.frame.width, y: 0.633 * contentView.frame.height, width: 0.340 * contentView.frame.width, height: 0.291 * contentView.frame.height)
        rejectButton.layer.borderColor = constants.lightBlue.cgColor
        rejectButton.titleLabel?.textColor = constants.fontMediumDarkBlue
        rejectButton.titleLabel?.font = UIFont(name: "SFUIText-Medium", size: 14)
        rejectButton.layer.cornerRadius = 3
        contentView.addSubview(rejectButton)
    }
    
    func makeApproveButton() {
        approveButton = UIButton()
        approveButton.frame = CGRect(x: 0.603 * contentView.frame.width, y: 0.633 * contentView.frame.height, width: 0.340 * contentView.frame.width, height: 0.291 * contentView.frame.height)
        approveButton.titleLabel?.textColor = UIColor.white
        approveButton.titleLabel?.font = UIFont(name: "SFUIText-Medium", size: 14)
        approveButton.layer.cornerRadius = 3
        contentView.addSubview(approveButton)
    }
    
    
    
}
