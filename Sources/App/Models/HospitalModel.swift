
import Vapor
import FluentPostgreSQL

final class HospitalModel: Codable {
    var id: Int?
    var code: String?
    var name: String
    var email: String
    var phone: PhoneNumberModel?
    var secondaryEmail: String?
    var Location: String?
    var password: String
    var address: AddressModel?
    
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
    
    
}


extension HospitalModel : PostgreSQLModel, Migration, Content, Parameter {
    
    static func addProperties(to builder: SchemaCreator<HospitalModel>) throws {
        builder.unique(on: \.email)
        builder.unique(on: \.code)
    }
    
}
