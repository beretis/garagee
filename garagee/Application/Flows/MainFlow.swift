//
//  MainFlow.swift
//  garagee
//
//  Created by Jozef Matus on 17/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift

class MainFlow: Flow {

    
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
        case .dashboard:
            return navigateToOrders()
        default:
            return Flowable.noFlow
        }
    }
    
    private func navigateToOrders () -> [Flowable] {
        let tabbarController = UITabBarController()
        let partsFlow = PartsFlow()
        let ordersFlow = OrdersFlow()
        let customersFlow = CustomersFlow()
        
        Flows.whenReady(flow1: ordersFlow, flow2: partsFlow, flow3: customersFlow, block: { [unowned self] (root1: UINavigationController, root2: UINavigationController, root3: UINavigationController) in
            let tabBarItem1 = UITabBarItem(title: "Orders", image: UIImage(named: "wishlist"), selectedImage: nil)
            let tabBarItem2 = UITabBarItem(title: "Customers", image: UIImage(named: "watched"), selectedImage: nil)
            let tabBarItem3 = UITabBarItem(title: "Parts", image: UIImage(named: "sperm"), selectedImage: nil)

            root1.tabBarItem = tabBarItem1
            root1.title = "Orders"
            root2.tabBarItem = tabBarItem2
            root2.title = "Customers"
            root3.tabBarItem = tabBarItem3
            root3.title = "Parts"
            
            tabbarController.setViewControllers([root1, root2, root3], animated: false)
            self.rootViewController.pushViewController(tabbarController, animated: true)
        })
        
        return ([Flowable(nextPresentable: ordersFlow, nextStepper: OneStepper(withSingleStep: GaragerStep.orders)),
                 Flowable(nextPresentable: customersFlow, nextStepper: OneStepper(withSingleStep: GaragerStep.customers)),
				Flowable(nextPresentable: partsFlow, nextStepper: OneStepper(withSingleStep: GaragerStep.parts))])
    }
    
}
