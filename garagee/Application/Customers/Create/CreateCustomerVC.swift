//
//  CreateCustomerVC.swift
//  garagee
//
//  Created by Jozef Matus on 13/02/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Localize_Swift
import RxCocoa
import RxSwift
import UIKit

class CreateCustomerVC: BaseViewController<CreateCustomerVM>, MVVMView, DefaultErrorPresenter  {

	@IBOutlet weak var nameTF: UITextField!
	@IBOutlet weak var surnameTF: UITextField!
	@IBOutlet weak var emailTF: UITextField!
	@IBOutlet weak var phoneTF: UITextField!
	@IBOutlet weak var carsView: UIView!
	@IBOutlet weak var ordersView: UIView!
	@IBOutlet weak var carsCollectionView: UICollectionView!
	@IBOutlet weak var ordersCollectionView: UICollectionView!
	@IBOutlet weak var addCarButton: UIButton!
	@IBOutlet weak var addOrderButton: UIButton!

	lazy var errorStream: Observable<AppError> = { [unowned self] in
		return self.viewModel.defaultErrorHandler.error.asObservable().map { error in
			error.convertToAppSpecificError()
		}
	}()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
