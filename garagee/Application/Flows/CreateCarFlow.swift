//
//  CreateCarFlow.swift
//  garagee
//
//  Created by Jozef Matus on 20/02/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift

class CreateCarFlow: Flow {
    
    var root: UIViewController {
        return self.rootViewController
    }
    
    private let rootViewController: UINavigationController
    
    init(rootVC: UINavigationController) {
        self.rootViewController = rootVC
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
        
        return NextFlowItems.one(flowItem: NextFlowItem(nextPresentable: vc, nextStepper: vm))
    }
    
    private func dismiss() -> NextFlowItems {
        self.rootViewController.popToRootViewController(animated: false)
        let flow = MainFlow()
        let stepper = OneStepper.init(withSingleStep: GaragerStep.dashboard(index: 2))
        return NextFlowItems.one(flowItem: NextFlowItem(nextPresentable: flow, nextStepper: stepper, isRootFlowable: true))
    }
    
}
