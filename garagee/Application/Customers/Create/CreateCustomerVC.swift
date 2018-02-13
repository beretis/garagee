//
//  CreateCustomerVC.swift
//  garagee
//
//  Created by Jozef Matus on 13/02/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Contacts
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
	@IBOutlet weak var carsCollectionView: UICollectionView!
	@IBOutlet weak var addCarButton: UIButton!

	lazy var errorStream: Observable<AppError> = { [unowned self] in
		return self.viewModel.defaultErrorHandler.error.asObservable().map { error in
			error.convertToAppSpecificError()
		}
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
    }
    
    private func setupRx() {
        
    }
    
    func getContacts() {
        let store = CNContactStore()
        
        if CNContactStore.authorizationStatus(for: .contacts) == .notDetermined {
            store.requestAccess(for: .contacts, completionHandler: { (authorized: Bool, error: NSError?) -> Void in
                if authorized {
                    self.retrieveContactsWithStore(store)
                }
                } as! (Bool, Error?) -> Void)
        } else if CNContactStore.authorizationStatus(for: .contacts) == .authorized {
            self.retrieveContactsWithStore(store)
        }
    }
    
    func retrieveContactsWithStore(_ store: CNContactStore) {
        do {
            let groups = try store.groups(matching: nil)
            let predicate = CNContact.predicateForContactsInGroup(withIdentifier: groups[0].identifier)
            //let predicate = CNContact.predicateForContactsMatchingName("John")
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactEmailAddressesKey] as [Any]
            
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
            print("pes")
        } catch {
            print(error)
        }
    }
    
    //private
    private func setupNavigationBar() {
        let save = UIBarButtonItem(title: "Save".localized(), style: .done, target: nil, action: nil)
//        save.rx.tap.asObservable()
//            .map { _ -> (String?, String?, String?, String?, String?) in
//                let values = (brand: self.brandTextField.text, name: self.nameTextField.text, price: self.priceTextField.text, warranty: self.warrantyTextField.text, code: self.codeTextField.text)
//                return values
//            }
//            .bind(to: self.viewModel.save)
//            .disposed(by: self.disposeBag)
        self.navigationItem.setRightBarButtonItems([save], animated: true)
        
        let cancel = UIBarButtonItem(title: "Cancel".localized(), style: .plain, target: nil, action: nil)
        cancel.rx.tap.asObservable().bind(to: self.viewModel.cancel).disposed(by: self.disposeBag)
        self.navigationItem.setLeftBarButtonItems([cancel], animated: true)
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
