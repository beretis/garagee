//
//  ViewModel.swift
//  TestProject
//
//  Created by David Lenský on 25/11/2017.
//  Copyright © 2017 David Lenský. All rights reserved.
//

import Foundation

open class ViewModel {
    
    weak public var coordinator: CoordinatorType?
    
    required public init(coordinator: CoordinatorType) {
        self.coordinator = coordinator
    }
}
