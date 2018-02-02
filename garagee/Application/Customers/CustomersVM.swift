//
//  CustomersVM.swift
//  garagee
//
//  Created by Jozef Matus on 17/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift

class CustomersVM: BaseViewModel, Stepper {

	var sections: Variable<[BaseSectionModel]> = Variable<[BaseSectionModel]>([])
	//dependency
	private let coreDataService: CoreDataServiceProtocol

	init(coreDataService: CoreDataServiceProtocol ) {
		self.coreDataService = coreDataService
		super.init()
		self.setupRx()
	}

	private func setupRx() {

	}
}

