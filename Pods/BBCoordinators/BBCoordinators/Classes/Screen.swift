//
//  Screen.swift
//  BBCoordinators
//
//  Created by David Lenský on 30/11/2017.
//

import UIKit

/*
 Represents a screen (or a ViewController) in stack.
*/
public protocol Screen {

	/* Type of Coordinator that is responsible for navigation of screen */
	var type: BaseCoordinator.Type { get }

	/*
	 Array of TabBar's subscreens
		• If empty, a screen without tab bar is created.
		• Default is empty array.
	*/
	var tabBarScreens: [Screen] { get }

	/*
	 Type of tab bar controller that is created in TabBar screen.
		• Default is UITabBarController.
	*/
	var tabBarType: UITabBarController.Type { get }

	/*
	 UITabBarItem for a screen.
		• If empty, no item is set to the corresponding ViewController
		• Default is nil
	*/
	var tabBarItem: UITabBarItem? { get }

	/* Type of navigation controller that is created if screen is first in a stack. That means if it's the first screen in app or first screen after a TabBar screen (TabBarItem screen). Default is UINavigationController */
	var navigationBarType: UINavigationController.Type { get }
}

/* Defualt implementation of values */
public extension Screen {
	var tabBarScreens: [Screen] { return [] }
	var tabBarType: UITabBarController.Type { return UITabBarController.self }
	var tabBarItem: UITabBarItem? { return nil }
	var navigationBarType: UINavigationController.Type { return UINavigationController.self }
}
