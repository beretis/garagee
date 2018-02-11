//
//  PartsFlow.swift
//  garagee
//
//  Created by Jozef Matus on 24/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift

class PartsFlow: Flow {
    
    
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
        case .parts:
            return navigateToParts()
		case .createPart:
			return navigateToCreatePartsFlow()
        default:
            return NextFlowItems.stepNotHandled
        }
    }
    
    func navigateToParts() -> NextFlowItems {
		let partsVM = PartsVM(coreDataService: DI.get()!)
        let partsVC = PartsVC.init(viewModel: partsVM)
        self.rootViewController.pushViewController(partsVC, animated: true)
        return NextFlowItems.one(flowItem: NextFlowItem(nextPresentable: partsVC, nextStepper: partsVM))
    }

	func navigateToCreatePartsFlow() -> NextFlowItems {
		let flow = CreatePartFlow()
        return NextFlowItems.one(flowItem: NextFlowItem(nextPresentable: flow, nextStepper: OneStepper(withSingleStep: GaragerStep.createPart), isRootFlowable: true))
	}
}
