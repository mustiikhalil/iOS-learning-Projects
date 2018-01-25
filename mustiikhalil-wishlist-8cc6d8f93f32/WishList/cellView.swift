//
//  cellView.swift
//  WishList
//
//  Created by Mustafa Khalil on 2/12/17.
//  Copyright © 2017 Mustafa Khalil. All rights reserved.
//

import UIKit

class cellView: UIView {
    override func awakeFromNib() {
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        self.layer.cornerRadius = 8.0
        self.layer.shadowRadius = 10.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.black.cgColor
        
    }
}
