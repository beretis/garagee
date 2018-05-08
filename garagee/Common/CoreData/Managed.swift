//
//  Managed.swift
//  BlueBerryExampleProject
//
//  Created by Jozef Matus on 10/10/2017.
//  Copyright © 2017 Blueberry. All rights reserved.
//
import CoreData

public protocol Managed: class, NSFetchRequestResult {
	static var entity: NSEntityDescription { get }
	static var entityName: String { get }
	static var defaultSortDescriptors: [NSSortDescriptor] { get }
	static var defaultPredicate: NSPredicate { get }
	var managedObjectContext: NSManagedObjectContext? { get }

	/// The attribute name to be used to uniquely identify each instance.
    var primaryAttributeName: String { get }
	var identity: String { get }
    var identifyingPredicate: NSPredicate { get }
}


extension Managed {

	public static var defaultSortDescriptors: [NSSortDescriptor] { return [] }
	public static var defaultPredicate: NSPredicate { return NSPredicate(value: true) }
    public var identifyingPredicate: NSPredicate { return NSPredicate(format: "\(self.primaryAttributeName) = %@", self.identity) }

	public static var sortedFetchRequest: NSFetchRequest<Self> {
		let request = NSFetchRequest<Self>(entityName: entityName)
		request.sortDescriptors = defaultSortDescriptors
		request.predicate = defaultPredicate
		return request
	}

	public static func sortedFetchRequest(with predicate: NSPredicate) -> NSFetchRequest<Self> {
		let request = sortedFetchRequest
		guard let existingPredicate = request.predicate else { fatalError("must have predicate") }
		request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [existingPredicate, predicate])
		return request
	}

	public static func predicate(format: String, _ args: CVarArg...) -> NSPredicate {
		let p = withVaList(args) { NSPredicate(format: format, arguments: $0) }
		return predicate(p)
	}

	public static func predicate(_ predicate: NSPredicate) -> NSPredicate {
		return NSCompoundPredicate(andPredicateWithSubpredicates: [defaultPredicate, predicate])
	}

}

extension Managed where Self: NSManagedObject {

	public static var entity: NSEntityDescription { return entity() }

	public static var entityName: String { return entity.name! }

	public static func findOrCreate(in context: NSManagedObjectContext, matching predicate: NSPredicate, configure: (Self) throws -> Void) rethrows -> Self {
		guard let object = try? findOrFetch(in: context, matching: predicate), let unwrapedObject = object else {
			let newObject: Self = Self.init(context: context)
			try configure(newObject)
			return newObject
		}
		return unwrapedObject
	}

	public static func findOrFetch(in context: NSManagedObjectContext, matching predicate: NSPredicate) throws -> Self? {
		guard let object = materializedObject(in: context, matching: predicate) else {
			return try fetch(in: context) { request in
				request.predicate = predicate
				request.returnsObjectsAsFaults = false
				request.fetchLimit = 1
			}.first
		}
		return object
	}

	public static func fetch(in context: NSManagedObjectContext, configurationBlock: (NSFetchRequest<Self>) -> Void = { _ in }) throws -> [Self] {
		let request = NSFetchRequest<Self>(entityName: Self.entityName)
		configurationBlock(request)
		return try context.fetch(request)
	}

	public static func count(in context: NSManagedObjectContext, configure: (NSFetchRequest<Self>) -> Void = { _ in }) throws -> Int {
		let request = NSFetchRequest<Self>(entityName: entityName)
		configure(request)
		return try context.count(for: request)
	}

	public static func materializedObject(in context: NSManagedObjectContext, matching predicate: NSPredicate) -> Self? {
		for object in context.registeredObjects where !object.isFault {
			guard let result = object as? Self, predicate.evaluate(with: result) else { continue }
			return result
		}
		return nil
	}

}

extension NSManagedObjectContext {

	private var store: NSPersistentStore {
		guard let psc = persistentStoreCoordinator else { fatalError("PSC missing") }
		guard let store = psc.persistentStores.first else { fatalError("No Store") }
		return store
	}

	public var metaData: [String: AnyObject] {
		get {
			guard let psc = persistentStoreCoordinator else { fatalError("must have PSC") }
			return psc.metadata(for: store) as [String : AnyObject]
		}
		set {
			performChanges {
				guard let psc = self.persistentStoreCoordinator else { fatalError("PSC missing") }
				psc.setMetadata(newValue, for: self.store)
			}
		}
	}

	public func setMetaData(object: AnyObject?, forKey key: String) {
		var md = metaData
		md[key] = object
		metaData = md
	}

	public func insertObject<A: NSManagedObject>() -> A where A: Managed {
		guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else { fatalError("Wrong object type") }
		return obj
	}

	public func saveOrRollback() -> Bool {
		do {
			try save()
			return true
		} catch {
			rollback()
			return false
		}
	}

	public func performSaveOrRollback() {
		perform {
			_ = self.saveOrRollback()
		}
	}

	public func performChanges(block: @escaping () -> Void) {
		perform {
			block()
			_ = self.saveOrRollback()
		}
	}
}

//
//extension Managed where Self: NSManagedObject {
//	public static func fetchSingleObject(in context: NSManagedObjectContext, cacheKey: String, configure: (NSFetchRequest<Self>) -> ()) -> Self? {
//		if let cached = context.object(forSingleObjectCacheKey: cacheKey) as? Self { return cached
//		}
//		let result = fetchSingleObject(in: context, configure: configure)
//		context.set(result, forSingleObjectCacheKey: cacheKey)
//		return result
//	}
//
//	fileprivate static func fetchSingleObject(in context: NSManagedObjectContext, configure: (NSFetchRequest<Self>) -> ()) -> Self? {
//		let result = fetch(in: context) { request in
//			configure(request)
//			request.fetchLimit = 2
//		}
//		switch result.count {
//		case 0: return nil
//		case 1: return result[0]
//		default: fatalError("Returned multiple objects, expected max 1")
//		}
//	}
//}
//
