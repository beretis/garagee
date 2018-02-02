// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable superfluous_disable_command file_length
// swiftlint:disable file_length
fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return compare(lValue, rValue)
    case (nil, nil):
        return true
    default:
        return false
    }
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}


// MARK: - AutoEquatable for classes, protocols, structs
// MARK: - CarDTO AutoEquatable
extension CarDTO: Equatable {}
public func == (lhs: CarDTO, rhs: CarDTO) -> Bool {
    guard compareOptionals(lhs: lhs.aditionalInfo, rhs: rhs.aditionalInfo, compare: ==) else { return false }
    guard lhs.brand == rhs.brand else { return false }
    guard compareOptionals(lhs: lhs.color, rhs: rhs.color, compare: ==) else { return false }
    guard lhs.firstRegistration == rhs.firstRegistration else { return false }
    guard lhs.id == rhs.id else { return false }
    guard compareOptionals(lhs: lhs.lastService, rhs: rhs.lastService, compare: ==) else { return false }
    guard lhs.milage == rhs.milage else { return false }
    guard lhs.model == rhs.model else { return false }
    guard compareOptionals(lhs: lhs.productionDate, rhs: rhs.productionDate, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.techInspection, rhs: rhs.techInspection, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.type, rhs: rhs.type, compare: ==) else { return false }
    guard lhs.orders == rhs.orders else { return false }
    guard compareOptionals(lhs: lhs.owner, rhs: rhs.owner, compare: ==) else { return false }
    return true
}
// MARK: - CustomerDTO AutoEquatable
extension CustomerDTO: Equatable {}
public func == (lhs: CustomerDTO, rhs: CustomerDTO) -> Bool {
    guard compareOptionals(lhs: lhs.email, rhs: rhs.email, compare: ==) else { return false }
    guard lhs.firstName == rhs.firstName else { return false }
    guard lhs.id == rhs.id else { return false }
    guard lhs.lastName == rhs.lastName else { return false }
    guard compareOptionals(lhs: lhs.phoneNumber, rhs: rhs.phoneNumber, compare: ==) else { return false }
    guard lhs.cars == rhs.cars else { return false }
    guard lhs.orders == rhs.orders else { return false }
    return true
}
// MARK: - OrderDTO AutoEquatable
extension OrderDTO: Equatable {}
public func == (lhs: OrderDTO, rhs: OrderDTO) -> Bool {
    guard lhs.createdAt == rhs.createdAt else { return false }
    guard lhs.price == rhs.price else { return false }
    guard lhs.id == rhs.id else { return false }
    guard lhs.name == rhs.name else { return false }
    guard lhs.repeatIntervalDays == rhs.repeatIntervalDays else { return false }
    guard lhs.subject == rhs.subject else { return false }
    guard compareOptionals(lhs: lhs.car, rhs: rhs.car, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.customer, rhs: rhs.customer, compare: ==) else { return false }
    guard lhs.usedParts == rhs.usedParts else { return false }
    return true
}
// MARK: - PartDTO AutoEquatable
extension PartDTO: Equatable {}
public func == (lhs: PartDTO, rhs: PartDTO) -> Bool {
    guard lhs.brand == rhs.brand else { return false }
    guard compareOptionals(lhs: lhs.code, rhs: rhs.code, compare: ==) else { return false }
    guard lhs.id == rhs.id else { return false }
    guard lhs.name == rhs.name else { return false }
    guard lhs.price == rhs.price else { return false }
    guard lhs.warrantyDays == rhs.warrantyDays else { return false }
    guard compareOptionals(lhs: lhs.order, rhs: rhs.order, compare: ==) else { return false }
    return true
}

// MARK: - AutoEquatable for Enums
