// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import Unbox

public class PartDTO: AutoEquatable, AutoHashable {
    var brand: String
    ///sourcery: skipHashing
    var code: String?
    var id: String
    var name: String
    var price: Int
    var warrantyDays: Int
    ///sourcery: skipHashing
    var order: Order?

    public init(brand: String , code: String? , id: String , name: String , price: Int , warrantyDays: Int , order: Order? ) { // swiftlint:disable:this line_length
        self.brand = brand
        self.code = code
        self.id = id
        self.name = name
        self.price = price
        self.warrantyDays = warrantyDays
        self.order = order
    }
}
