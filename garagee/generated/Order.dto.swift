// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import Unbox

public class OrderDTO: AutoEquatable, AutoHashable {
    ///sourcery: skipHashing
    ///sourcery: skipHashing
    var createdAt: Date?
    ///sourcery: skipHashing
    var id: String?
    ///sourcery: skipHashing
    var name: String?
    var repeatIntervalDays: Int
    ///sourcery: skipHashing
    var subject: String?
    ///sourcery: skipHashing
    var car: Car?
    ///sourcery: skipHashing
    var customer: Customer?
    ///sourcery: skipHashing
    var usedParts: [PartDTO] = []

    public init(createdAt: Date? , id: String? , name: String? , repeatIntervalDays: Int , subject: String? , car: Car? , customer: Customer? , usedParts: Array<PartDTO> ) { // swiftlint:disable:this line_length
        self.createdAt = createdAt
        self.id = id
        self.name = name
        self.repeatIntervalDays = repeatIntervalDays
        self.subject = subject
        self.car = car
        self.customer = customer
        self.usedParts = usedParts
    }
}
