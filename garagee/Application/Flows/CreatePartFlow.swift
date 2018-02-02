//
//  CreatePartFlow.swift
//  garagee
//
//  Created by Jozef Matus on 26/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift

class CreatePartFlow: Flow {

	var root: UIViewController {
		return self.rootViewController
	}

	private let rootViewController: UINavigationController

	init() {
		self.rootViewController = UINavigationController()
	}

	func navigate(to step: Step) -> NextFlowItems {
		guard let step = step as? GaragerStep else { return NextFlowItems.stepNotHandled }
		switch step {
		case .createPart:
			return self.goToCreate()
		case .createPartDone:
			return self.dismiss()
		default:
			return NextFlowItems.stepNotHandled
		}
	}

	private func goToCreate() -> NextFlowItems {
		let vm = CreatePartVM()
		let vc = CreatePartVC(viewModel: vm, nibName: "CreatePartVC", bundle: Bundle.main)
		self.rootViewController.pushViewController(vc, animated: true)

		return NextFlowItems.none
	}

	private func dismiss() -> NextFlowItems {
		
	}

}

class CreatePartStepper: Stepper {

	init() {
		self.step.accept(GaragerStep.createPart)
	}

}
