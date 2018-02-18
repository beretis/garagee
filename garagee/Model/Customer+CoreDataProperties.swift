//
//  Customer+CoreDataProperties.swift
//  
//
//  Created by Jozef Matus on 29/12/2017.
//
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var id: String
    @NSManaged public var lastName: String?
    @NSManaged public var phoneNumber: String?
	///sourcery: toMany = "Car"
    @NSManaged public var cars: Set<Car>

}

// MARK: Generated accessors for cars
extension Customer {

    @objc(addCarsObject:)
    @NSManaged public func addToCars(_ value: Car)

    @objc(removeCarsObject:)
    @NSManaged public func removeFromCars(_ value: Car)

    @objc(addCars:)
    @NSManaged public func addToCars(_ values: NSSet)

    @objc(removeCars:)
    @NSManaged public func removeFromCars(_ values: NSSet)

}
