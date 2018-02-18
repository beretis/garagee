//
//  CreateCustomerVM.swift
//  garagee
//
//  Created by Jozef Matus on 13/02/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import CoreData
import RxSwift
import RxFlow

class CreateCustomerVM: BaseViewModel, Stepper, RxDefaultErrorHandlable {
    
    var carsSection: Variable<[BaseSectionModel]> = Variable<[BaseSectionModel]>([])

	lazy var cancel: AnyObserver<Void> = AnyObserver(eventHandler: { [unowned self] event in
		if case Event.next = event {
			self.step.accept(GaragerStep.createCustomerDone)
		}
	})

	lazy var save: AnyObserver<(name: String?, surname: String?, email: String?, phone: String?, cars: [CarDTO])> = AnyObserver(eventHandler: { [unowned self] event in
		if case let Event.next(data) = event {
			guard self.validate(Inputs: data) else {
				return self.defaultErrorHandler.error.onNext(AppError.validationFailed(message: nil))
			}
			guard let customerDTO: CustomerDTO = try? self.createCustomerDTO(FromInput: data) else {
				return self.defaultErrorHandler.error.onNext(AppError.validationFailed(message: nil))
			}
			guard !self.exists(Customer: customerDTO).exists else {
				self.defaultErrorHandler.error.onNext(AppError.validationFailed(message: "Customer already exists"))
				return self.step.accept(GaragerStep.createCustomerDone)
			}
			do {
				try self.save(Customer: customerDTO)
			} catch {
				return self.defaultErrorHandler.error.onNext(AppError.validationFailed(message: nil))
			}
			self.step.accept(GaragerStep.createCustomerDone)
		}
	})


	override init() {
		super.init()
		self.step.accept(GaragerStep.createCustomer)
	}

	private func setupRx() {

	}


	private func validate(Inputs inputs: (name: String?, surname: String?, email: String?, phone: String?, cars: [CarDTO])) -> Bool {
		let (n, s, e, p, _) = inputs
		guard ((n != nil) || (s != nil)) else {
			return false
		}
		guard (e != nil || p != nil) else {
			return false
		}
		if let email = e {
			guard !email.isBlank && !email.isEmail else {
				return false
				
			}
		}
		guard String.validate(OptionalStringInput: n) && String.validate(OptionalStringInput: s) && String.validate(OptionalStringInput: p) else {
			return false
		}
		return true
	}

	private func save(Customer customer: CustomerDTO) throws {
		let bgContext = CoreDataService.shared.persistentContainer.newBackgroundContext()
		let _: Customer = Customer(dto: customer, context: bgContext)
		try bgContext.save()
	}

	private func exists(Customer customer: CustomerDTO) -> (exists: Bool, fetchedCustomer: Customer?) {
		var result = false
		var fetchedCustomer: Customer? = nil
		let fr: NSFetchRequest<Customer> = Customer.fetchRequest()
		fr.predicate = NSPredicate(format: "id = %@", customer.id)
		CoreDataService.shared.viewContext.performAndWait {
			if let customersResult = (try? fr.execute().first) ?? nil {
				result = true
				fetchedCustomer = customersResult
			}
		}
		return (result, fetchedCustomer)
	}

	private func createCustomerDTO(FromInput input: (name: String?, surname: String?, email: String?, phone: String?, cars: [CarDTO])) throws -> CustomerDTO {
		let (name, surname, email, phone, cars) = input
		let customerId = try CustomerDTO.createId(ForName: name, surname: surname, email: email, phone: phone)
		let customerDTO = CustomerDTO(email: email, firstName: name, id: customerId, lastName: surname, phoneNumber: phone, cars: cars)
		return customerDTO

	}

}
