//
//  Action.swift
//  BBCoordinators
//
//  Created by David Lenský on 30/11/2017.
//

import Foundation

/*
 Represents action that will be performed on the coordinator.
	• Forward - Pushes Screen to stack
	• Back To - Pops to a specific Screen in stack (if it's present)
	• Back One - Pops to a previous Screen in stack
*/
public enum Action {
	case forward(to: Screen)
	case backOne
	case back(to: Screen)
}
