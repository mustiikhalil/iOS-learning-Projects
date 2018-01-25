//
//  WishListCell.swift
//  WishList
//
//  Created by Mustafa Khalil on 2/11/17.
//  Copyright © 2017 Mustafa Khalil. All rights reserved.
//

import UIKit

class WishListCell: UITableViewCell {
    
    
    @IBOutlet weak var wishTitle: UILabel!
    
    @IBOutlet weak var wishPrice: UILabel!
    
    @IBOutlet weak var wishDetails: UILabel!
    
    @IBOutlet weak var wishImage: RoundedImages!

    
    func UIupdate(item: Item){
    
        wishTitle.text = item.title
        wishPrice.text = "$\(item.price)"
        wishDetails.text = item.details
        if let image = item.toImage?.image as? UIImage{
            wishImage.image  = image
        }
    }
}
