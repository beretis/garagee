//
//  Coordinator.swift
//  BlueBerryExampleProject
//
//  Created by Jozef Matus on 11/09/2017.
//  Copyright © 2017 Blueberry. All rights reserved.
//

import UIKit

protocol CoordinatorType: class {

//    var rootController: UIViewController { get }
    weak var parentCoordinator: CoordinatorType? { get set }
    var childCoordinators: [CoordinatorType] { get set }

    func start()
    func pop()
    func removeSelf()
}

class Coordinator<RootVC: UIViewController>: CoordinatorType {

	let rootController: RootVC
    weak var parentCoordinator: CoordinatorType?
    var childCoordinators: [CoordinatorType] = []

    init(rootVC: RootVC) {
        self.rootController = rootVC
    }

    func start() {
        fatalError("start: has not been implemented")
    }

    func pop() {
        fatalError("pop: has not been implemented")
    }

    func removeSelf() {
        fatalError("removeSelf: has not been implemented")
    }

}

class NavigationCoordinator: Coordinator<UINavigationController> {

    override func pop() {
        guard self.childCoordinators.count > 1 else { return }
        self.rootController.popViewController(animated: true)
        _ = self.childCoordinators.popLast()
    }

    override func removeSelf() {
        guard let parent = self.parentCoordinator else { return }
        self.rootController.popViewController(animated: true)
        _ = parent.childCoordinators.popLast()
    }

}

//TOOD: tab bar coordinator custom implementation
class TabBarCoordinator: Coordinator<UITabBarController> {

}
