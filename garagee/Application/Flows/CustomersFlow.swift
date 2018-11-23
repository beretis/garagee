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
        case .customers:
            return navigateToCustomers()
		case .createCustomer:
			return navigatoToCreateCustomer()
        case .customerDetail(let customer):
            return navigatoToCustomerDetail(customer)
        default:
            return NextFlowItems.none
        }
    }
    
    func navigateToCustomers() -> NextFlowItems {
		let customersVM = CustomersVM(coreDataService: DI.get()!)
        let customersVC = CustomersVC.init(viewModel: customersVM)
        self.rootViewController.pushViewController(customersVC, animated: true)
        return NextFlowItems.one(flowItem: NextFlowItem(nextPresentable: customersVC, nextStepper: customersVM))
    }

	func navigatoToCreateCustomer() -> NextFlowItems {
		let flow = CreateCustomerFlow()
		return NextFlowItems.one(flowItem: NextFlowItem(nextPresentable: flow, nextStepper: OneStepper(withSingleStep: GaragerStep.createCustomer)))
	}
    
    func navigatoToCustomerDetail(_ customer: Customer) -> NextFlowItems {
//        let vm =
        let customerDetailVM = CustomerDetailVM(customer: customer);
        let customerDetailVC = CustomerDetailVC(viewModel: customerDetailVM, nibName: "CustomerDetailVC", bundle: nil)
        return NextFlowItems.one(flowItem: NextFlowItem(nextPresentable: customerDetailVC, nextStepper: OneStepper(withSingleStep: GaragerStep.createCustomer)))
    }
}


