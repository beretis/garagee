//
//  Order+CoreDataProperties.swift
//  
//
//  Created by Jozef Matus on 29/12/2017.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var repeatIntervalDays: Int
    @NSManaged public var subject: String?
    @NSManaged public var car: Car?
    @NSManaged public var customer: Customer?
	///sourcery: toMany = "Part"
    @NSManaged public var usedParts: Set<Part>

}

// MARK: Generated accessors for usedParts
extension Order {

    @objc(addUsedPartsObject:)
    @NSManaged public func addToUsedParts(_ value: Part)

    @objc(removeUsedPartsObject:)
    @NSManaged public func removeFromUsedParts(_ value: Part)

    @objc(addUsedParts:)
    @NSManaged public func addToUsedParts(_ values: NSSet)

    @objc(removeUsedParts:)
    @NSManaged public func removeFromUsedParts(_ values: NSSet)

}
