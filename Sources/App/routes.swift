import Vapor
import Leaf
import Crypto

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    router.get() { req -> Future<View> in
        return try req.view().render("index")
    }
    
    router.post("hospital") { req -> Future<HospitalModel> in
        return try req.content.decode(HospitalModel.self)
            .flatMap(to: HospitalModel.self) { hospital in
                let temp = hospital.password
                hospital.password = try BCrypt.hash(temp)
                return hospital.save(on: req)
        }
    }
    
    router.get("hospital", "all") { req -> Future<[HospitalModel]> in
        return HospitalModel.query(on: req).all()
        
    }
    
    
}
