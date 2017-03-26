//
//  Persistable+Convience.swift
//  garagee
//
//  Created by Jozef Matus on 22/03/17.
//  Copyright © 2017 Jozef Matus. All rights reserved.
//

import Foundation
import CoreData

var counter = 0

extension Array where Element: Persistable {
    //be aware that this saves the data to core data....
    func toEntitySet(context: NSManagedObjectContext = coreDataStack.managedObjectContext) -> Set<Element.T> {
        let entityArray = self.map{ persistable -> Element.T in
            let emptyEntity = context.getOrCreateEntity(for: persistable)
            persistable.update(emptyEntity)
            return emptyEntity
        }
        return Set<Element.T>(entityArray)
    }
}

extension Set where Element: Persistable {
    func toEntitySet(context: NSManagedObjectContext = coreDataStack.managedObjectContext) -> Set<Element.T> {
        let entityArray = self.map{ persistable -> Element.T in
            let emptyEntity = context.getOrCreateEntity(for: persistable)
            persistable.update(emptyEntity)
            return emptyEntity
        }
        return Set<Element.T>(entityArray)
    }
}

extension Persistable {
    func toEntity(context: NSManagedObjectContext = coreDataStack.managedObjectContext) -> Self.T {
        let entity = context.getOrCreateEntity(for: self)
        self.update(entity)
        return entity
    }
    
    static func fetch(WithId id: String, context: NSManagedObjectContext = coreDataStack.managedObjectContext) -> Self? {
        let persistable: Self? = try? context.fetchPersistable(identifier: id)
        return persistable ?? nil
    }
    
    static func fetchAll(context: NSManagedObjectContext = coreDataStack.managedObjectContext) -> [Self] {
        let result: [Self]? = try? context.fetchPersistables()
        return result ?? []
    }
    
}

