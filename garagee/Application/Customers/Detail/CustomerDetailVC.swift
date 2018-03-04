//
//  CustomerDetailVC.swift
//  garagee
//
//  Created by Jozef Matus on 13/02/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Localize_Swift
import RxCocoa
import RxSwift
import UIKit

class CustomerDetailVC: BaseViewController<CustomerDetailVM>, DefaultErrorPresenter {

    lazy var errorStream: Observable<AppError> = { [unowned self] in
        return self.viewModel.defaultErrorHandler.error.asObservable().map { error in
            error.convertToAppSpecificError()
        }
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupErrorPresenter()
    }
    
    //private
    private func setupNavigationBar() {
        let back = UIBarButtonItem(title: "Back".localized(), style: .done, target: nil, action: nil)
        back.rx.tap.asObservable()
            .bind(to: self.viewModel.back)
            .disposed(by: self.disposeBag)
        self.navigationItem.setLeftBarButtonItems([back], animated: true)

        let edit = UIBarButtonItem(title: "Edit".localized(), style: UIBarButtonItemStyle.plain, target: nil, action: nil)
//        cancel.rx.tap.asObservable().bind(to: self.viewModel.cancel).disposed(by: self.disposeBag)
        self.navigationItem.setRightBarButtonItems([edit], animated: true)
    }
    
}
