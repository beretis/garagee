//
//  String+SplitString.swift
//  BlueBerryExampleProject
//
//  Created by Jozef Matus on 11/09/2017.
//  Copyright © 2017 Blueberry. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func splitByLength(_ length: Int) -> [String] {
        var result = [String]()
        var collectedCharacters = [Character]()
        collectedCharacters.reserveCapacity(length)
        var count = 0

        for character in self.characters {
            collectedCharacters.append(character)
            count += 1
            if count == length {
                // Reached the desired length
                count = 0
                result.append(String(collectedCharacters))
                collectedCharacters.removeAll(keepingCapacity: true)
            }
        }

        // Append the remainder
        if !collectedCharacters.isEmpty {
            result.append(String(collectedCharacters))
        }

        return result
    }

    func truncate(length: Int) -> String {
        if self.characters.count > length {
            return String(self.characters.prefix(length))
        } else {
            return self
        }
    }

    func underline() -> NSAttributedString {
		let textRange = NSRange(location: 0, length: self.characters.count)
        let attributedText = NSMutableAttributedString(string: self)
		attributedText.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
        return attributedText
    }
}

func randomString(length: Int) -> String {

    let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let len = UInt32(letters.length)

    var randomString = ""

    for _ in 0 ..< length {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }

    return randomString
}

public func == (lhs: String?, rhs: String) -> Bool {
    guard let lhs = lhs else {
        return false
    }
    return lhs == rhs
}
