//
//  CreateCustomerVC.swift
//  garagee
//
//  Created by Jozef Matus on 13/02/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Contacts
import ContactsUI
import Localize_Swift
import RxCocoa
import RxSwift
import UIKit

class CreateCustomerVC: BaseViewController<CreateCustomerVM>, MVVMView, DefaultErrorPresenter, CNContactPickerDelegate {

	@IBOutlet weak var nameTF: UITextField!
	@IBOutlet weak var surnameTF: UITextField!
	@IBOutlet weak var emailTF: UITextField!
	@IBOutlet weak var phoneTF: UITextField!
	@IBOutlet weak var carsView: UIView!
	@IBOutlet weak var carsCollectionView: UICollectionView!
	@IBOutlet weak var addCarButton: UIButton!
	@IBOutlet weak var pickCustomerButton: UIButton!
	@IBOutlet weak var importMutipleButton: UIButton!

	lazy var errorStream: Observable<AppError> = { [unowned self] in
		return self.viewModel.defaultErrorHandler.error.asObservable().map { error in
			error.convertToAppSpecificError()
		}
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
		self.setupRx()
		self.setupErrorPresenter()
    }
    
    private func setupRx() {
		self.pickCustomerButton.rx.tap.asObservable().do(onNext: { _ in
			let contactPickerViewController = CNContactPickerViewController()
			contactPickerViewController.delegate = self
			contactPickerViewController.predicateForSelectionOfContact = NSPredicate(value: true)
			contactPickerViewController.predicateForSelectionOfProperty = NSPredicate(value: true)
			self.present(contactPickerViewController, animated: true, completion: nil)
		}).subscribe().disposed(by: self.disposeBag)
    }
    
    //private
    private func setupNavigationBar() {
        let save = UIBarButtonItem(title: "Save".localized(), style: .done, target: nil, action: nil)
        save.rx.tap.asObservable()
            .map { _ -> (String?, String?, String?, String?, [CarDTO]) in
				let values = (firstName: self.nameTF.text, lastName: self.surnameTF.text, email: self.emailTF.text, phone: self.phoneTF.text, cars: [CarDTO]())
                return values
            }
            .bind(to: self.viewModel.save)
            .disposed(by: self.disposeBag)
        self.navigationItem.setRightBarButtonItems([save], animated: true)
        
        let cancel = UIBarButtonItem(title: "Cancel".localized(), style: .plain, target: nil, action: nil)
        cancel.rx.tap.asObservable().bind(to: self.viewModel.cancel).disposed(by: self.disposeBag)
        self.navigationItem.setLeftBarButtonItems([cancel], animated: true)
    }

	func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
		picker.dismiss(animated: true) {
			self.fillUI(WithContact: contact)
		}
	}

	func fillUI(WithContact contact: CNContact) {
		self.nameTF.text = contact.givenName
		self.surnameTF.text = contact.familyName
		let email = contact.emailAddresses.first?.value ?? ""
        self.emailTF.text = String(email)
		let phone = contact.phoneNumbers.first?.value.stringValue ?? ""
        self.phoneTF.text = String(phone)
	}
}

class CreateCustomerCarsCollectionViewFlowDelegate: NSObject, UICollectionViewDelegate, ReusableCollectionView, UICollectionViewDelegateFlowLayout {
    var collectionView: UICollectionView!
    
    var cellClasses: [UICollectionViewCell.Type] = []
    
    var headerClasses: [UICollectionReusableView.Type] = []
    
    var footerClasses: [UICollectionReusableView.Type] = []
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var cell = (cell as! Cell)
        cell.isPresented = true
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var cell = (cell as! Cell)
        cell.isPresented = false
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
}
