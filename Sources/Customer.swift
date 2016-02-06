import Foundation
import ObjectMapper

public struct Customer: Mappable {
    var id: Int?
    var createdAt: NSDate?
    var email: String?
    var firstName: String?
    var lastName: String?
    var username: String?
    var password: String?
    var lastOrderId: Int?
    var lastOrderDate: NSDate?
    var ordersCount: Int?
    var totalSpent: Int?
    var avatarUrl: NSURL?
    var billingAddress: Address?
    var shippingAddress: Address?
    var orders: [Order]?

    public init?(_ map: Map) {}

    mutating public func mapping(map: Map) {
        id <- map["id"]
        createdAt <- (map["created_at"], ISO8601DateTransform())
        email <- map["email"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        username <- map["username"]
        password <- map["password"]
        lastOrderId <- map["last_order_id"]
        lastOrderDate <- (map["last_order_date"], ISO8601DateTransform())
        ordersCount <- map["orders_count"]
        totalSpent <- map["total_spent"]
        avatarUrl <- (map["avatar_url"], URLTransform())
        billingAddress <- map["billing_address"]
        shippingAddress <- map["shipping_address"]
        orders <- map["orders"]
    }

    public static func get(id: Int, completion: (success: Bool, customer: Customer?) -> Void) {
        let client = Client.sharedClient
        client.get("customer", id: id, completion: completion)
    }

    public static func getOrders(customerId: Int, completion: (success: Bool, orders: [Order]?) -> Void) {
        let client = Client.sharedClient
        client.get("customers/\(customerId)/orders") { (success: Bool, value: Customer?) -> Void in
            guard let customer = value else {
                completion(success: false, orders: nil)
                return
            }
            guard let orders: [Order] = customer.orders else {
                completion(success: false, orders: nil)
                return
            }
            completion(success: success, orders: orders)
        }
    }
}
