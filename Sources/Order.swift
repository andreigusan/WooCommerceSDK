import Alamofire
import Foundation
import ObjectMapper

public struct Order: Mappable {
    var id: Int?
    var orderNumber: Int?
    var createdAt: NSDate?
    var updatedAt: NSDate?
    var completedAt: NSDate?
    var status: String?
    var currency: String?
    var total: String?
    var subtotal: String?
    var totalLineItemQuantity: Int?
    var totalTax: String?
    var totalShipping: String?
    var cartTax: String?
    var shippingTax: String?
    var totalDiscount: String?
    var shippingMethods: String?
    var paymentDetails: String?
    var billingAddress: String?
    var shippingAddress: String?
    var note: String?
    var customerIp: String?
    var customerUserAgent: String?
    var customerId: Int?
    var viewOrderUrl: NSURL?
    var lineItems: String?
    var shippingLines: String?
    var taxLines: String?
    var feeLines: String?
    var couponLines: String?
    var customer: Customer?

    public init?(_ map: Map) {}

    mutating public func mapping(map: Map) {
        id <- map["id"]
        orderNumber <- map["order_number"]
        createdAt <- (map["created_at"], ISO8601DateTransform())
        updatedAt <- (map["updated_at"], ISO8601DateTransform())
        completedAt <- (map["completed_at"], ISO8601DateTransform())
        status <- map["status"]
        currency <- map["currency"]
        total <- map["total"]
        subtotal <- map["subtotal"]
        totalLineItemQuantity <- map["total_line_items_quantity"]
        totalTax <- map["total_tax"]
        totalShipping <- map["total_shipping"]
        cartTax <- map["cart_tax"]
        shippingTax <- map["shipping_tax"]
        totalDiscount <- map["total_discount"]
        shippingMethods <- map["shipping_methods"]
        paymentDetails <- map["payment_details"]
        billingAddress <- map["billing_address"]
        id <- map["shipping_address"]
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

    public static func get(id: Int, completion: (success: Bool, order: Order?) -> Void) {
        let client = Client.sharedClient
        client.get("order", id: id, completion: completion)
    }
}
