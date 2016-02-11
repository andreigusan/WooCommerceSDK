import Foundation
import ObjectMapper

public struct Customer: Mappable {
    public var id: Int?
    public var createdAt: NSDate?
    public var email: String?
    public var firstName: String?
    public var lastName: String?
    public var username: String?
    public var password: String?
    public var lastOrderId: Int?
    public var lastOrderDate: NSDate?
    public var ordersCount: Int?
    public var totalSpent: Int?
    public var avatarUrl: NSURL?
    public var billingAddress: Address?
    public var shippingAddress: Address?

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
    }

    public static func get(id: Int, completion: (success: Bool, customer: Customer?) -> Void) {
        let client = Client.sharedClient
        client.get("customer", id: id, completion: completion)
    }

    public static func getOrders(customerId: Int, completion: (success: Bool, orders: [Order]?) -> Void) {
        let client = Client.sharedClient
        client.getArray(.Orders, slug: "customers/\(customerId)/orders", completion: completion)
    }
}
