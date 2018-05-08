//
//  NSManagedObjectContext+Rx.swift
//  RxCoreData
//
//  Created by Krunoslav Zaher on 5/18/16.
//  Copyright © 2016 Krunoslav Zaher. All rights reserved.
//
import CoreData
import Foundation
import RxCocoa
import RxSwift

public extension Reactive where Base: NSManagedObjectContext {

    /**
     Executes a fetch request and returns the fetched objects as an `Observable` array of `NSManagedObjects`.
     - parameter fetchRequest: an instance of `NSFetchRequest` to describe the search criteria used to retrieve data from a persistent store
     - parameter sectionNameKeyPath: the key path on the fetched objects used to determine the section they belong to; defaults to `nil`
     - parameter cacheName: the name of the file used to cache section information; defaults to `nil`
     - returns: An `Observable` array of `NSManagedObjects` objects that can be bound to a table view.
     */
    func entities<T: NSManagedObject>(fetchRequest: NSFetchRequest<T>,
                                      sectionNameKeyPath: String? = nil,
                                      cacheName: String? = nil) -> Observable<[T]> {
        return Observable.create { observer in

			let observerAdapter = FetchedResultsControllerEntityObserver(observer: observer, fetchRequest: fetchRequest, managedObjectContext: self.base, sectionNameKeyPath: sectionNameKeyPath, cacheName: cacheName)

			return Disposables.create {
				observerAdapter.dispose()
			}
        }
    }
    /**
     Executes a fetch request and returns the fetched section objects as an `Observable` array of `NSFetchedResultsSectionInfo`.
     - parameter fetchRequest: an instance of `NSFetchRequest` to describe the search criteria used to retrieve data from a persistent store
     - parameter sectionNameKeyPath: the key path on the fetched objects used to determine the section they belong to; defaults to `nil`
     - parameter cacheName: the name of the file used to cache section information; defaults to `nil`
     - returns: An `Observable` array of `NSFetchedResultsSectionInfo` objects that can be bound to a table view.
     */
    func sections<T: NSManagedObject>(fetchRequest: NSFetchRequest<T>,
                                      sectionNameKeyPath: String? = nil,
                                      cacheName: String? = nil) -> Observable<[NSFetchedResultsSectionInfo]> {
        return Observable.create { observer in
            let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                 managedObjectContext: self.base,
                                                 sectionNameKeyPath: sectionNameKeyPath,
                                                 cacheName: cacheName)

            let observerAdapter = FetchedResultsControllerSectionObserver(observer: observer, frc: frc)
            return Disposables.create {
                observerAdapter.dispose()
            }
        }
    }
    /**
     Performs transactional update, initiated on a separate managed object context, and propagating thrown errors.
     - parameter updateAction: a throwing update action
     */
    func performUpdate(updateAction: (NSManagedObjectContext) throws -> Void) throws {
        guard self.base.hasChanges else { return }

        let privateContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        privateContext.parent = self.base

        try updateAction(privateContext)

        try privateContext.save()

        try self.base.save()
    }
}
