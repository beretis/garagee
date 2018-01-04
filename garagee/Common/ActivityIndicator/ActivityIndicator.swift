//
//  ActivityIndicator.swift
//  RxSwiftUtilities
//
//  Created by Jesse Farless on 11/21/16.
//  Copyright © 2016 RxSwiftCommunity. All rights reserved.
//
//  This file was copied from RxSwift's example app:
//  https://github.com/ReactiveX/RxSwift/blob/d6dfcfa/RxExample/RxExample/Services/ActivityIndicator.swift
//
import Foundation
import NVActivityIndicatorView
import RxCocoa
import RxSwift

private struct ActivityToken<E> : ObservableConvertibleType, Disposable {
	private let _source: Observable<E>
	private let _dispose: Cancelable

	init(source: Observable<E>, disposeAction: @escaping () -> Void) {
		_source = source
		_dispose = Disposables.create(with: disposeAction)
	}

	func dispose() {
		_dispose.dispose()
	}

	func asObservable() -> Observable<E> {
		return _source
	}
}

/**
Enables monitoring of sequence computation.
If there is at least one sequence computation in progress, `true` will be sent.
When all activities complete `false` will be sent.
*/
public class ActivityIndicator: SharedSequenceConvertibleType {
	var activityData: ActivityData?
	public typealias E = Bool
	public typealias SharingStrategy = DriverSharingStrategy

	public var autoShowHud: Bool = true

	private let _lock = NSRecursiveLock()
	private let _variable = Variable(0)
	private let _loading: SharedSequence<SharingStrategy, Bool>
	private var _text: String?
	private let disposeBag = DisposeBag()
	public var text: String? {
		get {
			return _text
		} set {
			self._text = newValue
			NVActivityIndicatorPresenter.sharedInstance.setMessage(_text)
		}
	}

	public init() {
		_loading = _variable.asDriver()
			.map { $0 > 0 }
			.distinctUntilChanged()

		_variable.asDriver()
			.map { $0 > 0 }
			.distinctUntilChanged()
			.asObservable()
			.subscribe(onNext: { [unowned self] (loading) in
				guard self.autoShowHud else { return }
				if loading {
					self.showHud()
				} else {
					self.hideHud()
				}
			}).addDisposableTo(disposeBag)

	}

	fileprivate func trackActivityOfObservable<O: ObservableConvertibleType>(_ source: O) -> Observable<O.E> {
		return Observable.using({ () -> ActivityToken<O.E> in
			self.increment()
			return ActivityToken(source: source.asObservable(), disposeAction: self.decrement)
		}, observableFactory: { t in
			return t.asObservable()
		})
	}

	private func increment() {
		_lock.lock()
		_variable.value += 1
		_lock.unlock()
	}

	private func decrement() {
		_lock.lock()
		_variable.value -= 1
		_lock.unlock()
	}

	public func asSharedSequence() -> SharedSequence<SharingStrategy, E> {
		return _loading
	}

	private func showHud() {
		activityData = ActivityData(message: text, messageFont: UIFont.systemFont(ofSize: 15), textColor: UIColor.black)
		NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData!)
	}

	private func hideHud() {
		NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
	}

}

extension ObservableConvertibleType {
	public func trackActivity(_ activityIndicator: ActivityIndicator) -> Observable<E> {
		return activityIndicator.trackActivityOfObservable(self)
	}
}
