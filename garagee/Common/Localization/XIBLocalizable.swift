//
//  XIBLocalizable.swift
//  garagee
//
//  Created by Jozef Matus on 10/02/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift

protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}

extension UILabel: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            self.text = key?.localized()
        }
    }
}

extension UIButton: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            self.setTitle(key?.localized(), for: .normal)
        }
    }
}

extension UITextField: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            self.text = key?.localized()
        }
    }
    
    @IBInspectable var xibLocPlaceholderKey: String? {
        get { return nil }
        set(key) {
            self.placeholder = key?.localized()
        }
    }
    
}
