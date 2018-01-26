//
//  CellGenerics.swift
//  BlueBerryExampleProject
//
//  Created by Jozef Matus on 13/09/2017.
//  Copyright © 2017 Blueberry. All rights reserved.
//

import RxDataSources
import RxSwift
import UIKit

protocol Cell {

    var viewModel: CellVM! { get set }
    var isPresented: Bool { get set }
    var subscriptions: [Disposable] { get set }

    func configure(withViewModel vm: CellVM)
    func cellWillEndDisplaying()
    func disposeAllSubscription()
}

extension Cell {
    func cellWillEndDisplaying() {
        self.disposeAllSubscription()
    }

    func disposeAllSubscription() {
        for subscription in self.subscriptions {
            subscription.dispose()
        }
    }
}

protocol CellVM {
    var cellClass: UICollectionViewCell.Type { get }
    var cellInProgress: Bool { get }
}

extension CellVM {
    var cellInProgress: Bool {
        return false
    }
}

protocol CellModel { }

extension Cell where Self: UICollectionViewCell {
    func cellDidPressed() {
//        self.contentView.backgroundColor = isHighlighted ? ColorName.disableCell.color : .white
    }
}
