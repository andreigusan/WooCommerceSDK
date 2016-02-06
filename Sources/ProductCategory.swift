import Foundation
import ObjectMapper

public struct ProductCategory: Mappable {
    var id: Int?
    var name: String?
    var slug: String?
    var parent: Int?
    var description: String?
    var display: String?
    var image: NSURL?
    var count: Int?

    public init?(_ map: Map) {}

    public init() {}

    mutating public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        slug <- map["slug"]
        parent <- map["parent"]
        description <- map["description"]
        display <- map["display"]
        image <- map["image"]
        count <- map["count"]
    }

    public static func getAll(limit limit: Int = 10, completion: (success: Bool, orders: [ProductCategory]?) -> Void) {
        let client = Client.sharedClient
        client.getArray(.ProductCategories, slug: "products/categories", limit: limit, completion: completion)
    }
}
