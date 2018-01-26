//
//  OrderCell.swift
//  garagee
//
//  Created by Jozef Matus on 25/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import UIKit

class OrderCell: BaseCell<OrderCellVM> {
	@IBOutlet weak var subjectLabel: UILabel!
	@IBOutlet weak var customerNameLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!

	override func configure(withViewModel vm: CellVM) {
		super.configure(withViewModel: vm)
		self.subscriptions = [
			self.concreteVM.subjectObs.bind(to: self.subjectLabel.rx.text),
			self.concreteVM.customerNameObs.bind(to: self.customerNameLabel.rx.text),
			self.concreteVM.priceObs.bind(to: self.priceLabel.rx.text)
		]
	}

}
