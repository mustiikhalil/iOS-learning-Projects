//
//  Item+CoreDataClass.swift
//  WishList
//
//  Created by Mustafa Khalil on 2/11/17.
//  Copyright © 2017 Mustafa Khalil. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }
}
