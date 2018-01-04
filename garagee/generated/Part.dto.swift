// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import Unbox

public class PartDTO: AutoEquatable, AutoHashable {
    ///sourcery: skipHashing
    var code: String?
    ///sourcery: skipHashing
    var id: String?
    ///sourcery: skipHashing
    var name: String?
    var warrantyDays: Int
    ///sourcery: skipHashing
    var order: Order?

    public init(code: String? , id: String? , name: String? , warrantyDays: Int , order: Order? ) { // swiftlint:disable:this line_length
        self.code = code
        self.id = id
        self.name = name
        self.warrantyDays = warrantyDays
        self.order = order
    }
}
