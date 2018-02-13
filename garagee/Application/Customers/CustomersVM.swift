//
//  CustomersVM.swift
//  garagee
//
//  Created by Jozef Matus on 17/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import CoreData
import Foundation
import RxFlow
import RxSwift

class CustomersVM: BaseViewModel, Stepper {

	var sections: Variable<[BaseSectionModel]> = Variable<[BaseSectionModel]>([])
	//dependency
	private let coreDataService: CoreDataServiceProtocol

	lazy var navigateToAdd: AnyObserver<Void> = AnyObserver(eventHandler: { [unowned self] event in
		if case Event.next = event {
			self.step.accept(GaragerStep.createCustomer)
		}
	})


	init(coreDataService: CoreDataServiceProtocol ) {
		self.coreDataService = coreDataService
		super.init()
		self.setupRx()
	}

	private func setupRx() {
		let fr: NSFetchRequest<Customer> = Customer.fetchRequest()
		fr.sortDescriptors = [NSSortDescriptor(key: "lastName", ascending: true)]
		CoreDataService.shared.viewContext.rx.entities(fetchRequest: fr)
			.map { customers -> [CustomersCellVM] in
				return customers.map { CustomersCellVM(model: $0.createDTO()) }
			}
			.map { (vms) -> [BaseSectionModel] in
				return [BaseSectionModel(items: vms)]
			}
			.bind(to: self.sections)
			.disposed(by: self.disposeBag)
	}
}

