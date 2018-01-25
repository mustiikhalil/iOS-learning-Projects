//
//  Image+CoreDataProperties.swift
//  WishList
//
//  Created by Mustafa Khalil on 2/11/17.
//  Copyright © 2017 Mustafa Khalil. All rights reserved.
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image");
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var toItem: Item?
    @NSManaged public var toStore: Store?

}
