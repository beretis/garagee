//
//  CreateCasVC.swift
//  garagee
//
//  Created by Jozef Matus on 19/02/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import UIKit

class CreateCarVC: BaseViewController<CreateCarVM>, MVVMView {

    @IBOutlet weak var brandTF: UITextField!
    @IBOutlet weak var modelTF: UITextField!
    @IBOutlet weak var firstRegTF: UITextField!
    @IBOutlet weak var dateOfProduction: UITextField!
    @IBOutlet weak var vinTF: UITextField!
    @IBOutlet weak var milageTF: UITextField!
    @IBOutlet weak var fuelTF: UITextField!
    @IBOutlet weak var engineTF: UITextField!
    @IBOutlet weak var documentsCV: UICollectionView!
    @IBOutlet weak var photosCV: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
