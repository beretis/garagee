//
//  MoyaResponseParsing.swift
//  BlueBerryExampleProject
//
//  Created by Jozef Matus on 20/09/2017.
//  Copyright © 2017 Blueberry. All rights reserved.
//

import Foundation
import CoreData
import Moya
import RxSwift
import SwiftyJSON
import Unbox

extension Response {

	func responseEntity<T: Unboxable>() throws -> T {
		let responseDictionary: UnboxableDictionary = try responseToDict()
		return try unbox(dictionary: responseDictionary)
	}

	func responseEntities<T: Unboxable>() throws -> [T] {
		let responseDictionaries: [UnboxableDictionary] = try responseToDictionaries()
		return try unbox(dictionaries: responseDictionaries)
	}

	func responseToDict() throws -> UnboxableDictionary {
		let successResponse = try self.filterSuccessfulStatusCodes()
		let json = try successResponse.mapJSON()
		guard let responseDictionary = json as? [String: Any] else {
			throw Moya.MoyaError.jsonMapping(self)
		}
		return responseDictionary
	}

	func responseToDictionaries() throws -> [UnboxableDictionary] {
		let successResponse = try self.filterSuccessfulStatusCodes()
		let json = try successResponse.mapJSON()
		guard let responseDictionary = json as? [UnboxableDictionary] else {
			throw Moya.MoyaError.jsonMapping(self)
		}
		return responseDictionary
	}
	//TODO: specify dispatch queue
	// Just unboxing data
	func rx_unbox<T: Unboxable>(rootKey: String? = nil) -> Observable<T> {
		return Observable.create { (element) -> Disposable in
			do {
				let responseDictionary: UnboxableDictionary = try self.responseToDict()
				let entity: T = try {
					if let rootKey = rootKey {
						return try unbox(dictionary: responseDictionary, atKey: rootKey)
					} else {
						return try unbox(dictionary: responseDictionary)
					}
				}()
				element.onNext(entity)
				element.onCompleted()
			} catch let err {
				print("📦❗️ Unboxing error: \(err)")
				element.onError(err)
			}
			return Disposables.create()
		}
	}

	func rx_unbox<T: Unboxable>(rootKey: String? = nil) -> Observable<[T]> {
		return Observable.create { (element) -> Disposable in
			do {
				let entity: [T] = try {
					if let rootKey = rootKey {
						let responseDictionary: UnboxableDictionary = try self.responseToDict()
						return try unbox(dictionary: responseDictionary, atKey: rootKey, allowInvalidElements: true)
					} else {
						let responseDictionary: [UnboxableDictionary] = try self.responseToDictionaries()
						let pes = responseDictionary.map { pes -> T? in
							let object: T? = try? unbox(dictionary: pes)
							return object
							}.flatMap { $0 }
//						print(" dictionary is \(pes)")
//						return try responseDictionary.flatMap { dic -> T in
//							let object: T = try unbox(dictionary: dic)
//							return object
//						}

						return pes
					}
				}()
				element.onNext(entity)
				element.onCompleted()
			} catch let err {
				print("📦❗️ Unboxing error: \(err)")
				element.onError(err)
			}
			return Disposables.create()
		}
	}


}
