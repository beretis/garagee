//
//  Part+CoreDataClass.swift
//  
//
//  Created by Jozef Matus on 29/12/2017.
//
//

import Foundation
import CoreData

@objc(Part)
public class Part: NSManagedObject, AutoDTO {


// sourcery:inline:auto:Part.DTOTemplate
    convenience init(dto: PartDTO, context: NSManagedObjectContext) {
    self.init(context: context)
    self.brand = dto.brand
    self.code = dto.code
    self.name = dto.name
    self.price = dto.price
    self.warrantyDays = dto.warrantyDays
    self.orders = Set<Order>(dto.orders.map { Order.init(dto: $0, context: context) })
}

func createDTO() -> PartDTO {
	return PartDTO(brand: brand , code: code , name: name , price: price , warrantyDays: warrantyDays , orders: Array(self.orders.map { $0.createDTO() }) )
}

// sourcery:file:Part.dto.swift
// sourcery:end
}
