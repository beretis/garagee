//
//  Car+CoreDataProperties.swift
//  
//
//  Created by Jozef Matus on 29/12/2017.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var brand: String
    @NSManaged public var color: String?
    @NSManaged public var firstRegistration: Date
    @NSManaged public var id: String
    @NSManaged public var lastService: Date?
    @NSManaged public var milage: Int32
    @NSManaged public var model: String
    @NSManaged public var fuel: String
    @NSManaged public var productionDate: Date?
    @NSManaged public var techInspection: Date?
    @NSManaged public var engine: String?
	///sourcery: toMany = "Order"
    @NSManaged public var orders: Set<Order>
    @NSManaged public var owner: Customer?

}

// MARK: Generated accessors for orders
extension Car {

    @objc(addOrdersObject:)
    @NSManaged public func addToOrders(_ value: Order)

    @objc(removeOrdersObject:)
    @NSManaged public func removeFromOrders(_ value: Order)

    @objc(addOrders:)
    @NSManaged public func addToOrders(_ values: NSSet)

    @objc(removeOrders:)
    @NSManaged public func removeFromOrders(_ values: NSSet)

}
