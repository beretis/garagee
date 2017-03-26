//
//  Testt.swift
//  pexeso
//
//  Created by Jozef Matus on 17/02/17.
//  Copyright © 2017 o2. All rights reserved.
//

import UIKit
import CoreData

//class Zmrd: NSManagedObject {
//
//    @NSManaged var id: String
//    @NSManaged var value: String
//    @NSManaged var mamrd: Mamrd?
//
//    
//    convenience init(id: String, value: String) {
//        self.init(entity: NSEntityDescription.entity(forEntityName: "Zmrd", in: coreDataStack.managedObjectContext)!, insertInto: coreDataStack.managedObjectContext)
//        self.id = id
//        self.value = value
//        self.mamrd = nil
//    }
//    
//}


struct Zmrd {
    var id: String
    var value: String
    var mamrd: ToOneRelationship<Mamrd> = ToOneRelationship<Mamrd>(key:"mamrd")
    
    init(id: String, value: String) {
        self.id = id
        self.value = value
    }
    
}

extension Zmrd: Persistable {
    public typealias T = NSManagedObject
    
    public static var entityName: String {
        return "Zmrd"
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
        print(entity)
        if let mamrdEntity = entity.value(forKey: "mamrd") as? Mamrd.T {
            self.mamrd.setValue(mamrdEntity)
        }
    }
    
    func update(_ entity: NSManagedObject) {
        entity.setValue(self.id, forKey: "id")
        entity.setValue(self.value, forKey: "value")
        self.mamrd.save(ToEntity: entity)
    }
}

extension Zmrd: Equatable {}

func ==(lhs: Zmrd, rhs: Zmrd) -> Bool {
    return lhs.identity == rhs.identity
}

extension Zmrd: Hashable {
    public var hashValue: Int { return self.id.hashValue }
}
