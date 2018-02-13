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
    var ordersSection: Variable<[BaseSectionModel]> = Variable<[BaseSectionModel]>([])


	lazy var cancel: AnyObserver<Void> = AnyObserver(eventHandler: { [unowned self] event in
		if case Event.next = event {
			self.step.accept(GaragerStep.createCustomerDone)
		}
	})

	lazy var save: AnyObserver<(String?, String?, String?, String?, String?)> = AnyObserver(eventHandler: { [unowned self] event in
		if case let Event.next(data) = event {
		}
	})


	override init() {
		super.init()
		self.step.accept(GaragerStep.createCustomer)
	}

    private func setupRx() {
        
    }

}
