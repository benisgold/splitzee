//
//  AdminHistoryTableViewCell.swift
//  Splitzee
//
//  Created by Ben Goldberg on 11/17/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit

class AdminHistoryTableViewCell: UITableViewCell {
    
    var memberPicView: UIImageView!
    var memberNameLabel: UILabel!
    var descriptionLabel: UILabel!
    var amountLabel: UILabel!
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
    
    func makeResultLabel() {
        amountLabel = UILabel()
        amountLabel.frame = CGRect(x: 0.248 * contentView.frame.width, y: 0.633 * contentView.frame.height, width: 0.696 * contentView.frame.width, height: 0.291 * contentView.frame.height)
        amountLabel.layer.borderColor = constants.lightBlue.cgColor
        amountLabel.textColor = constants.fontMediumDarkBlue
        amountLabel.font = UIFont(name: "SFUIText-Medium", size: 14)
        amountLabel.textAlignment = .center
        amountLabel.layer.cornerRadius = 3
        contentView.addSubview(amountLabel)
    }
    
}
