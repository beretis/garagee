//
//  CustomerDTO+ID.swift
//  garagee
//
//  Created by Jozef Matus on 16/02/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import Localize_Swift

public extension CustomerDTO {

	static func createId(ForName name: String?, surname: String?, email: String?, phone: String?) throws -> String {
		let name = name ?? ""
		let surname = surname ?? ""
		let email = email ?? ""
		let phone = phone ?? ""
		let idString = "\(name)\(surname)\(email)\(phone)"
		guard idString.count > 0 else { throw AppError.unexpectedError(message: "error_customer_id_stringTooShort_md5".localized()) }
		return String.md5(idString)
	}

}
