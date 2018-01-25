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
    
    func navigate(to step: Step) -> [Flowable] {
        guard let step = step as? GaragerStep else { return Flowable.noFlow }
        switch step {
        case .customers:
            return navigateToCustomers()
        default:
            return Flowable.noFlow
        }
    }
    
    func navigateToCustomers() -> [Flowable] {
        let customersVM = CustomersVM()
        let customersVC = CustomersVC.init(viewModel: customersVM)
        self.rootViewController.pushViewController(customersVC, animated: true)
        return [Flowable(nextPresentable: customersVC, nextStepper: customersVM)]
    }
}


