//
//  GaragerStep.swift
//  garagee
//
//  Created by Jozef Matus on 17/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import RxFlow

enum GaragerStep: Step {
    //main
    case dashboard(index: Int)
	case settings
	//listFlows
	case customers
	case parts
	case orders
	//details
    case customerDetail(customer: Customer)
    case orderDetail
	case partDetail
	//createflows
        //Part
	case createPart
	case createPartDone
        //Ccustomer
	case createCustomer
    case createCustomerDone
        //Car
	case createCarForCustomer(customer: Customer)
    case createCarDone
    //Order
	case createOrder

}
