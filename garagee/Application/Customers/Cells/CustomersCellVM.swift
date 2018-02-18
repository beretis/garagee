//
//  CustomersCellVM.swift
//  garagee
//
//  Created by Jozef Matus on 25/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import RxSwift

class CustomersCellVM: CellVM {
    var cellClass: UICollectionViewCell.Type { return CustomersCell.self }
    //dependency
    let model: CustomerDTO
    //output
	var initialsObs: Observable<String> = .never()
	var nameColorObs: Observable<UIColor> = .never()
	var nameObs: Observable<String> = .never()
	var contactObs: Observable<String> = .never()


    init(model: CustomerDTO) {
        self.model = model
		self.setupRx()
    }

	private func setupRx() {
		self.initialsObs = Observable.just(self.getInitials(text1: self.model.firstName ?? "*", text2: self.model.lastName ?? "*"))
		self.nameObs = Observable.just("\(self.model.firstName) \(self.model.lastName)")
		self.contactObs = Observable.just("0938509283")
	}

	private func getInitials(text1: String, text2: String) -> String {
		return "\(String(describing: text1.first))\(String(describing: text2.first))"
	}

}
