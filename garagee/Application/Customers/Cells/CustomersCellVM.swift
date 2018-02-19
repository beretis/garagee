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
        self.initialsObs = Observable.just(self.getInitials(text1: model.firstName ?? "", text2: model.lastName ?? ""))
		self.nameObs = Observable.just("\(self.model.firstName ?? "") \(self.model.lastName ?? "")")
		self.contactObs = Observable.just(self.model.getContact())
	}

	private func getInitials(text1: String, text2: String) -> String {
		return "\(text1.first ?? "*")\(text2.first ?? "*")"
	}

}
