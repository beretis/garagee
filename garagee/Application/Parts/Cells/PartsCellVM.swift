//
//  PartsCellVM.swift
//  garagee
//
//  Created by Jozef Matus on 25/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import RxSwift

class PartsCellVM: CellVM {
    var cellClass: UICollectionViewCell.Type { return PartsCell.self }
    //dependency
    let model: PartDTO
    //output
	var nameObs: Observable<String> = .never()
	var brandObs: Observable<String> = .never()
	var priceObs: Observable<String> = .never()
    
    init(model: PartDTO) {
        self.model = model
		self.setupRx()
    }

	private func setupRx() {
		self.nameObs = Observable.just(model.name)
		self.brandObs = Observable.just(model.brand)
		self.priceObs = Observable.just(String(model.price))
	}
}
