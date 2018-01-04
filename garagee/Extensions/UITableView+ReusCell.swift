//
//  UITableView+ReusCell.swift
//  BlueBerryExampleProject
//
//  Created by Jozef Matus on 11/09/2017.
//  Copyright © 2017 Blueberry. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
    func registerCell<U: UITableViewCell>(cellType: U.Type) {
        let nib = UINib(nibName: String(describing: cellType), bundle: Bundle(for: cellType))
        register(nib, forCellReuseIdentifier: String(describing: cellType))
    }

    func registerCellClass<U: UITableViewCell>(cellType: U.Type) {
        register(cellType, forCellReuseIdentifier: String(describing: cellType))
    }

    func registerHeaderFooterViewClass<U: UITableViewHeaderFooterView>(viewType: U.Type) {
        register(viewType, forHeaderFooterViewReuseIdentifier: String(describing: viewType))
    }

    func registerHeaderFooterView<U: UITableViewHeaderFooterView>(viewType: U.Type) {
        let nib = UINib(nibName: String(describing: viewType), bundle: Bundle(for: viewType))
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: viewType))
    }

    func dequeueReusableCell<U: UITableViewCell> (cellType: U.Type, forIndexPath indexPath: NSIndexPath) -> U {
        return dequeueReusableCell(withIdentifier: String(describing: cellType),
                                   for: indexPath as IndexPath) as! U
    }

    func dequeueReusableCell<U: UITableViewCell> (cellType: U.Type) -> U? {
        return dequeueReusableCell(withIdentifier: String(describing: cellType)) as? U
    }

    func dequeueReusableHeaderFooterView<U: UITableViewHeaderFooterView> (viewType: U.Type) -> U? {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: viewType)) as? U
    }
}
