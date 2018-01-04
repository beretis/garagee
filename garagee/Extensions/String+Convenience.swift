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
