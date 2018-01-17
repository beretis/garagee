//
//  BaseViewController.swift
//  BlueBerryExampleProject
//
//  Created by Jozef Matus on 13/09/2017.
//  Copyright © 2017 Blueberry. All rights reserved.
//

import RxCocoa
import RxKeyboard
import RxSwift
import RxViewModel
import UIKit

class BaseViewController<VM: BaseViewModel>: UIViewController, UIGestureRecognizerDelegate {

    var viewModel: VM

    //Disposing
    var disposeBag = DisposeBag()
    //this dispose bag isn't disposed only when ViewController is deinitialised but also when it will dissapear
    var activeDisposeBag = DisposeBag()

    var xibName: String {
        return String(describing: type(of: self))
    }

    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

    init(viewModel: VM, nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nibNameOrNil, bundle: Bundle.main)
    }

    func hideBackButton() {
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem = nil
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardDismiss()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.activeDisposeBag = DisposeBag()
		self.viewModel.active = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBackButton()
		self.viewModel.active = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func setupKeyboardDismiss() {

        RxKeyboard.instance.visibleHeight
            .map { $0 > 0 }
            .distinctUntilChanged()
            .drive(onNext: { [unowned self] keyboardVisible in
                if keyboardVisible {
                    self.view.addGestureRecognizer(self.tap)
                } else {
                    self.view.removeGestureRecognizer(self.tap)
                }
        }).addDisposableTo(activeDisposeBag)

    }

	@objc func dismissKeyboard() {
        view.endEditing(true)
    }

    public func setupBackButton() {

    }
}
