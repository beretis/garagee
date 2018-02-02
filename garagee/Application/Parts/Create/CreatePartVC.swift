//
//  CreatePartVC.swift
//  garagee
//
//  Created by Jozef Matus on 29/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import UIKit

class CreatePartVC: BaseViewController<CreatePartVM>, MVVMView {

    override func viewDidLoad() {
        super.viewDidLoad()
		self.setupNavigationBar()
    }

	private func setupNavigationBar() {
		let addButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
		addButton.rx.tap.asObservable().bind(to: self.viewModel.navigateToAdd).disposed(by: self.disposeBag)
		self.navigationItem.setRightBarButtonItems([addButton], animated: true)
	}

}
