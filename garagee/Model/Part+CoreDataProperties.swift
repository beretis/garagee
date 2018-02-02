//
//  Part+CoreDataProperties.swift
//  
//
//  Created by Jozef Matus on 29/12/2017.
//
//

import Foundation
import CoreData


extension Part {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Part> {
        return NSFetchRequest<Part>(entityName: "Part")
    }

    @NSManaged public var brand: String
    @NSManaged public var code: String?
    @NSManaged public var id: String
    @NSManaged public var name: String
	@NSManaged public var price: Int
    @NSManaged public var warrantyDays: Int
    @NSManaged public var order: Order?

}
