//
//  ReusableCollectionView.swift
//  BlueBerryExampleProject
//
//  Created by Jozef Matus on 13/09/2017.
//  Copyright © 2017 Blueberry. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

protocol ReusableCollectionView {
    var collectionView: UICollectionView! { get set }
    var cellClasses: [UICollectionViewCell.Type] { get }
    var headerClasses: [UICollectionReusableView.Type] { get }
    var footerClasses: [UICollectionReusableView.Type] { get }
}

extension ReusableCollectionView {

    func registerCells() {
        for cellClass in self.cellClasses {
            self.collectionView.registerCell(cellClass)
        }
    }

    func registerHeaders() {
        for headerClass in self.headerClasses {
            self.collectionView.registerSectionHeader(headerClass)
        }
    }

    func registerFooters() {
        for footerClass in self.footerClasses {
            self.collectionView.registerSectionHeader(footerClass)
        }

    }
}

extension ReusableCollectionView {
    //TODO: complete this
    static func supplementaryViewFactory<S: SectionModelType>(ForSectionModelType type: S.Type, RowsIndexesWithTitle rows: [Int]) -> (CollectionViewSectionedDataSource<S>, UICollectionView, String, IndexPath) -> UICollectionReusableView {
        let supplementaryViewFactory: (CollectionViewSectionedDataSource<S>, UICollectionView, String, IndexPath) -> UICollectionReusableView = { (dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
            guard rows.contains(indexPath.section) else { return UICollectionReusableView() }
//            collectionView.dequeue(header: <#T##T.Type#>, indexPath: <#T##IndexPath#>)
            return UICollectionReusableView()

        }

        return supplementaryViewFactory
    }

    static func configureCellFactory<S: SectionModelType>(ForSectionModelType type: S.Type) -> (CollectionViewSectionedDataSource<S>, UICollectionView, IndexPath, S.Item) -> UICollectionViewCell where S.Item == CellVM {
        let cellFactory: (CollectionViewSectionedDataSource<S>, UICollectionView, IndexPath, S.Item) -> UICollectionViewCell = { (dataSource, collectionView, idxPath, item) -> UICollectionViewCell in
            let cell: UICollectionViewCell = collectionView.dequeue(cell: item.cellClass, indexPath: idxPath)!
            (cell as! Cell).configure(withViewModel: item)
            return cell
        }
        return cellFactory
    }
}
