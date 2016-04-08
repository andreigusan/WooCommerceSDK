import Foundation
import ObjectMapper

public struct LineItem: Mappable{
    public var id: Int?
    public var subtotal: Double?
    public var subtotalTax: Double?
    public var total: Double?
    public var totalTax: Double?
    public var price: Double?
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
        subtotal <- (map["subtotal"], DoubleTransform())
        subtotalTax <- (map["subtotal_tax"], DoubleTransform())
        total <- (map["total"], DoubleTransform())
        totalTax <- (map["total_tax"], DoubleTransform())
        price <- (map["price"], DoubleTransform())
        quantity <- map["quantity"]
        taxClass <- map["tax_class"]
        name <- map["name"]
        productId <- map["product_id"]
        sku <- map["sku"]
        meta <- map["meta"]
    }
}
