import Foundation
import ObjectMapper

public struct Statuses: Mappable {
    private var status: [String : String] = [:]

    public init?(_ map: Map) {}

    mutating public func mapping(map: Map) {
        status <- map["order_statuses"]
    }

    public func getStatusName(slug: String) -> String? {
        return status[slug]
    }
}
