//
//  OrdersFlow.swift
//  garagee
//
//  Created by Jozef Matus on 24/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift

class OrdersFlow: Flow {
    
    
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
        case .orders:
            return navigateToOrders()
        default:
            return NextFlowItems.stepNotHandled
        }
    }
    
    func navigateToOrders() -> NextFlowItems {
		let ordersVM = OrdersVM(coreDataService: DI.get()!)
        let ordersVC = OrdersVC.init(viewModel: ordersVM)
        self.rootViewController.pushViewController(ordersVC, animated: true)
        return NextFlowItems.one(flowItem: NextFlowItem(nextPresentable: ordersVC, nextStepper: ordersVM))
    }
}

