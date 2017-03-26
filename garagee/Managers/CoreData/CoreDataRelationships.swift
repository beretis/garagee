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


public class PersistableOrEntity<P> :Equatable where P:Persistable, P: Hashable {
    
    private var entityValue: P.T?
    private var persistableValue: P?
    
    init(value: P.T) {
        self.entityValue = value
    }
    
    init(value: P) {
        self.persistableValue = value
    }
    
    func setValue(value: P) {
        self.entityValue = nil
        self.persistableValue = value
    }
    
    func setValue(value: P.T) {
        self.persistableValue = nil
        self.entityValue = value
    }
    
    func getPersistableValue() -> P {
        guard self.entityValue != nil || self.persistableValue != nil else { fatalError("this object needs to have value") }
        guard self.persistableValue != nil else {
            return P(entity: self.entityValue!)
        }
        return self.persistableValue!
    }
    
    func getEntityValue() -> P.T {
        guard self.entityValue != nil || self.persistableValue != nil else { fatalError("this object needs to have value") }
        guard self.entityValue != nil else {
            return self.persistableValue!.toEntity()
        }
        return self.entityValue!
    }
    
}

public func ==<P>(lhs: PersistableOrEntity<P>, rhs: PersistableOrEntity<P>) -> Bool where P:Persistable, P: Hashable {
    return lhs.getPersistableValue().identity == rhs.getPersistableValue().identity
}

extension PersistableOrEntity: Hashable {
    public var hashValue: Int { return self.getPersistableValue().identity.hashValue }
}


public struct ToOneRelationship<P> where P:Persistable, P: Hashable {
    let key: String
    private var value: PersistableOrEntity<P>?
    
    mutating func setValue(_ newValue: P) {
        guard self.value != nil else {
            self.value = PersistableOrEntity(value: newValue)
            return
        }
        self.value!.setValue(value: newValue)
    }
    
    mutating func setValue(_ newValue: P.T) {
        guard self.value != nil else {
            self.value = PersistableOrEntity(value: newValue)
            return
        }
        self.value!.setValue(value: newValue)
    }
    
    func getValue() -> P? {
        guard self.value != nil else {
            return nil
        }
        return self.value!.getPersistableValue()
    }
    
    func update(ToEntity entity: P.T) {
        self.save(ToEntity: entity)
    }
    
    func save(ToEntity entity: P.T) {
        guard self.value != nil else { return }
        entity.setValue(self.value!.getEntityValue(), forKey: key)
    }
    
    init(key: String) {
        self.key = key
    }
    
}

public struct TooManyRelationship<P> where P:Persistable, P:Hashable {
    public var key: String
    private var items: Array<PersistableOrEntity<P>>?
    
    init(key: String) {
        self.key = key
    }
    
    mutating func setValue(_ value: [P] ) {
        let value = value.map { item in
            return PersistableOrEntity<P>(value: item)
        }
        self.items = value
    }
    
    mutating func setValue(_ value: Set<P.T> ) {
        let value = value.map { item in
            return PersistableOrEntity<P>(value: item)
        }
        self.items = value
    }
    
    mutating func addItems(_ items: [P]) {
        if self.items == nil {
            self.items = []
        }
        let value = items.map { item in
            return PersistableOrEntity<P>(value: item)
        }
        self.items!.append(contentsOf: value)
    }
    
    mutating func addItem(_ item: P) {
        if self.items == nil {
            self.items = []
        }
        
        self.items!.append(PersistableOrEntity<P>(value: item))
    }
    
    func value() -> [P] {
        guard let value = self.items else { return [] }
        return value.map { item in
            item.getPersistableValue()
            }.flatMap { $0 }
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
        let entities = Set(items!.map { $0.getEntityValue() })
        entity.setValue(entities, forKey: self.key)
    }
    
    var isEmpty: Bool {
        guard self.items != nil else { return true }
        return items!.count < 1
    }
    
}




