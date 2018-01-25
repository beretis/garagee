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
    
    func navigate(to step: Step) -> [Flowable] {
        guard let step = step as? GaragerStep else { return Flowable.noFlow }
        switch step {
        case .orders:
            return navigateToOrders()
        default:
            return Flowable.noFlow
        }
    }
    
    func navigateToOrders() -> [Flowable] {
        let ordersVM = OrdersVM()
        let ordersVC = OrdersVC.init(viewModel: ordersVM)
        self.rootViewController.pushViewController(ordersVC, animated: true)
        return [Flowable(nextPresentable: ordersVC, nextStepper: ordersVM)]
    }
}

