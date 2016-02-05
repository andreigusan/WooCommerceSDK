import Alamofire
import Foundation
import ObjectMapper

public struct Order: Mappable {
    var id: Int?

    public init?(_ map: Map) {}

    mutating public func mapping(map: Map) {
        id <- map["id"]
    }

    public static func get(id: Int, completion: (success: Bool, order: Order?) -> Void) {
        let client = Client.sharedClient
        let baseURL = NSURL(string: client.siteURL!)
        let requestURL = NSURL(string: "wc-api/v3/orders/\(id)", relativeToURL: baseURL)
        let requestURLString = requestURL!.absoluteString

        Alamofire.request(.GET, requestURLString)
            .authenticate(user: client.consumerKey!, password: client.consumerSecret!)
            .responseJSON { response in
                if response.result.isSuccess {
                    let order = Mapper<Order>().map(response.result.value!["order"])
                    completion(success: true, order: order)
                } else {
                    completion(success: false, order: nil)
                }
        }
    }
}
