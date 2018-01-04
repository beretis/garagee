//
//  Customer+CoreDataClass.swift
//  
//
//  Created by Jozef Matus on 29/12/2017.
//
//

import Foundation
import CoreData

@objc(Customer)
public class Customer: NSManagedObject, AutoDTO {


// sourcery:inline:auto:Customer.DTOTemplate
    convenience init(dto: CustomerDTO, context: NSManagedObjectContext) {
    self.init(context: context)
    self.email = dto.email
    self.firstName = dto.firstName
    self.id = dto.id
    self.lastName = dto.lastName
    self.phoneNumber = dto.phoneNumber
    self.cars = Set<Car>(dto.cars.map { Car.init(dto: $0, context: context) })
    self.orders = Set<Order>(dto.orders.map { Order.init(dto: $0, context: context) })
}
// sourcery:file:Customer.dto.swift
// sourcery:end
}
