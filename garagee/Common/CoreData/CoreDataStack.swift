//
//  CoreDataStack.swift
//  BlueBerryExampleProject
//
//  Created by Jozef Matus on 03/10/2017.
//  Copyright © 2017 Blueberry. All rights reserved.
//

import CoreData
import Foundation

protocol CoreDataServiceProtocol:class {
	var errorHandler: (Error) -> Void { get set }
	var persistentContainer: NSPersistentContainer { get }
	var viewContext: NSManagedObjectContext { get }
	var backgroundContext: NSManagedObjectContext { get }

	func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void)
	func performForegroundTask(_ block: @escaping (NSManagedObjectContext) -> Void)
}

final class CoreDataService: CoreDataServiceProtocol {

	static let shared = CoreDataService()
	var errorHandler: (Error) -> Void = { _ in }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BlueBerryExampleProject")
        container.loadPersistentStores(completionHandler: { [weak self](storeDescription, error) in
            if let error = error {
                NSLog("CoreData error \(error), \(String(describing: error._userInfo))")
                self?.errorHandler(error)
            }
        })
        return container
    }()
//	//in memory storage
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "BlueBerryExampleProject")
//        let description = NSPersistentStoreDescription()
//        description.type = NSInMemoryStoreType
//        container.persistentStoreDescriptions = [description]
//        container.loadPersistentStores(completionHandler: { [weak self](storeDescription, error) in
//            if let error = error {
//                NSLog("CoreData error \(error), \(String(describing: error._userInfo))")
//                self?.errorHandler(error)
//            }
//        })
//        return container
//    }()

	lazy var viewContext: NSManagedObjectContext = {
		self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
		return self.persistentContainer.viewContext
	}()

	lazy var backgroundContext: NSManagedObjectContext = {
		let context = self.persistentContainer.newBackgroundContext()
		context.automaticallyMergesChangesFromParent = true

        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
		return context
	}()

	func performForegroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
		self.viewContext.perform {
			block(self.viewContext)
		}
	}

	func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
		self.persistentContainer.performBackgroundTask(block)
	}
}
