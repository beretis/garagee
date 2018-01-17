//
//  OrdersVC.swift
//  garagee
//
//  Created by Jozef Matus on 04/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import UIKit

class OrdersVC: BaseCollectionView<OrdersVM> {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("this shit is visible")
    }
    
}
