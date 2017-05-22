//
//  Customer.swift
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

struct Customer {
    var id: String
    var email: String
    var firstItem: String
    var lastName: String
    var phoneNumber: String
    
}

extension Customer: Persistable {
    
    public typealias T = NSManagedObject
    
    static var entityName: String = "Order"
    
    static var primaryAttributeName: String = "id"
    
    init(entity: T) {
        
    }
    
    func update(_ entity: NSManagedObject) {
        
    }
}
