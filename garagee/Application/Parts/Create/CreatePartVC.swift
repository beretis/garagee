//
//  CreatePartVC.swift
//  garagee
//
//  Created by Jozef Matus on 29/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import AVFoundation
import UIKit
import BarcodeScanner
import Localize_Swift

class CreatePartVC: BaseViewController<CreatePartVM>, MVVMView, BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {

    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var warrantyTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.setupNavigationBar()
    }

	private func setupNavigationBar() {
		let done = UIBarButtonItem(title: "Save".localized(), style: .done, target: nil, action: nil)
        done.rx.tap.asObservable()
            .map { _ -> String in
                let code: String = self.codeTextField.text ?? ""
                return code
            }
            .bind(to: self.viewModel.save)
            .disposed(by: self.disposeBag)
		self.navigationItem.setRightBarButtonItems([done], animated: true)
        
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
        controller.dismiss(animated: true, completion: nil)
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
    
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
