//
//  BaseViewModel.swift
//  BlueBerryExampleProject
//
//  Created by Jozef Matus on 13/09/2017.
//  Copyright © 2017 Blueberry. All rights reserved.
//

import Foundation
import RxSwift
import RxViewModel

class BaseViewModel: RxViewModel {

    weak var coordinator: CoordinatorType?

    var backButtonObserver: AnyObserver<Void> {
        return AnyObserver(eventHandler: { [unowned self] (event) in
            self.coordinator?.removeSelf()
        })
    }
}
