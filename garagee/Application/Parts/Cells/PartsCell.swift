//
//  PartsCell.swift
//  garagee
//
//  Created by Jozef Matus on 25/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import UIKit

class PartsCell: BaseCell<PartsCellVM> {
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var brandLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!

	override func configure(withViewModel vm: CellVM) {
		super.configure(withViewModel: vm)
		self.subscriptions = [
			self.concreteVM.nameObs.bind(to: self.nameLabel.rx.text),
			self.concreteVM.brandObs.bind(to: self.brandLabel.rx.text),
			self.concreteVM.priceObs.bind(to: self.priceLabel.rx.text)
		]
	}

}
