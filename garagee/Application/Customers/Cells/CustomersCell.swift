//
//  CustomersCell.swift
//  garagee
//
//  Created by Jozef Matus on 25/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import UIKit

class CustomersCell: BaseCell<CustomersCellVM> {
	@IBOutlet weak var circularView: UIView!
	@IBOutlet weak var initialsLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var contactLbel: UILabel!

	override func configure(withViewModel vm: CellVM) {
		super.configure(withViewModel: vm)
		self.subscriptions = [
			self.concreteVM.initialsObs.bind(to: self.initialsLabel.rx.text),
			self.concreteVM.nameObs.bind(to: self.nameLabel.rx.text),
			self.concreteVM.contactObs.bind(to: self.contactLbel.rx.text)
		]
	}

}
