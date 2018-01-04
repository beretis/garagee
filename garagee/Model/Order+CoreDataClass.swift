//
//  Order+CoreDataClass.swift
//  
//
//  Created by Jozef Matus on 29/12/2017.
//
//

import Foundation
import CoreData

@objc(Order)
public class Order: NSManagedObject, AutoDTO {


// sourcery:inline:auto:Order.DTOTemplate
    convenience init(dto: OrderDTO, context: NSManagedObjectContext) {
    self.init(context: context)
    self.createdAt = dto.createdAt
    self.id = dto.id
    self.name = dto.name
    self.repeatIntervalDays = dto.repeatIntervalDays
    self.subject = dto.subject
    self.car = dto.car
    self.customer = dto.customer
    self.usedParts = Set<Part>(dto.usedParts.map { Part.init(dto: $0, context: context) })
}
// sourcery:file:Order.dto.swift
// sourcery:end
}
