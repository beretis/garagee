//
//  BaseCoordinator.swift
//  BBCoordinators
//
//  Created by David Lenský on 30/11/2017.
//

import Foundation

public protocol CoordinatorType: class {
	func go(_ action: Action, animated: Bool)
}

public protocol BaseCoordinator: class {
	var rootController: UINavigationController { get set }
	var parent: BaseCoordinator? { get set }
	var children: [BaseCoordinator] { get set }

	init(root: UINavigationController)

	func push(screen: Screen, animated: Bool)

	/*
	 Overridable methods for making changes in coordinator.
		• Are called whenever a controller is pushed or popped from a rootController's stack.
	*/
	func willChangeViewController()
	func didChangeViewController()
}

extension BaseCoordinator {

	/*
	 Instantiates UINavigationController and Coordinator of types specified in Screen.
		• Meant as a starting point for the coordinator cycle
		• Coordinator returned from this method should be anchored somewhere
		• UINavigationController (or it's subclass) is anchored as root inside the new coordinator.
			It should be added added to the view hierarchy somewhere (AppDelegate's windows for example)

		- returns newly created Coordinator
	*/
	public static func start(screen: Screen) -> BaseCoordinator {
		let navigationController = screen.navigationBarType.init()
		let coordinator = screen.type.init(root: navigationController)
		coordinator.willChangeViewController()
		coordinator.push(screen: screen, animated: false)
		coordinator.didChangeViewController()
		return coordinator
	}

}
