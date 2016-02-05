import Foundation
import ObjectMapper

public struct Product: Mappable {
    var title: String?
    var id: Int?
    var createdAt: NSDate?
    var updatedAt: NSDate?
    var type: String?
    var status: String?
    var downloadable: Bool?
    var virtual: Bool?
    var permalink: NSURL?
    var sku: String?
    var price: Float?
    var regularPrice: Float?
    var salePrice: Float?
    var salePriceDatesFrom: NSDate?
    var salePriceDatesTo: NSDate?
    var priceHtml: String?
    var taxable: Bool?
    var taxStatus: String?
    var taxClass: String?
    var managingStock: Bool?
    var stockQuantity: Int?
    var inStock: Bool?
    var backordersAllowed: Bool?
    var backordered: Bool?
    var backorders: String?
    var soldIndividually: Bool?
    var purchaseable: Bool?
    var featured: Bool?
    var visible: Bool?
    var catalogVisibility: String?
    var onSale: Bool?
    var weight: String?
    var dimensions: String?
    var shippingRequired: Bool?
    var shippingTaxable: Bool?
    var shippingClass: String?
    var shippingClassId: Int?
    var description: String?
    var enableHtmlDescription: Bool?
    var shortDescription: String?
    var enableHtmlShortDescription: Bool?
    var reviewsAllowed: Bool?
    var averageRating: String?
    var ratingCount: Int?
    var relatedIds: String?
    var upsellIds: String?
    var crossSellIds: String?
    var parentId: Int?
    var categories: String?
    var tags: String?
    var images: String?
    var featuredSrc: String?
    var attributes: String?
    var defaultAttributes: String?
    var downloads: String?
    var downloadLimit: Int?
    var downloadExpiry: Int?
    var downloadType: String?
    var purchaseNote: String?
    var totalSales: Int?
    var variations: String?
    var parent: String?
    var productUrl: NSURL?
    var buttonText: String?
    var menuOrder: Int?

    public init?(_ map: Map) {}

    mutating public func mapping(map: Map) {
        title <- map["title"]
        id <- map["id"]
        createdAt <- (map["created_at"], ISO8601DateTransform())
        updatedAt <- (map["updated_at"], ISO8601DateTransform())
        type <- map["type"]
        status <- map["status"]
        downloadable <- map["downloadable"]
        virtual <- map["virtual"]
        permalink <- (map["permalink"], URLTransform())
        sku <- map["sku"]
        price <- (map["price"], FloatTransform())
        regularPrice <- (map["regular_price"], FloatTransform())
        salePrice <- (map["sale_price"], FloatTransform())
        salePriceDatesFrom <- map["sale_price_dates_from"]
        salePriceDatesTo <- map["sale_price_dates_to"]
        priceHtml <- map["price_html"]
        taxable <- map["taxable"]
        taxStatus <- map["tax_status"]
        taxClass <- map["tax_class"]
        managingStock <- map["managing_stock"]
        stockQuantity <- map["stock_quantity"]
        inStock <- map["in_stock"]
        backordersAllowed <- map["backorders_allowed"]
        backordered <- map["backordered"]
        backorders <- map["backorders"]
        soldIndividually <- map["sold_individually"]
        purchaseable <- map["purchaseable"]
        featured <- map["featured"]
        visible <- map["visible"]
        catalogVisibility <- map["catalog_visibility"]
        onSale <- map["on_sale"]
        weight <- map["weight"]
        dimensions <- map["dimensions"]
        shippingRequired <- map["shipping_required"]
        shippingTaxable <- map["shipping_taxable"]
        shippingClass <- map["shipping_class"]
        shippingClassId <- map["shipping_class_id"]
        description <- map["description"]
        enableHtmlDescription <- map["enable_html_description"]
        shortDescription <- map["short_description"]
        enableHtmlShortDescription <- map["enable_html_short_description"]
        reviewsAllowed <- map["reviews_allowed"]
        averageRating <- map["average_rating"]
        ratingCount <- map["rating_count"]
        relatedIds <- map["related_ids"]
        upsellIds <- map["upsell_ids"]
        crossSellIds <- map["cross_sell_ids"]
        parentId <- map["parent_id"]
        categories <- map["categories"]
        tags <- map["tags"]
        images <- map["images"]
        featuredSrc <- map["featured_src"]
        attributes <- map["attributes"]
        defaultAttributes <- map["default_attributes"]
        downloads <- map["downloads"]
        downloadLimit <- map["download_limit"]
        downloadExpiry <- map["download_expiry"]
        downloadType <- map["download_type"]
        purchaseNote <- map["purchase_note"]
        totalSales <- map["total_sales"]
        variations <- map["variations"]
        parent <- map["parent"]
        productUrl <- (map["product_url"], URLTransform())
        buttonText <- map["button_text"]
        menuOrder <- map["menu_order"]
    }

    public static func get(id: Int, completion: (success: Bool, product: Product?) -> Void) {
        let client = Client.sharedClient
        client.get("product", id: id, completion: completion)
    }
}
