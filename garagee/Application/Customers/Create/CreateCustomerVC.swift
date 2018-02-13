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
    
    private func setupRx() {
        
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

class CreateCustomerOrdersCollectionViewFlowDelegate: NSObject, UICollectionViewDelegate, ReusableCollectionView, UICollectionViewDelegateFlowLayout  {
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
