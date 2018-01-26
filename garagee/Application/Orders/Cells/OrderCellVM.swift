//
//  OrderCellVM.swift
//  garagee
//
//  Created by Jozef Matus on 25/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import RxSwift

class OrderCellVM: CellVM {

	var cellClass: UICollectionViewCell.Type { return OrderCell.self }
	//dependency
	let model: OrderDTO
	//output
	let subjectObs: Observable<String>
	let customerNameObs: Observable<String>
	let priceObs: Observable<String>

	init(model: OrderDTO) {
		self.model = model
		self.subjectObs = Observable.just(model.name)
		self.customerNameObs = Observable.just("")
		self.priceObs = Observable.just("")
	}
}
