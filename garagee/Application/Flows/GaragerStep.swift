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
    
    case dashboard
    case parts
    case partDetail
    case customers
    case customerDetail
    case orders
    case orderDetail
    case settings
	case createOrder
	case createPart
	case createPartDone
}
