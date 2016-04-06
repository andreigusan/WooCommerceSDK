import Foundation
import ObjectMapper

public struct PaymentDetails: Mappable {
    public var methodId: String?
    public var methodTitle: String?
    public var paid: Bool?
    public var transactionId: String?

    public init() {}

    public init?(_ map: Map) {}

    mutating public func mapping(map: Map) {
        methodId <- map["method_id"]
        methodTitle <- map["method_title"]
        paid <- map["paid"]
        transactionId <- map["transaction_id"]
    }
}
