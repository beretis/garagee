//
//  CustomersVC.swift
//  garagee
//
//  Created by Jozef Matus on 04/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import UIKit

class CustomersVC: BaseCollectionView<CustomersVM> {

	override var cellClasses: [UICollectionViewCell.Type] { return [ CustomersCell.self ] }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
