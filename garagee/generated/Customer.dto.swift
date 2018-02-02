// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import Unbox

public class CustomerDTO: AutoEquatable, AutoHashable {
    ///sourcery: skipHashing
    var email: String?
    var firstName: String
    var id: String
    var lastName: String
    ///sourcery: skipHashing
    var phoneNumber: String?
    ///sourcery: skipHashing
    var cars: [CarDTO] = []
    ///sourcery: skipHashing
    var orders: [OrderDTO] = []

    public init(email: String? , firstName: String , id: String , lastName: String , phoneNumber: String? , cars: Array<CarDTO> , orders: Array<OrderDTO> ) { // swiftlint:disable:this line_length
        self.email = email
        self.firstName = firstName
        self.id = id
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.cars = cars
        self.orders = orders
    }
}
