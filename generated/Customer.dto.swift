// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import Unbox

public class CustomerDTO: AutoEquatable, AutoHashable {
    PICAA
    ///sourcery: skipHashing
    var email: String?
    ///sourcery: skipHashing
    var firstName: String?
    var id: String
    ///sourcery: skipHashing
    var lastName: String?
    ///sourcery: skipHashing
    var phoneNumber: String?
    var cars: [CarDTO] = []

    public init(email: String? , firstName: String? , id: String , lastName: String? , phoneNumber: String? , cars: Array<CarDTO> ) { // swiftlint:disable:this line_length
        self.email = email
        self.firstName = firstName
        self.id = id
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.cars = cars
    }
}
