//
//  BaceCell.swift
//  NeySD-ios
//
//  Created by Jozef Matus on 03/01/2018.
//  Copyright © 2018 BlueBerry. All rights reserved.
//
import RxCocoa
import RxSwift
import UIKit

class BaseCell<CVM: CellVM>: UICollectionViewCell, Cell {
	var viewModel: CellVM!
	var isPresented: Bool = false
	var subscriptions: [Disposable] = []
	var concreteVM: CVM {
		return self.viewModel as! CVM
	}

	func configure(withViewModel vm: CellVM) {
		guard let viewModel = vm as? CVM else {
			fatalError("Cell needs specific viewModel")
		}
		self.viewModel = viewModel
	}

}
