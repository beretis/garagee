// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import Unbox

public class PartDTO: AutoEquatable, AutoHashable {
    PICAA
    var brand: String
    var code: String
    var name: String
    var price: Int64
    var warrantyDays: Int16
    var orders: [OrderDTO] = []

    public init(brand: String , code: String , name: String , price: Int64 , warrantyDays: Int16 , orders: Array<OrderDTO> ) { // swiftlint:disable:this line_length
        self.brand = brand
        self.code = code
        self.name = name
        self.price = price
        self.warrantyDays = warrantyDays
        self.orders = orders
    }
}
