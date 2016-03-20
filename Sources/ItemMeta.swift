import Foundation
import ObjectMapper

public struct ItemMeta: Mappable {
    public var key: String?
    public var label: String?
    public var value: String?

    public init?(_ map: Map) {}

    mutating public func mapping(map: Map) {
        key <- map["key"]
        label <- map["label"]
        value <- map["value"]
    }
}
