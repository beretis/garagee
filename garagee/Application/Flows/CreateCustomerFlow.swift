//
//  CreateCustomerFlow.swift
//  garagee
//
//  Created by Jozef Matus on 13/02/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift

class CreateCustomerFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController: UINavigationController
    
    init() {
        self.rootViewController = UINavigationController()
    }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? GaragerStep else { return NextFlowItems.none }
        switch step {
        case .createCustomer:
            return self.goToCreate()
        case .createCustomerDone:
            return self.dismiss()
        default:
            return NextFlowItems.none
        }
    }
    
    private func goToCreate() -> NextFlowItems {
        let vm = CreateCustomerVM()
        let vc = CreateCustomerVC(viewModel: vm, nibName: "CreateCustomerVC", bundle: Bundle.main)
        self.rootViewController.pushViewController(vc, animated: true)
        
        return NextFlowItems.one(flowItem: NextFlowItem(nextPresentable: vc, nextStepper: vm))
    }
    
    private func dismiss() -> NextFlowItems {
        self.rootViewController.popToRootViewController(animated: false)
        let flow = MainFlow()
        let stepper = OneStepper.init(withSingleStep: GaragerStep.dashboard(index: 1))
        return NextFlowItems.one(flowItem: NextFlowItem(nextPresentable: flow, nextStepper: stepper))
    }
    
}

