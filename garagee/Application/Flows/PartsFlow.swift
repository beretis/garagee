//
//  PartsFlow.swift
//  garagee
//
//  Created by Jozef Matus on 24/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift

class PartsFlow: Flow {
    
    
    var root: UIViewController {
        return self.rootViewController
    }
    
    private let rootViewController: UINavigationController
    
    
    init() {
        self.rootViewController = UINavigationController()
    }
    
    func navigate(to step: Step) -> [Flowable] {
        guard let step = step as? GaragerStep else { return Flowable.noFlow }
        switch step {
        case .parts:
            return navigateToParts()
        default:
            return Flowable.noFlow
        }
    }
    
    func navigateToParts() -> [Flowable] {
        let partsVM = PartsVM()
        let partsVC = PartsVC.init(viewModel: partsVM)
        self.rootViewController.pushViewController(partsVC, animated: true)
        return [Flowable(nextPresentable: partsVC, nextStepper: partsVM)]
    }
}
