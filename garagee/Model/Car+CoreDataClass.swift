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
    self.aditionalInfo = dto.aditionalInfo
    self.brand = dto.brand
    self.color = dto.color
    self.firstRegistration = dto.firstRegistration
    self.id = dto.id
    self.lastService = dto.lastService
    self.milage = dto.milage
    self.model = dto.model
    self.productionDate = dto.productionDate
    self.techInspection = dto.techInspection
    self.type = dto.type
    self.orders = Set<Order>(dto.orders.map { Order.init(dto: $0, context: context) })
    self.owner = dto.owner
}

func createDTO() -> CarDTO {
	return CarDTO(aditionalInfo: aditionalInfo , brand: brand , color: color , firstRegistration: firstRegistration , id: id , lastService: lastService , milage: milage , model: model , productionDate: productionDate , techInspection: techInspection , type: type , orders: Array(self.orders.map { $0.createDTO() }) , owner: owner )
}

// sourcery:file:Car.dto.swift
// sourcery:end
}
