import Foundation
import ObjectMapper

public struct LineItem: Mappable{
    var id: Int?
    var subtotal: Float?
    var subtotalTax: Float?
    var total: Float?
    var totalTax: Float?
    var price: Float?
    var quantity: Int?
    var taxClass: String?
    var name: String?
    var productId: Int?
    var sku: String?
    var meta: [String: String]?

    public init?(_ map: Map) {}

    mutating public func mapping(map: Map) {
        id <- map["id"]
        subtotal <- (map["subtotal"], FloatTransform())
        subtotalTax <- (map["subtotal_tax"], FloatTransform())
        total <- (map["total"], FloatTransform())
        totalTax <- (map["total_tax"], FloatTransform())
        price <- (map["price"], FloatTransform())
        quantity <- map["quantity"]
        taxClass <- map["tax_class"]
        name <- map["name"]
        productId <- map["product_id"]
        sku <- map["sku"]
        meta <- map["meta"]
    }
}
