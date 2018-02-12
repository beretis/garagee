//
//  ErrorHandling.swift
//  BlueBerryExampleProject
//
//  Created by Jozef Matus on 19/09/2017.
//  Copyright © 2017 Blueberry. All rights reserved.
//

import Foundation
import Moya
import RxCocoa
import RxSwift
import Unbox

private var errorHandlerContext: UInt8 = 0

public protocol RxDefaultErrorHandlable: Synchronizable {
	var defaultErrorHandler: RxErrorHandler { get }
}

public extension RxDefaultErrorHandlable {
	public var defaultErrorHandler: RxErrorHandler {
		return self.synchronized {
			if let defaultErrorHandlerObject = objc_getAssociatedObject(self, &errorHandlerContext) as? RxErrorHandler {
				return defaultErrorHandlerObject
			}
			let defaultErrorHandlerObject = RxDefaultErrorHandler()
			objc_setAssociatedObject(self, &errorHandlerContext, defaultErrorHandlerObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			return defaultErrorHandlerObject
		}
	}
}

public protocol RxErrorHandler {
	var handler: ((Swift.Error) -> Void) { get }
	var error: PublishSubject<Swift.Error> { get }
}

public class RxDefaultErrorHandler: RxErrorHandler {

	public lazy var handler: ((Swift.Error) -> Void) = { error in
		let appSpecificError = error.convertToAppSpecificError()
		//here you can do custom actions based on error type
		switch appSpecificError {
		default: break
		}
		self.error.on(.next(error))
	}
	public var error: PublishSubject<Swift.Error> = PublishSubject<Swift.Error>()
}

public protocol ErrorPresenter: class {
	var errorStream: Observable<AppError> { get }
	var disposeBag: DisposeBag { get }

	func setupErrorPresenter()
}

public protocol DefaultErrorPresenter: ErrorPresenter {}

extension DefaultErrorPresenter {

	func setupErrorPresenter() {
		self.errorStream
			.filter { $0.showAlert }
			.map { error in
				return UIAlertController.alertWithError(error)
			}.subscribe(onNext: { [unowned self] alert in
				if self is UIViewController {
					alert.show((self as! UIViewController))
				} else {
					alert.show()
				}
			}).disposed(by: self.disposeBag)
	}
}

extension ObservableType {
	public func subscribeWithErrorHanlder(onNext: ((Self.E) -> Swift.Void)? = nil, withDefaultHandler errorHandler: RxErrorHandler, onCompleted: (() -> Swift.Void)? = nil, onDisposed: (() -> Swift.Void)? = nil) -> Disposable {
		return self.subscribe(onNext: onNext, onError: errorHandler.handler, onCompleted: onCompleted, onDisposed: onDisposed)
	}

	public func handleErrorWith(errorHandler: RxErrorHandler) -> Self {
		return self.do(onError:  errorHandler.handler) as! Self
	}

}

public protocol NetworkErrorMapper {
	func contextualErrorFor(_ error: Swift.Error) -> AppSpecificError
}

/*
Every project needs to have its own error but this is for general idea
how it can be implemented
*/
public protocol AppSpecificError {
	var description: String? { get }
	var showAlert: Bool { get }
}

public enum AppError: Swift.Error, AppSpecificError {
	case networkError(code: Int, apiCall: Moya.TargetType?)
	case withMessage(message: String)
	case unexpectedError(message: String?)
	case validationFailed(message: String?)

	public var description: String? {
		switch self {
		case let .networkError(statusCode, apiCall):
			return "network error with status code \(statusCode) while calling \(apiCall?.path ?? "unknown") api"
		case .withMessage(let message):
			return "error with \(message)"
		case .unexpectedError(let message):
			return "Opps something went wrong \(message ?? "")"
		case .validationFailed(let message) :
			return "\(message ?? "Validation failed")"
		}
	}

	/*
	There are some error which you don't want to present to user, and others which you want to display.
	This variable is for defining it
	*/
	public var showAlert: Bool {
		#if DEBUG
			return true
		#else
			//you can choose which errors should be propagated to user
			switch self {
			default:
				return true
			}
		#endif
	}
}

/// Provides a function to prevent concurrent block execution
public protocol Synchronizable: class {
}

extension Synchronizable {
	func synchronized<T>( _ action: () -> T) -> T {
		objc_sync_enter(self)
		let result = action()
		objc_sync_exit(self)
		return result
	}
}


extension Swift.Error {

	func convertToAppSpecificError(apiCall: TargetType? = nil) -> AppError {
		if self is AppSpecificError {
			return self as! AppError
		}
		if self is UnboxError {
			return AppError.unexpectedError(message: (self as! UnboxError).description)
		}
		if self is MoyaError {
			switch self as! MoyaError {
			case .statusCode(let response):
				switch response.statusCode {
				default:
					return AppError.networkError(code: response.statusCode, apiCall: apiCall)
				}
			case let .underlying(error, response):
				if error._code == NSURLErrorTimedOut {
					return AppError.unexpectedError(message: "request timed out")
				}
				return AppError.unexpectedError(message: "Ooops something went wrong response \(response.debugDescription)")
			default:
				return AppError.unexpectedError(message: "\((self as! MoyaError).errorDescription ?? "Oppes something went wrong")")
			}
		}
		return AppError.withMessage(message: (self as NSError).localizedDescription)
	}
}

