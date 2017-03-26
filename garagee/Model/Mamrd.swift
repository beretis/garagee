//
//  Test.swift
//  pexeso
//
//  Created by Jozef Matus on 17/02/17.
//  Copyright © 2017 o2. All rights reserved.
//

import UIKit
import CoreData

struct Mamrd {
    var id: String
    var value: String
    var zmrdi: TooManyRelationship<Zmrd> = TooManyRelationship<Zmrd>(key: "zmrdi")
    
    init(id: String, value: String) {
        self.id = id
        self.value = value
    }
}

extension Mamrd: Persistable {
    public typealias T = NSManagedObject
    
    public static var entityName: String {
        return "Mamrd"
    }
    
    public static var primaryAttributeName: String {
        return "id"
    }
    
    var identity: String {
        return id
    }
    
    init(entity: T) {
        self.id = entity.value(forKey: "id") as! String
        self.value = entity.value(forKey: "value") as! String
        if let zmrdiEntities = entity.value(forKey: "zmrdi") as? Set<Zmrd.T>, zmrdiEntities.count > 0 {
            self.zmrdi.setValue(zmrdiEntities)
        }
    }
    
    func update(_ entity: NSManagedObject) {
        entity.setValue(self.id, forKey: "id")
        entity.setValue(self.value, forKey: "value")
        self.zmrdi.save(ToEntity: entity)
    }
    
}
