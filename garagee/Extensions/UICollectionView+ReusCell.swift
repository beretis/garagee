//
//  UICollectionView+ReusCell.swift
//  BlueBerryExampleProject
//
//  Created by Jozef Matus on 11/09/2017.
//  Copyright © 2017 Blueberry. All rights reserved.
//

import Foundation
import UIKit

public extension UICollectionReusableView {

    static public var autoReuseIdentifier: String {
        return NSStringFromClass(self) + "AutogenerateIdentifier"
    }
}

public extension UICollectionView {

    public var currentPageNumber: Int {
        return Int(ceil(self.contentOffset.x / self.frame.size.width))
    }

    public func dequeue<T: UICollectionReusableView>(cell: T.Type, indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: cell.autoReuseIdentifier, for: indexPath) as? T
    }

    public func dequeue<T: UICollectionReusableView>(header: T.Type, indexPath: IndexPath) -> T? {
        return  dequeueReusableSupplementaryView(
            ofKind: UICollectionElementKindSectionHeader,
            withReuseIdentifier: T.autoReuseIdentifier,
            for: indexPath)    as? T
    }

    public func dequeue<T: UICollectionReusableView>(footer: T.Type, indexPath: IndexPath) -> T? {
        return  dequeueReusableSupplementaryView(
            ofKind: UICollectionElementKindSectionFooter,
            withReuseIdentifier: T.autoReuseIdentifier,
            for: indexPath)    as? T
    }

    public func registerCell<T: UICollectionReusableView>(_ cell: T.Type) {
        register(nibFromClass(cell), forCellWithReuseIdentifier: cell.autoReuseIdentifier)
    }

    public func registerSectionHeader<T: UICollectionReusableView>(_ header: T.Type) {
        register(nibFromClass(header), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                 withReuseIdentifier: header.autoReuseIdentifier)
    }

    public func registerSectionFooter<T: UICollectionReusableView>(_ footer: T.Type) {
        register(nibFromClass(footer), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
                 withReuseIdentifier: footer.autoReuseIdentifier)
    }

    // Private

    fileprivate func nibFromClass(_ type: UICollectionReusableView.Type) -> UINib? {
        guard let nibName = NSStringFromClass(type).components(separatedBy: ".").last else {
            return nil
        }

        return UINib(nibName: nibName, bundle: nil)
    }
}
