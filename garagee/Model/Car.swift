//
//  Car.swift
//  garagee
//
//  Created by Jozef Matus on 22/04/2017.
//  Copyright © 2017 Jozef Matus. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import CoreData

struct Car {
    var id: String
    var aditionalInfo: String
    var brand: String
    var color: String
    var firstRegistration: Data
    var lastService: Date
    var milage: Int
    var model: String
    var productionDate: Date
    var techInspection: Date
    var type: String
}

extension Car: Persistable {
 
    public typealias T = NSManagedObject
    
    static var entityName: String = "Order"
    
    static var primaryAttributeName: String = "id"
    
    init(entity: T) {
        
    }
    
    func update(_ entity: NSManagedObject) {
        
    }
}
