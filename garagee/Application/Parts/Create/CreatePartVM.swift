//
//  CreatePartVM.swift
//  garagee
//
//  Created by Jozef Matus on 29/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import RxSwift
import RxFlow

class CreatePartVM: BaseViewModel {

	let stepper: CreatePartStepper

	lazy var done: AnyObserver<Void> = AnyObserver(eventHandler: { [unowned self] event in
		if case Event.next = event {
			self.stepper.step.accept(GaragerStep.createPartDone)
		}
	})

	init(stepper: CreatePartStepper) {
		self.stepper = stepper
	}

}
