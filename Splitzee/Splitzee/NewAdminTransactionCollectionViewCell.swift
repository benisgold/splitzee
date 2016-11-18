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
        userImage = UIImageView(image: #imageLiteral(resourceName: "purpleGradientDarkBG") )
        userImage.frame = CGRect(x: 0.205 * contentView.frame.width, y: 0.234 * contentView.frame.height , width: 0.589 * contentView.frame.width, height: 0.589 * contentView.frame.height)
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = 0.5 * userImage.frame.size.width
        userImage.clipsToBounds = true
        contentView.addSubview(userImage)
        
        
        //User's name
        userName = UILabel(frame: CGRect(x: 0.190 * contentView.frame.width , y: 0.871 * contentView.frame.height, width: 0.620*contentView.frame.width , height: 0.103 * contentView.frame.height ))
        userName.text = "User's name" // Should be get the actual users name
        userName.textAlignment = .center
        userName.textColor = UIColor.white
        contentView.addSubview(userName)
        
        
        
        
    }
    
}
