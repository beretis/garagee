//
//  Part+CoreDataProperties.swift
//  
//
//  Created by Jozef Matus on 12/02/2018.
//
//

import Foundation
import CoreData


extension Part {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Part> {
        return NSFetchRequest<Part>(entityName: "Part")
    }

    @NSManaged public var brand: String
    @NSManaged public var code: String
    @NSManaged public var name: String
    @NSManaged public var price: Int64
    @NSManaged public var warrantyDays: Int16
    ///sourcery: toMany = "Order"
    @NSManaged public var orders: Set<Order>

}

// MARK: Generated accessors for orders
extension Part {

    @objc(addOrdersObject:)
    @NSManaged public func addToOrders(_ value: Order)

    @objc(removeOrdersObject:)
    @NSManaged public func removeFromOrders(_ value: Order)

    @objc(addOrders:)
    @NSManaged public func addToOrders(_ values: NSSet)

    @objc(removeOrders:)
    @NSManaged public func removeFromOrders(_ values: NSSet)

}
