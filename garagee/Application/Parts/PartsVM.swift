//
//  PartsVM.swift
//  garagee
//
//  Created by Jozef Matus on 17/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import CoreData
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
		let fr: NSFetchRequest<Part> = Part.fetchRequest()
		fr.sortDescriptors = [NSSortDescriptor(key: "code", ascending: true)]
        CoreDataService.shared.viewContext.rx.entities(fetchRequest: fr)
			.map { parts -> [PartsCellVM] in
				return parts.map { PartsCellVM(model: $0.createDTO()) }
			}
			.map { (vms) -> [BaseSectionModel] in
				return [BaseSectionModel(items: vms)]
			}
			.bind(to: self.sections)
			.disposed(by: self.disposeBag)
	}
}

