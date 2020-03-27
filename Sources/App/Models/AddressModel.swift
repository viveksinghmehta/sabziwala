import Vapor
import FluentPostgreSQL

final class AddressModel: Codable {
    var id: Int?
    var state: String
    var pincode: Int
    var country: String
    var address: String
    var street: String?
    var city: String
    
    init(state: String, pincode: Int, country: String, address: String, city: String) {
        self.state = state
        self.pincode = pincode
        self.country = country
        self.address = address
        self.city = city
    }
}

extension AddressModel: PostgreSQLModel, Migration, Content, Parameter {}
