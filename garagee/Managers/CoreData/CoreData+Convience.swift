//
//  CoreData+Convience.swift
//  garagee
//
//  Created by Jozef Matus on 22/03/17.
//  Copyright © 2017 Jozef Matus. All rights reserved.
//

import Foundation
import CoreData
import RxCocoa
import RxSwift

extension NSManagedObject {
    func setRawValue<ValueType: RawRepresentable>(value: ValueType, forKey key: String)
    {
        self.willChangeValue(forKey: key)
        self.setPrimitiveValue(value.rawValue as AnyObject, forKey: key)
        self.didChangeValue(forKey: key)
    }
    
    func rawValueForKey<ValueType: RawRepresentable>(key: String) -> ValueType?
    {
        self.willAccessValue(forKey: key)
        let result = self.primitiveValue(forKey: key) as! ValueType.RawValue
        self.didAccessValue(forKey: key)
        return ValueType(rawValue:result)
    }
}


public extension Reactive where Base: NSManagedObjectContext {
    
    public func observeEntityChanges<P: Persistable>(_ type: P.Type = P.self, predicate: NSPredicate) -> RxSwift.Observable<P> {
        return (self.base as NSManagedObjectContext).rx.entities(type, predicate: predicate, sortDescriptors: nil).filter { $0.count > 0 }.map { $0.first! }
    }
    
    public func removeAll<P: Persistable>(_ type: P.Type = P.self) {
        
    }
    
}

//extension NSManagedObject {y
//
//    public class func fetchObject<T: NSManagedObject>(id: String, context: NSManagedObjectContext = NSManagedObjectContext.mainContext) -> T? {
//
//        let entityName = NSStringFromClass(self).componentsSeparatedByString(".").last!
//
//        let request = NSFetchRequest(entityName: entityName)
//        request.predicate = NSPredicate(format: "id == '\(id)'", argumentArray: nil)
//
//
//        do {
//            return try context.executeFetchRequest(request).first as? T
//
//        } catch { }
//
//        return nil
//    }
//
//
//
//    public class func fetchObjects<T: NSManagedObject>(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, context: NSManagedObjectContext = NSManagedObjectContext.mainContext) -> [T]? {
//
//        let entityName = NSStringFromClass(self).componentsSeparatedByString(".").last!
//
//        let request = NSFetchRequest(entityName: entityName)
//        request.predicate = predicate
//        request.sortDescriptors = sortDescriptors
//
//        do {
//
//            return try context.executeFetchRequest(request) as? [T]
//
//        } catch {
//
//            print("Error : \((error as NSError).description)")
//        }
//
//        return [T]()
//
//    }
//
//    /**
//     - Fetch one object from database
//     - Use fetchObject() to fetch with default parameters - no predicate and main context
//     - Use fetchObject(predicate: NSPredicate(format: "", argumentArray: nil)) to fetch with predicate and main context
//     */
//    public class func fetchObject<T: NSManagedObject>(predicate: NSPredicate? = nil, context: NSManagedObjectContext = NSManagedObjectContext.mainContext) -> T? {
//
//        return fetchObjects(predicate, sortDescriptors: nil, context: context)?.first
//    }
//
//
//    public class func removeObjects(context: NSManagedObjectContext = NSManagedObjectContext.mainContext, predicate: NSPredicate? = nil) {
//
//        let entityName = NSStringFromClass(self).componentsSeparatedByString(".").last!
//        let request = NSFetchRequest(entityName: entityName)
//        request.predicate = predicate
//
//
//        context.performBlockAndWait {
//            if let entities = try! context.executeFetchRequest(request) as? [NSManagedObject] {
//                for entity in entities {
//                    context.deleteObject(entity)
//                }
//            }
//        }
//    }
//}

extension NSManagedObjectContext {
    public func create<E: Persistable>(_ type: E.Type = E.self) -> E.T {
        return NSEntityDescription.insertNewObject(forEntityName: E.entityName, into: self) as! E.T
    }
    
    public func get<P: Persistable>(_ persistable: P) throws -> P.T? {
        let fetchRequest: NSFetchRequest<P.T> = NSFetchRequest(entityName: P.entityName)
        fetchRequest.predicate = NSPredicate(format: "%K = %@", P.primaryAttributeName, persistable.identity)
        let result = (try self.execute(fetchRequest)) as! NSAsynchronousFetchResult<P.T>
        return result.finalResult?.first
    }
    
    public func getOrCreateEntity<K: Persistable>(for persistable: K) -> K.T {
        if let reusedEntity = try? self.get(persistable), reusedEntity != nil {
            return reusedEntity!
        } else {
            return self.create(K.self)
        }
    }
    
    public func fetchObject<P: Persistable>(_ type: P.Type = P.self, identifier: String) throws -> P.T? {
        let fetchRequest: NSFetchRequest<P.T> = NSFetchRequest(entityName: P.entityName)
        fetchRequest.predicate = NSPredicate(format: "%K = %@", P.primaryAttributeName, identifier)
        let result = (try self.execute(fetchRequest)) as! NSAsynchronousFetchResult<P.T>
        return result.finalResult?.first
    }
    
    
    public func fetchPersistables<P: Persistable>(_ type: P.Type = P.self, predicate: NSPredicate) throws -> [P] {
        let fetchRequest: NSFetchRequest<P.T> = NSFetchRequest(entityName: P.entityName)
        fetchRequest.predicate = predicate
        let result = (try self.execute(fetchRequest)) as! NSAsynchronousFetchResult<P.T>
        return result.finalResult?.map(P.init) ?? []
    }
    
    func fetchPersistable<P: Persistable>(_ type: P.Type = P.self, identifier: String) throws -> P {
        let entity = try self.fetchObject(type, identifier: identifier)
        guard entity != nil else { throw RxCoreDataError.entityNotFound(type.entityName, identifier) }
        return P.init(entity: entity!)
    }
    
    public func fetchObjects<P: Persistable>(_ type: P.Type = P.self) throws -> [P.T] {
        let fetchRequest: NSFetchRequest<P.T> = NSFetchRequest(entityName: P.entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: type.primaryAttributeName, ascending: true)]
        let result = (try self.execute(fetchRequest)) as! NSAsynchronousFetchResult<P.T>
        return result.finalResult ?? []
    }
    
    public func fetchPersistables<P: Persistable>(_ type: P.Type = P.self) throws -> [P] {
        guard let entities = try? self.fetchObjects(type) else { return [] }
        return entities.map(P.init)
    }
    
    public func removeAllObjects<P: Persistable>(_ type: P.Type = P.self) {
        guard let entities = try? self.fetchObjects(type) else { return }
        entities.forEach { (entity) in
            self.delete(entity)
        }
    }
}

extension NSManagedObjectContext {
    
    public class var mainContext: NSManagedObjectContext! {
        
        return coreDataStack.managedObjectContext!
    }
    
    public var mainContext: NSManagedObjectContext! {
        
        return NSManagedObjectContext.mainContext
    }
    
    public func saveContextWithoutErrorHandling() {
        
        do {
            
            if hasChanges {
                
                try save()
            }
            
        } catch {
            print(error)
        }
        
    }
    
    public class func createTempContext(parentContext: NSManagedObjectContext? = nil) -> NSManagedObjectContext {
        let tempContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        tempContext.parent = parentContext ?? NSManagedObjectContext.mainContext
        
        return tempContext
    }
}

