//
//  Basket+CoreDataProperties.swift
//  CodeRedStore
//
//  Created by denisok on 16/03/2020.
//  Copyright © 2020 denisok. All rights reserved.
//
//

import Foundation
import CoreData


extension Basket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Basket> {
        return NSFetchRequest<Basket>(entityName: "Basket")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var count: Int32
    @NSManaged public var size: String?
    @NSManaged public var imageName: String?

}
