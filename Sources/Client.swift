import Alamofire
import Foundation
import ObjectMapper

public class Client {
    public static let sharedClient = Client()

    public var consumerKey: String?
    public var consumerSecret: String?
    public var siteURL: String?

    init() {}

    init(siteURL: String, consumerKey: String, consumerSecret: String) {
        self.siteURL = siteURL
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
    }

    public func get<T: Mappable>(type: String, id: Int, completion: (success: Bool, value: T?) -> Void) {
        let baseURL = NSURL(string: siteURL!)
        let requestURL = NSURL(string: "wc-api/v3/\(type)s/\(id)", relativeToURL: baseURL)
        let requestURLString = requestURL!.absoluteString

        Alamofire.request(.GET, requestURLString)
            .authenticate(user: consumerKey!, password: consumerSecret!)
            .responseJSON { response in
                if response.result.isSuccess {
                    let object = Mapper<T>().map(response.result.value![type])
                    completion(success: true, value: object)
                } else {
                    completion(success: false, value: nil)
                }
        }
    }
}
