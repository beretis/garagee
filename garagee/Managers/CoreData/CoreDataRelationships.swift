//
//  CoreDataRelationships.swift
//  garagee
//
//  Created by Jozef Matus on 22/03/17.
//  Copyright © 2017 Jozef Matus. All rights reserved.
//

import Foundation
import CoreData
import RxDataSources
import RxSwift
import RxCocoa

public struct ToOneRelationship<P> where P:Persistable {
    let key: String
    private var persistable: P?
    
    mutating func setValue(_ newValue: P) {
        self.persistable = newValue
    }
    
    mutating func setValue(_ newValue: P.T) {
        self.persistable = P(entity: newValue)
    }
    
    func value() -> P? {
        return persistable
    }
    
    func update(ToEntity entity: P.T) {
        guard self.persistable != nil else { return }
        self.save(ToEntity: entity)
    }
    
    func save(ToEntity entity: P.T) {
        guard self.persistable != nil else { return }
        entity.setValue(self.persistable!.toEntity(), forKey: key)
    }
    
    init(key: String) {
        self.key = key
    }
    
    init(persistable: P, key: String) {
        self.key = key
        self.persistable = persistable
    }
}

public struct TooManyRelationship<P> where P:Persistable, P:Hashable {
    public var key: String
    private var items: [P]?
    
    init(key: String) {
        self.key = key
    }
    
    mutating func setValue(_ value: [P] ) {
        self.items = value
    }
    
    mutating func setValue(_ value: Set<P.T> ) {
        self.items = value.map(P.init)
    }
    
    mutating func addItems(_ items: [P]) {
        if self.items == nil {
            self.items = []
        }
        self.items!.append(contentsOf: items)
    }
    
    mutating func addItem(_ item: P) {
        if self.items == nil {
            self.items = []
        }
        self.items!.append(item)
    }
    
    func value() -> [P] {
        return self.items ?? []
    }
    
    func interleave(ToEntity entity: NSManagedObject) {
        
    }
    
    /// Saves only if there is something to save
    ///
    /// - Parameter entity: entity to which save
    func update(ToEntity entity: NSManagedObject) {
        guard !self.isEmpty else { return }
        self.save(ToEntity: entity)
    }
    
    /// This funcion will save items array to entity no metter what...so if you empty array of items it weill delete your current data
    ///
    /// - Parameter entity: entity to which save
    func save(ToEntity entity: NSManagedObject) {
        guard self.items != nil else {
            return
        }
        entity.setValue(items!.toEntitySet(), forKey: self.key)
    }
    
    func softSave(ToEntity entity: NSManagedObject) {
        guard self.items != nil else { return }
        let oldValue = entity.value(forKey: self.key) as? Set<P>
        
    }
    
    
    var isEmpty: Bool {
        guard self.items != nil else { return true }
        return items!.count < 1
    }
    
}




