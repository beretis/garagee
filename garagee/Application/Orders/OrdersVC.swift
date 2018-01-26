//
//  OrdersVC.swift
//  garagee
//
//  Created by Jozef Matus on 04/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class OrdersVC: BaseCollectionView<OrdersVM> {

	override var cellClasses: [UICollectionViewCell.Type] { return [OrderCell.self] }

	override func viewDidLoad() {
		super.viewDidLoad()
	}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

	override func setupRx() {
		super.setupRx()
		self.viewModel.sections.asObservable().bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
			.disposed(by: self.disposeBag)
//		self.collectionView.rx.itemSelected.bind(to: self.viewModel.selectedIndexPath)
//			.disposed(by: self.disposeBag)
	}
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 80)
    }

}
