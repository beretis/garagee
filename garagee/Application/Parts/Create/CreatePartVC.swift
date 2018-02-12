//
//  CreatePartVC.swift
//  garagee
//
//  Created by Jozef Matus on 29/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import AVFoundation
import BarcodeScanner
import Localize_Swift
import RxCocoa
import RxSwift
import UIKit

class CreatePartVC: BaseViewController<CreatePartVM>, MVVMView, BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate, DefaultErrorPresenter {

	lazy var errorStream: Observable<AppError> = { [unowned self] in
		return self.viewModel.defaultErrorHandler.error.asObservable().map { error in
			error.convertToAppSpecificError()
		}
	}()
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var warrantyTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.setupNavigationBar()
		self.setupErrorPresenter()
    }

	private func setupNavigationBar() {
		let save = UIBarButtonItem(title: "Save".localized(), style: .done, target: nil, action: nil)
        save.rx.tap.asObservable()
            .map { _ -> (String?, String?, String?, String?, String?) in
				let values = (brand: self.brandTextField.text, name: self.nameTextField.text, price: self.priceTextField.text, warranty: self.warrantyTextField.text, code: self.codeTextField.text)
                return values
            }
            .bind(to: self.viewModel.save)
            .disposed(by: self.disposeBag)
		self.navigationItem.setRightBarButtonItems([save], animated: true)
        
        let cancel = UIBarButtonItem(title: "Cancel".localized(), style: .plain, target: nil, action: nil)
        cancel.rx.tap.asObservable().bind(to: self.viewModel.cancel).disposed(by: self.disposeBag)
        self.navigationItem.setLeftBarButtonItems([cancel], animated: true)
	}

    @IBAction func scanAction(_ sender: Any) {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        
        present(viewController, animated: true, completion: nil)
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print(code)
        self.codeTextField.text = code
		if self.viewModel.partExist(WithCode: code) {
			UIAlertController.alert("create_part_alert_part_exist_title".localized(), message: "create_part_alert_part_exist_text".localized(), OKActionTitle: "create_part_alert_part_exist_OKButton_title".localized(), cancelActionTitle: nil, destructiveActionTitle: nil, OKAction: { (action) in
				controller.dismiss(animated: true, completion: nil)
			}, cancelAction: nil, destructiveAction: nil)
		} else {
			print("it doesnt exist")
			controller.dismiss(animated: true, completion: nil)
		}
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
    
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
