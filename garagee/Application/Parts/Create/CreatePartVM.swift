//
//  CreatePartVM.swift
//  garagee
//
//  Created by Jozef Matus on 29/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import CoreData
import RxSwift
import RxFlow

class CreatePartVM: BaseViewModel, Stepper, RxDefaultErrorHandlable {

	lazy var cancel: AnyObserver<Void> = AnyObserver(eventHandler: { [unowned self] event in
		if case Event.next = event {
			self.step.accept(GaragerStep.createPartDone)
		}
	})
    
    lazy var save: AnyObserver<(String?, String?, String?, String?, String?)> = AnyObserver(eventHandler: { [unowned self] event in
        if case let Event.next(data) = event {
			guard self.validate(Inputs: data) else {
				return self.defaultErrorHandler.error.onNext(AppError.validationFailed as! Error)
			}
            guard let partDTO: PartDTO = try? self.createPartDTO(FromInput: data) else {
                return self.defaultErrorHandler.error.onNext(AppError.validationFailed as! Error)
            }
            do {
                try self.save(Part: partDTO)
            } catch {
                return self.defaultErrorHandler.error.onNext(AppError.validationFailed as! Error)
            }
            self.step.accept(GaragerStep.createPartDone)
        }
    })

	override init() {
		super.init()
        self.step.accept(GaragerStep.createPart)
	}

	//private
	private func destructure(inputs: (String?, String?, String?, String?, String?)) throws -> (String, String, String, String, String) {
		let (b, n, p, w, c) = inputs
		guard let brand = b, let name = n, let price = p, let warranty = w, let code = c else {
			throw AppError.validationFailed(message: nil)
		}
		return (brand, name, price, warranty, code)
	}

	private func validate(Inputs inputs: (String?, String?, String?, String?, String?)) -> Bool {
		guard let unwrapedInputs = try? self.destructure(inputs: inputs) else { return false }
		let (brand, name, price, warranty, code) = unwrapedInputs
		guard !brand.isBlank && !name.isBlank && !price.isBlank && !warranty.isBlank && !code.isBlank else { return false }
		guard let _ = Float(price), let _ = Int(warranty) else { return false }
		return true
	}

	private func createPartDTO(FromInput input: (String?, String?, String?, String?, String?)) throws -> PartDTO {
		guard let unwrapedInputs = try? self.destructure(inputs: input) else { throw AppError.validationFailed(message: nil) }
		let (brand, name, price, warranty, code) = unwrapedInputs
		guard let priceFloat = Float(price), let warrantyInt = Int(warranty) else { throw AppError.validationFailed(message: nil) }
		let priceInCents: Int = Int(priceFloat * 100)
		return PartDTO(brand: brand, code: code, name: name, price: Int64(priceInCents), warrantyDays: Int16(warrantyInt), orders: [])
	}
    
    private func save(Part part: PartDTO) throws {
        let bgContext = CoreDataService.shared.persistentContainer.newBackgroundContext()
        let _: Part = Part(dto: part, context: bgContext)
        try bgContext.save()
    }

    public func partExist(WithCode code: String) -> (exists: Bool, part: Part?) {
        var result = false
        var part: Part? = nil
        let fr: NSFetchRequest<Part> = Part.fetchRequest()
        fr.predicate = NSPredicate(format: "code = %@", code)
        CoreDataService.shared.viewContext.performAndWait {
            if let partsResult = (try? fr.execute().first) ?? nil {
                result = true
                part = partsResult
            }
        }
        return (result, part)
    }




}
