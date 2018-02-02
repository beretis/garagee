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
    self.id = dto.id
    self.name = dto.name
    self.price = dto.price
    self.warrantyDays = dto.warrantyDays
    self.order = dto.order
}
// sourcery:file:Part.dto.swift
// sourcery:end
}
