//
//  Coordinator.swift
//  TestProject
//
//  Created by David Lenský on 25/11/2017.
//  Copyright © 2017 David Lenský. All rights reserved.
//

import UIKit

// MARK: - Coordinator

open class Coordinator<VM, VC: Controller<VM>>: BaseCoordinator, CoordinatorType {
	public required init(root: UINavigationController) {
		self.rootController = root
	}
	
	public var rootController: UINavigationController

	public var parent: BaseCoordinator?

	public var children: [BaseCoordinator] = []

	public required init(root: UINavigationController, children: [BaseCoordinator] = []) {
		self.rootController = root
	}

	open func willChangeViewController() {

	}

	open func didChangeViewController() {

	}


    /*
	 Method for injecting custom ViewModel of type VM.
		• Allows usage of a custom subclass of VM
		• Allows using custom initializer of VM. (For dependency injection, ...)

		- returns custom subclass or instance of VM
	*/
    open func customViewModel() -> VM? { return nil }

	/*
	 Method for injecting custom Controller<VM> of type VC.
		• Allows usage of a custom subclass of VC
		• Allows using custom initializer of VC. (For dependency injection, ...)

		+ gets instance of VM passed from "customViewModel()" if implemented or default one if not

		- returns custom subclass or instance of VC
    */
    open func customViewController(with viewModel: VM) -> VC? { return nil }

	/*
	 Public method that triggers a coordinator action.
		+ gets instance of Action, that should be triggered
		+ gets optional animated flag, specifying if animation should be or animated or not
	*/
    public func go(_ action: Action, animated: Bool = true) {
        switch action {
        case .backOne: self.pop(animated: animated)
        case .forward(let screen): self.initialize(screen, withRoot: self.rootController, animated: animated)
        case .back(let screen): self.popTo(screen, animated: animated)
        }
    }


    /*
	 Handles initialization of new Coordinator instance, with type specified in Screen.
		• New Coordinator is anchored in active coordinator (self) as it's child
		• New Coordinator is then pushed to screen

		+ gets an instance of Screen that should be created
		+ gets an instance of UINavigationController (or subclass), that should
	*/
    private func initialize(_ screen: Screen, withRoot root: UINavigationController, animated: Bool) {
        let coordinator = screen.type.init(root: root)
        coordinator.parent = self
        self.children.append(coordinator)
        coordinator.push(screen: screen, animated: animated)
    }

	/*
	 Handles poping to previous screen.
		• Releases current screen by setting parent's children to nil
		• Pops parent's rootController's topViewController. Poping on the parent's instance insures that TabBar screen can be popped from it's sub controllers.
	*/
    private func pop(animated: Bool) {
        self.parent?.children = []
		self.parent?.willChangeViewController()
        self.parent?.rootController.popViewController(animated: animated)
        self.parent?.didChangeViewController()
    }

	/*
	 Handles poping to a specific screen in stack
		• Searches for a specific screen by going through coordinator's parents
		• It then releases all strong connections to that screen's child coordinators and reduces it's rootController's stack to all view controllers up to that screen

		+ gets target screen that the stack would pop to
	*/
    private func popTo(_ screen: Screen, animated: Bool) { // TODO: - Quite large - shorten it or cut to pieces
        var currentRootController: UINavigationController?
        var counter = 0
        
        var parent = self.parent
        while parent != nil {
            if parent!.rootController == currentRootController { counter += 1 }
            else {
                currentRootController = parent!.rootController
                counter = 0
            }
            
            if type(of: parent!) == screen.type { break }
            parent = parent!.parent
        }
        guard let targetCoordinator = parent else { return }
        targetCoordinator.children = []
        let viewControllersCount = targetCoordinator.rootController.viewControllers.count - 1 - counter
        let viewControllers = targetCoordinator.rootController.viewControllers[0...viewControllersCount]
		targetCoordinator.willChangeViewController()
        targetCoordinator.rootController.setViewControllers(Array(viewControllers), animated: true)
        targetCoordinator.didChangeViewController()
    }

	/*
	 Handles pushing new screen to stack
		• Creates an instances of screen's ViewController's and ViewModel's types and adds them to rootController's stack
		• If pushed VC is a TabBar this method initializes all it's TabBarItem controllers and adds them to the TabBar

		+ gets target screen that should be pushed to stack
	*/
	public func push(screen: Screen, animated: Bool) {
        let vm = self.customViewModel() ?? VM(coordinator: self)
		let vc = self.customViewController(with: vm) ?? VC(viewModel: vm, item: screen.tabBarItem)

		self.willChangeViewController()
        self.rootController.pushViewController(vc, animated: animated)
        self.didChangeViewController()
        
        if !screen.tabBarScreens.isEmpty {
            var children: [UINavigationController] = []
            
            for tabScreen in screen.tabBarScreens {
                let navController = tabScreen.navigationBarType.init()
                self.initialize(tabScreen, withRoot: navController, animated: false)
                children.append(navController)
            }
            vc.createTabBarController(from: screen.tabBarType, withItemControllers: children)
        }
    }
    
}
