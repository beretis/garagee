// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import RxCocoa
import RxSwift
import RxViewModel

class CreateCustomerVCVM: BaseViewModel, RxDefaultErrorHandlable {

    public var defaultHandler: RxErrorHandler

	init(coordinator: ExploreCoordinatorType, defaultErrorHandler: RxErrorHandler) {
		self.defaultHandler = defaultErrorHandler
        super.init()
		self.coordinator = coordinator
		self.setupRx()
    }

    private func setupRx() {
    }
}
