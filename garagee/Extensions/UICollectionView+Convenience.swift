//
//  UICollectionView+Convenience.swift
//  BlueBerryExampleProject
//
//  Created by Jozef Matus on 11/09/2017.
//  Copyright © 2017 Blueberry. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {

    override open func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIButton {
            return  true
        }
        return  super.touchesShouldCancel(in: view)
    }

}
