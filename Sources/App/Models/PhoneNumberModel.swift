import Vapor
import FluentPostgreSQL


final class PhoneNumberModel: Codable {
    var id: Int?
    var primaryNumber: String
    var secondaryNumberOne: String?
    var secondaryNumberTwo: String?
    var secondaryNumberThree: String?
    
    init(number: String) {
        primaryNumber = number
    }
}

extension PhoneNumberModel: PostgreSQLModel, Migration, Content, Parameter {}

