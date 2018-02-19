//
//  Car+CoreDataClass.swift
//  
//
//  Created by Jozef Matus on 29/12/2017.
//
//

import Foundation
import CoreData

@objc(Car)
public class Car: NSManagedObject, AutoDTO {


// sourcery:inline:auto:Car.DTOTemplate
    convenience init(dto: CarDTO, context: NSManagedObjectContext) {
    self.init(context: context)
    self.brand = dto.brand
    self.color = dto.color
    self.firstRegistration = dto.firstRegistration
    self.id = dto.id
    self.lastService = dto.lastService
    self.milage = dto.milage
    self.model = dto.model
    self.fuel = dto.fuel
    self.productionDate = dto.productionDate
    self.techInspection = dto.techInspection
    self.engine = dto.engine
    self.orders = Set<Order>(dto.orders.map { Order.init(dto: $0, context: context) })
    self.owner = dto.owner
}

 func createDTO() -> CarDTO {
    return CarDTO(brand: brand , color: color , firstRegistration: firstRegistration , id: id , lastService: lastService , milage: milage , model: model , fuel: fuel , productionDate: productionDate , techInspection: techInspection , engine: engine , orders: Array(self.orders.map { $0.createDTO() }) , owner: owner )
}


// sourcery:file:Car.dto.swift
// sourcery:end
}
