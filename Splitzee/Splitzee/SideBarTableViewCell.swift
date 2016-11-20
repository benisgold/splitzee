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
        
        // I have some stuff I'm working on rn so I left what is fine
        
        // Label
        label.frame = CGRect(x: 5, y: contentView.frame.height/2, width: contentView.frame.width/5, height: contentView.frame.height)
        label.textColor = constants.fontWhite
        label.font = UIFont(descriptor: "SFUIText-Light", size: <#T##CGFloat#>)
        contentView.addSubview(label)
        
        // Name
        name.frame = CGRect(x: 5 + contentView.frame.width/5, y: contentView.frame.height, width: contentView.frame.width/1.3, height: contentView.frame.height)
        name.frame = constants.fontWhite
        contentView.addSubview(name)
        
        // Options
        options.frame = CGRect(x: contentView.frame.width - 10, y: contentView.frame.height, width: 20, height: contentView.frame.height)
        options.frame = constants.fontWhite
        contentView.addSubview(options)
        
        
        
        
    }
    
    
    
}
