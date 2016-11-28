//
//  NewAdminTransactionCollectionViewCell.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/17/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit

class NewAdminTransactionCollectionViewCell: UICollectionViewCell {
    
    var userImage: UIImageView!
    var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
        
    }
    
    
    func setUpUI() {
        
        //User's image
        userImage = UIImageView()
        userImage.frame = CGRect(x: 15, y: 60 , width: 95, height: 95)
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = 0.5 * userImage.frame.size.width
        userImage.clipsToBounds = true
        contentView.addSubview(userImage)
        
        
        //User's name
        userName = UILabel()
        userName = UILabel(frame: CGRect(x: userImage.frame.minX , y: userImage.frame.maxY + 3, width: userImage.frame.width , height: 30))
        userName.textAlignment = .center
        userName.textColor = UIColor.white
        userName.textColor = UIColor.black
        contentView.addSubview(userName)
        
    }
    
}
