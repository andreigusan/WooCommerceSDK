import Foundation
import ObjectMapper

public struct Order: Mappable {
    public var id: Int?
    public var orderKey: String?
    public var orderNumber: Int?
    public var createdAt: NSDate?
    public var updatedAt: NSDate?
    public var completedAt: NSDate?
    public var status: String?
    public var currency: String?
    public var total: NSDecimalNumber?
    public var subtotal: NSDecimalNumber?
    public var totalLineItemQuantity: Int?
    public var totalTax: NSDecimalNumber?
    public var totalShipping: NSDecimalNumber?
    public var cartTax: NSDecimalNumber?
    public var shippingTax: NSDecimalNumber?
    public var totalDiscount: NSDecimalNumber?
    public var shippingMethods: String?
    public var paymentDetails: PaymentDetails?
    public var billingAddress: Address?
    public var shippingAddress: Address?
    public var note: String?
    public var customerIp: String?
    public var customerUserAgent: String?
    public var customerId: Int?
    public var viewOrderUrl: NSURL?
    public var lineItems: [LineItem]?
    public var shippingLines: String?
    public var taxLines: String?
    public var feeLines: String?
    public var couponLines: String?
    public var customer: Customer?

    public init() {}

    public init?(_ map: Map) {}

    mutating public func mapping(map: Map) {
        id <- map["id"]
        orderKey <- map["order_key"]
        orderNumber <- map["order_number"]
        createdAt <- (map["created_at"], ISO8601DateTransform())
        updatedAt <- (map["updated_at"], ISO8601DateTransform())
        completedAt <- (map["completed_at"], ISO8601DateTransform())
        status <- map["status"]
        currency <- map["currency"]
        total <- (map["total"], NSDecimalNumberTransform())
        subtotal <- (map["subtotal"], NSDecimalNumberTransform())
        totalLineItemQuantity <- map["total_line_items_quantity"]
        totalTax <- (map["total_tax"], NSDecimalNumberTransform())
        totalShipping <- (map["total_shipping"], NSDecimalNumberTransform())
        cartTax <- (map["cart_tax"], NSDecimalNumberTransform())
        shippingTax <- (map["shipping_tax"], NSDecimalNumberTransform())
        totalDiscount <- (map["total_discount"], NSDecimalNumberTransform())
        shippingMethods <- map["shipping_methods"]
        paymentDetails <- map["payment_details"]
        billingAddress <- map["billing_address"]
        shippingAddress <- map["shipping_address"]
        note <- map["note"]
        customerIp <- map["customer_ip"]
        customerUserAgent <- map["customer_user_agent"]
        customerId <- map["customer_id"]
        viewOrderUrl <- (map["view_order_url"], URLTransform())
        lineItems <- map["line_items"]
        shippingLines <- map["shipping_lines"]
        lineItems <- map["line_items"]
        taxLines <- map["tax_lines"]
        feeLines <- map["fee_lines"]
        couponLines <- map["coupon_lines"]
        customer <- map["customer"]
    }

    public static func get(id: Int, completion: ((success: Bool, order: Order?) -> Void)?) {
        let client = Client.sharedClient
        client.get("order", id: id, completion: completion)
    }

    public static func create(order: Order, completion: ((success: Bool, order: Order?) -> Void)?) {
        let client = Client.sharedClient
        let parameters = [
            "order": order.toJSON()
        ]
        client.post("order", parameters: parameters, completion: completion)
    }

    public static func update(id: Int, payment: PaymentDetails, completion: ((success: Bool, order: Order?) -> Void)?) {
        let client = Client.sharedClient
        let parameters = [
            "order": [
                "payment_details": payment.toJSON()
            ]
        ]
        client.put("order", id: id, parameters: parameters, completion: completion)
    }

    public static func delete(id: Int, force: Bool = false, completion: ((success: Bool) -> Void)?) {
        let client = Client.sharedClient
        let parameters = [
            "force": (force ? "true" : "false")
        ]
        client.delete("order", id: id, parameters: parameters, completion: completion)
    }
}
