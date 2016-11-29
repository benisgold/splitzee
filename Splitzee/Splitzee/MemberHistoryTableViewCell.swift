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
    var descriptionLabel: UILabel!
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
        memberPicView.frame = CGRect(x: 0.005 * contentView.frame.width, y: 0.005 * contentView.frame.height, width: 0.990 * contentView.frame.height, height: 0.990 * contentView.frame.height)
        memberPicView.image = #imageLiteral(resourceName: "purpleFogBG")
        memberPicView.clipsToBounds = true
        memberPicView.contentMode = .scaleAspectFill
        memberPicView.layer.cornerRadius = 0.5 * 0.990 * contentView.frame.height
        contentView.addSubview(memberPicView)
    }
    
    func makeMemberNameLabel() {
        memberNameLabel = UILabel()
        memberNameLabel.frame = CGRect(x: 0.115 * contentView.frame.width, y: 0.082 * contentView.frame.height, width: 0.581 * contentView.frame.width, height: 0.331 * contentView.frame.height)
        memberNameLabel.textColor = constants.fontMediumDarkBlue
        memberNameLabel.font = UIFont(name: "SFUIText-Semibold", size: 15)
        contentView.addSubview(memberNameLabel)
    }
    
    func makeDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.frame = CGRect(x: 0.115 * contentView.frame.width, y: 0.418 * contentView.frame.height, width: 0.581 * contentView.frame.width, height: 0.577 * contentView.frame.height)
        descriptionLabel.textColor = constants.fontMediumDarkBlue
        descriptionLabel.font = UIFont(name: "SFUIText-LightItalic", size: 14)
        contentView.addSubview(descriptionLabel)
    }
    
    func makeResultLabel() {
        resultLabel = UILabel()
        resultLabel.frame = CGRect(x: 0.701 * contentView.frame.width, y: 0.155 * contentView.frame.height, width: 0.294 * contentView.frame.width, height: 0.69 * contentView.frame.height)
        resultLabel.layer.borderColor = constants.lightBlue.cgColor
        resultLabel.textColor = constants.fontMediumDarkBlue
        resultLabel.font = UIFont(name: "SFUIText-Medium", size: 20)
        resultLabel.textAlignment = .center
        resultLabel.layer.cornerRadius = 3
        contentView.addSubview(resultLabel)
    }
    
}
