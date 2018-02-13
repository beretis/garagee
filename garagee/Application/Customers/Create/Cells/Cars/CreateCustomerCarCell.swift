//
//  CreateCustomerCarCell.swift
//  garagee
//
//  Created by Jozef Matus on 13/02/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import UIKit

class CreateCustomerCarCell: BaseCell<CreateCustomerCarCellVM> {
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var carLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func configure(withViewModel vm: CellVM) {
        super.configure(withViewModel: vm)
        self.subscriptions = [
            
        ]
    }

}
