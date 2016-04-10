import Foundation
import ObjectMapper

public struct LineItem: Mappable{
    public var id: Int?
    public var subtotal: NSDecimalNumber?
    public var subtotalTax: NSDecimalNumber?
    public var total: NSDecimalNumber?
    public var totalTax: NSDecimalNumber?
    public var price: NSDecimalNumber?
    public var quantity: Int?
    public var taxClass: String?
    public var name: String?
    public var productId: Int?
    public var sku: String?
    public var meta: [ItemMeta]?

    public init() {}

    public init?(_ map: Map) {}

    mutating public func mapping(map: Map) {
        id <- map["id"]
        subtotal <- (map["subtotal"], NSDecimalNumberTransform())
        subtotalTax <- (map["subtotal_tax"], NSDecimalNumberTransform())
        total <- (map["total"], NSDecimalNumberTransform())
        totalTax <- (map["total_tax"], NSDecimalNumberTransform())
        price <- (map["price"], NSDecimalNumberTransform())
        quantity <- map["quantity"]
        taxClass <- map["tax_class"]
        name <- map["name"]
        productId <- map["product_id"]
        sku <- map["sku"]
        meta <- map["meta"]
    }
}
