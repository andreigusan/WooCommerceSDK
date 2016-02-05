import Alamofire
import Foundation
import ObjectMapper

public struct Address: Mappable {
    var firstName: String?
    var lastName: String?
    var company: String?
    var address1: String?
    var address2: String?
    var city: String?
    var state: String?
    var postcode: String?
    var country: String?
    var email: String?
    var phone: String?

    public init?(_ map: Map) {}

    mutating public func mapping(map: Map) {
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        company <- map["company"]
        address1 <- map["address_1"]
        address2 <- map["address_2"]
        city <- map["city"]
        state <- map["state"]
        postcode <- map["postcode"]
        country <- map["country"]
        email <- map["email"]
        phone <- map["phone"]
    }
}
