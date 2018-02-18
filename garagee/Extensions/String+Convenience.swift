//
//  String+Convenience.swift
//  BlueBerryExampleProject
//
//  Created by Jozef Matus on 11/09/2017.
//  Copyright © 2017 Blueberry. All rights reserved.
//

import Foundation

extension String {

    //To check text field or String is blank or not
    var isBlank: Bool {
		let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
		return trimmed.isEmpty
    }

    //Validate Email
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
			return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: self.characters.count)) != nil
        } catch {
            return false
        }
    }

	static func validate(OptionalStringInput input: String?) -> Bool {
		if let input = input {
			guard !input.isBlank else { return false }
		}
		return true
	}

	static func md5(_ string: String) -> String {
		let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
		var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
		CC_MD5_Init(context)
		CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
		CC_MD5_Final(&digest, context)
		context.deallocate(capacity: 1)
		var hexString = ""
		for byte in digest {
			hexString += String(format:"%02x", byte)
		}

		return hexString
	}


//    
//    //validate PhoneNumber
//    var isPhoneNumber: Bool {
//        
//        let charcter  = CharacterSet(charactersIn: "+0123456789").inverted
//        var filtered:NSString!
//        let inputString = self.components(separatedBy: charcter)
//        filtered = inputString.componentsJoined(by: "") as String
//        return  self == filtered
//        
//    }
}
