// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import Unbox

public class CarDTO: AutoEquatable, AutoHashable {
    ///sourcery: skipHashing
    var aditionalInfo: String?
    var brand: String
    ///sourcery: skipHashing
    var color: String?
    ///sourcery: skipHashing
    var firstRegistration: Date
    var id: String
    ///sourcery: skipHashing
    ///sourcery: skipHashing
    var lastService: Date?
    var milage: Int32
    var model: String
    ///sourcery: skipHashing
    ///sourcery: skipHashing
    var productionDate: Date?
    ///sourcery: skipHashing
    ///sourcery: skipHashing
    var techInspection: Date?
    ///sourcery: skipHashing
    var type: String?
    ///sourcery: skipHashing
    var orders: [OrderDTO] = []
    ///sourcery: skipHashing
    var owner: Customer?

    public init(aditionalInfo: String? , brand: String , color: String? , firstRegistration: Date , id: String , lastService: Date? , milage: Int32 , model: String , productionDate: Date? , techInspection: Date? , type: String? , orders: Array<OrderDTO> , owner: Customer? ) { // swiftlint:disable:this line_length
        self.aditionalInfo = aditionalInfo
        self.brand = brand
        self.color = color
        self.firstRegistration = firstRegistration
        self.id = id
        self.lastService = lastService
        self.milage = milage
        self.model = model
        self.productionDate = productionDate
        self.techInspection = techInspection
        self.type = type
        self.orders = orders
        self.owner = owner
    }
}
