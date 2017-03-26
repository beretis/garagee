//
//  CoreDataStack.swift
//  pexeso
//
//  Created by Jozef Matus on 06/09/16.
//  Copyright © 2016 o2. All rights reserved.
//

import Foundation
import CoreData

// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
//MARK: - Definitions

public let coreDataStack = CoreDataStack(modelURL: Bundle.main.url(forResource: "garagee", withExtension: "momd")!)

public let testCoreDataStack = CoreDataStack(modelURL: Bundle.main.url(forResource: "garagee", withExtension: "momd")!)

// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Implementation

open class CoreDataStack {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    
    let modelURL : URL
    
    public init(modelURL: URL) {
        
        self.modelURL = modelURL
    }
    
    open lazy var managedObjectModel: NSManagedObjectModel = {
        
        return NSManagedObjectModel(contentsOf: self.modelURL)!
    }()
    
    
    open lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator! = {
        
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        do {
            try coordinator!.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            coordinator = nil
            abort()
        }
        
        return coordinator
    }()
    
    open lazy var managedObjectContext: NSManagedObjectContext! = {
        
        guard let coordinator = self.persistentStoreCoordinator else {
            return nil
        }
        
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return managedObjectContext
    }()
    
    
    
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Public
    
}
