//
//  PartsVM.swift
//  garagee
//
//  Created by Jozef Matus on 17/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift

class PartsVM: BaseViewModel, Stepper {

	var sections: Variable<[BaseSectionModel]> = Variable<[BaseSectionModel]>([])

	lazy var navigateToAdd: AnyObserver<Void> = AnyObserver(eventHandler: { [unowned self] event in
		if case Event.next = event {
			self.step.accept(GaragerStep.createPart)
		}
	})
	//dependencyd
	private let coreDataService: CoreDataServiceProtocol

	init(coreDataService: CoreDataServiceProtocol ) {
		self.coreDataService = coreDataService
		super.init()
		self.setupRx()
	}

	private func setupRx() {
		let partDto = PartDTO(brand: "sdf", code: "sdf", id: "sdf", name: "sdfa", price: 2143, warrantyDays: 324, order: nil)
		let tmpItems: [PartsCellVM] = [ PartsCellVM(model: partDto) ]
		let tmp: [BaseSectionModel] = [BaseSectionModel(items: tmpItems)]
		self.sections.value = tmp
		print(self.sections.value)
	}
}

