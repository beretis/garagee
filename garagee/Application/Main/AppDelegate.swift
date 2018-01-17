//
//  AppDelegate.swift
//  garagee
//
//  Created by Jozef Matus on 17/02/17.
//  Copyright © 2017 Jozef Matus. All rights reserved.
//

import UIKit
import CoreData
import RxFlow
import RxSwift
import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let disposeBag = DisposeBag()
    
    var window: UIWindow?
    var coordinator = Coordinator()
    lazy var mainFlow = {
        return MainFlow()
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        guard let window = self.window else { return false }

        coordinator.rx.didNavigate.subscribe(onNext: { (flow, step) in
            print ("did navigate to flow=\(flow) and step=\(step)")
        }).disposed(by: self.disposeBag)
        
        Flows.whenReady(flow: mainFlow, block: { [unowned window] (root) in
            window.rootViewController = root
        })
        
        coordinator.coordinate(flow: mainFlow, withStepper: OneStepper(withSingleStep: GaragerStep.orders))
        
        return true
    }

}

