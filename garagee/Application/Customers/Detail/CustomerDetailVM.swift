//
//  CustomerDetailVM.swift
//  garagee
//
//  Created by Jozef Matus on 20/02/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import CoreData
import RxSwift
import RxFlow

class CustomerDetailVM: BaseViewModel, Stepper, RxDefaultErrorHandlable {
    lazy var back: AnyObserver<Void> = AnyObserver(eventHandler: { [unowned self] event in
        if case Event.next = event {
            self.step.accept(GaragerStep.createCustomerDone)
        }
    })
    
    init(customer: Customer) {
        super.init()
        self.step.accept(GaragerStep.customerDetail(customer: customer))
    }
    
    
}
