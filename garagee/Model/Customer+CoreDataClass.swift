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
}

 func createDTO() -> CustomerDTO {
    return CustomerDTO(email: email , firstName: firstName , id: id , lastName: lastName , phoneNumber: phoneNumber , cars: Array(self.cars.map { $0.createDTO() }) )
}


// sourcery:file:Customer.dto.swift
// sourcery:end
}
