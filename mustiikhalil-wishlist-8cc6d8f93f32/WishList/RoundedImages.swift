//
//  CellImages.swift
//  WishList
//
//  Created by Mustafa Khalil on 2/12/17.
//  Copyright © 2017 Mustafa Khalil. All rights reserved.
//

import UIKit

class RoundedImages: UIImageView {

    override func awakeFromNib() {
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }

}
