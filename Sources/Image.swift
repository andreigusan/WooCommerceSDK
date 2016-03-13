import ObjectMapper

public struct Image: Mappable {
    public var id: Int?
    public var createdAt: NSDate?
    public var updatedAt: NSDate?
    public var source: String?
    public var title: String?
    public var alt: String?
    public var position: Int?

    public init?(_ map: Map) {}

    mutating public func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        createdAt <- (map["created_at"], ISO8601DateTransform())
        updatedAt <- (map["updated_at"], ISO8601DateTransform())
        source <- map["src"]
        alt <- map["alt"]
        position <- map["position"]
    }
}
