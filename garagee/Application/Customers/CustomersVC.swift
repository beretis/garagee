//
//  CustomersVC.swift
//  garagee
//
//  Created by Jozef Matus on 04/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import UIKit
import Localize_Swift

class CustomersVC: BaseCollectionView<CustomersVM> {

	override var cellClasses: [UICollectionViewCell.Type] { return [ CustomersCell.self ] }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Customers".localized()
        self.setupNavigationBar()
    }

	override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.frame.size.width, height: 80)
	}

	private func setupNavigationBar() {
		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
		addButton.rx.tap.asObservable().bind(to: self.viewModel.navigateToAdd).disposed(by: self.disposeBag)
		self.navigationItem.setRightBarButtonItems([addButton], animated: true)
	}

    override func setupRx() {
        super.setupRx()
        self.viewModel.sections.asObservable().bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }
    
}
