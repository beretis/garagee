//
//  Controller.swift
//  TestProject
//
//  Created by David Lenský on 25/11/2017.
//  Copyright © 2017 David Lenský. All rights reserved.
//

import UIKit

open class Controller<T: ViewModel>: UIViewController {
    
    public let viewModel: T
    public var customTabBarController: UITabBarController?
    
	required public init(viewModel: T, item: UITabBarItem? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
		self.tabBarItem = item
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    /*
	 Method responsible for creating UITabBarController instance (or it's subclass)
		• If Screen is a TabBar based screen, this method gets called and initializes a UITabBarController instance specified in Screen.
		• Instance is then stored in "customTabBarCOntroller" variable

		+ gets type of UITabBarController that should be created
		+ gets array of items that will get set as UITabBarController's ViewControllers 
	*/
    func createTabBarController(from type: UITabBarController.Type, withItemControllers items: [UINavigationController]) {
        let tabBarController = type.init()
        tabBarController.viewControllers = items
        tabBarController.view.frame = CGRect(origin: .zero, size: self.view.frame.size)
        self.view.addSubview(tabBarController.view)
        self.customTabBarController = tabBarController
    }
    
}
