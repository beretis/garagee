//
//  MBProgressHUD+ReactiveObserver.swift
//  BlueBerryExampleProject
//
//  Created by Jozef Matus on 29/09/2017.
//  Copyright © 2017 Blueberry. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import MBProgressHUD

extension MBProgressHUD {
	/**
	Bindable sink for MBProgressHUD show/hide methods.
	*/

	public var rxHandle: AnyObserver<Bool> {
		return AnyObserver { event in
			MainScheduler.ensureExecutingOnScheduler()

			switch (event) {
			case .next(let value):
				if value {
					self.show(animated: true)
				} else {
					self.hide(animated: true)
				}
			case .error(let error):
				let error = "Binding error to UI: \(error)"
				#if DEBUG
					fatalError(error)
				#else
					print(error)
				#endif
			case .completed:
				break
			}
		}
	}

}

