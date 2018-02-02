//
//  CustomersFlow.swift
//  garagee
//
//  Created by Jozef Matus on 24/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift

class CustomersFlow: Flow {
    
    
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
        case .customers:
            return navigateToCustomers()
        default:
            return NextFlowItems.stepNotHandled
        }
    }
    
    func navigateToCustomers() -> NextFlowItems {
		let customersVM = CustomersVM(coreDataService: DI.get()!)
        let customersVC = CustomersVC.init(viewModel: customersVM)
        self.rootViewController.pushViewController(customersVC, animated: true)
        return NextFlowItems.one(flowItem: NextFlowItem(nextPresentable: customersVC, nextStepper: customersVM))
    }
}


