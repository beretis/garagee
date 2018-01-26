//
//  CustomersCellVM.swift
//  garagee
//
//  Created by Jozef Matus on 25/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import RxSwift

class CustomersCellVM: CellVM {
    var cellClass: UICollectionViewCell.Type { return CustomersCell.self }
    //dependency
    let model: CustomerDTO
    //output
    
    init(model: CustomerDTO) {
        self.model = model
    }


}
