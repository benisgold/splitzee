//
//  SideBarCollectionViewCell.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/20/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit

class SideBarTableViewCell: UITableViewCell {
    
    var label: UILabel!
    var name: UILabel!
    var options: UILabel!
    let constants = Constants()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    func setupCell() {
        contentView.backgroundColor = UIColor.clear
        
        // Label
        label = UILabel()
        label.frame = CGRect(x: 17, y: 0, width: contentView.frame.width/5, height: contentView.frame.height)
        label.textColor = constants.fontWhite
        label.font = UIFont(name: "SFUIText-Light", size: 14)
        contentView.addSubview(label)
        
        // Name
        name = UILabel()
        name.frame = CGRect(x: 25 + contentView.frame.width/7, y: 0, width: contentView.frame.width/1.3, height: contentView.frame.height)
        name.textColor = constants.fontWhite
        name.font = UIFont(name: "SFUIText-Regular", size: 17)
        contentView.addSubview(name)
        
        
    }
    
    
    
}
