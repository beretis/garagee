//
//  CreateCustomerOrderCell.swift
//  garagee
//
//  Created by Jozef Matus on 13/02/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import UIKit

class CreateCustomerOrderCell: BaseCell<CreateCustomerOrderCellVM> {
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configure(withViewModel vm: CellVM) {
        super.configure(withViewModel: vm)
        self.subscriptions = [

        ]
    }


}
