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

    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController: UITabBarController

    
    init() {
        self.rootViewController = UITabBarController()
    }
    
    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? GaragerStep else { return NextFlowItems.none }
        switch step {
        case .dashboard(let index):
            return navigateToOrders(index: index)
        default:
            return NextFlowItems.none
        }
    }
    
    private func navigateToOrders (index: Int = 0) -> NextFlowItems {
        let partsFlow = PartsFlow()
        let ordersFlow = OrdersFlow()
        let customersFlow = CustomersFlow()
        
        Flows.whenReady(flow1: ordersFlow, flow2: customersFlow, flow3: partsFlow, block: { [unowned self] (root1: UINavigationController, root2: UINavigationController, root3: UINavigationController) in
            let tabBarItem1 = UITabBarItem(title: "Orders", image: UIImage(named: "wishlist"), selectedImage: nil)
            let tabBarItem2 = UITabBarItem(title: "Customers", image: UIImage(named: "watched"), selectedImage: nil)
            let tabBarItem3 = UITabBarItem(title: "Parts", image: UIImage(named: "sperm"), selectedImage: nil)

            root1.tabBarItem = tabBarItem1
            root1.title = "Orders"
            root2.tabBarItem = tabBarItem2
            root2.title = "Customers"
            root3.tabBarItem = tabBarItem3
            root3.title = "Parts"
            
            self.rootViewController.setViewControllers([root1, root2, root3], animated: false)
            self.rootViewController.selectedIndex = index
        })
		return NextFlowItems.multiple(flowItems: [NextFlowItem(nextPresentable: ordersFlow, nextStepper: OneStepper(withSingleStep: GaragerStep.orders)),
										   NextFlowItem(nextPresentable: customersFlow, nextStepper: OneStepper(withSingleStep: GaragerStep.customers)),
										   NextFlowItem(nextPresentable: partsFlow, nextStepper: OneStepper(withSingleStep: GaragerStep.parts))])
    }
    
}
