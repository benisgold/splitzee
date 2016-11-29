//
//  MemberHistoryTableViewCell.swift
//  Splitzee
//
//  Created by Ben Goldberg on 11/19/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit

class MemberHistoryTableViewCell: UITableViewCell {
    
    var memberPicView: UIImageView!
    var memberNameLabel: UILabel!
    var descriptionLabel: UITextView!
    var resultLabel: UILabel!
    let constants = Constants()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeMemberPicView()
        makeMemberNameLabel()
        makeDescriptionLabel()
        makeResultLabel()
    }
    
    func makeMemberPicView() {
        memberPicView = UIImageView()
        memberPicView.frame = CGRect(x: 0.015 * contentView.frame.width, y: 0.05 * contentView.frame.height, width: 0.9 * contentView.frame.height, height: 0.9 * contentView.frame.height)
        memberPicView.image = #imageLiteral(resourceName: "purpleFogBG")
        memberPicView.clipsToBounds = true
        memberPicView.contentMode = .scaleAspectFill
        memberPicView.layer.cornerRadius = 0.5 * 0.9 * contentView.frame.height
        contentView.addSubview(memberPicView)
    }
    
    func makeMemberNameLabel() {
        memberNameLabel = UILabel()
        memberNameLabel.frame = CGRect(x: contentView.frame.height + 0.02 * contentView.frame.width, y: 0.1 * contentView.frame.height, width: 0.571 * contentView.frame.width, height: 0.24 * contentView.frame.height)
        memberNameLabel.textColor = constants.fontMediumBlue
        memberNameLabel.font = UIFont(name: "SFUIText-Semibold", size: 14)
        contentView.addSubview(memberNameLabel)
    }
    
    func makeDescriptionLabel() {
        descriptionLabel = UITextView()
        descriptionLabel.frame = CGRect(x: contentView.frame.height + 0.01 * contentView.frame.width, y: 0.235 * contentView.frame.height, width: 0.565 * contentView.frame.width, height: 0.7 * contentView.frame.height)
        descriptionLabel.textColor = constants.fontMediumBlue
        descriptionLabel.font = UIFont(name: "SFUIText-LightItalic", size: 12)
        descriptionLabel.isUserInteractionEnabled = false
        descriptionLabel.isScrollEnabled = false
        descriptionLabel.isEditable = false
        descriptionLabel.backgroundColor = UIColor.clear
        contentView.addSubview(descriptionLabel)
    }
    
    func makeResultLabel() {
        resultLabel = UILabel()
        resultLabel.frame = CGRect(x: 0.701 * contentView.frame.width, y: 0.155 * contentView.frame.height, width: 0.294 * contentView.frame.width, height: 0.69 * contentView.frame.height)
        resultLabel.layer.borderColor = constants.lightBlue.cgColor
        resultLabel.textColor = constants.fontMediumBlue
        resultLabel.font = UIFont(name: "SFUIText-Medium", size: 20)
        resultLabel.textAlignment = .center
        resultLabel.layer.cornerRadius = 3
        contentView.addSubview(resultLabel)
    }
    
}
