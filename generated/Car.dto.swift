// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import Unbox

public class CarDTO: AutoEquatable, AutoHashable {
    PICAA
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
    var fuel: String
    ///sourcery: skipHashing
    ///sourcery: skipHashing
    var productionDate: Date?
    ///sourcery: skipHashing
    ///sourcery: skipHashing
    var techInspection: Date?
    ///sourcery: skipHashing
    var engine: String?
    var orders: [OrderDTO] = []
    ///sourcery: skipHashing
    var owner: Customer?

    public init(brand: String , color: String? , firstRegistration: Date , id: String , lastService: Date? , milage: Int32 , model: String , fuel: String , productionDate: Date? , techInspection: Date? , engine: String? , orders: Array<OrderDTO> , owner: Customer? ) { // swiftlint:disable:this line_length
        self.brand = brand
        self.color = color
        self.firstRegistration = firstRegistration
        self.id = id
        self.lastService = lastService
        self.milage = milage
        self.model = model
        self.fuel = fuel
        self.productionDate = productionDate
        self.techInspection = techInspection
        self.engine = engine
        self.orders = orders
        self.owner = owner
    }
}
