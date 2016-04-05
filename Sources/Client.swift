import Alamofire
import Foundation
import ObjectMapper

public class Client {
    public static let sharedClient = Client()

    public var consumerKey: String?
    public var consumerSecret: String?
    public var siteURL: String?

    public var statuses: Statuses?

    init() {}

    init(siteURL: String, consumerKey: String, consumerSecret: String) {
        self.siteURL = siteURL
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
    }

    public func getStatuses(completion: ((success: Bool, value: Statuses?) -> Void)?) {
        let baseURL = NSURL(string: siteURL!)
        let requestURL = NSURL(string: "wc-api/v3/orders/statuses", relativeToURL: baseURL)
        let requestURLString = requestURL!.absoluteString

        guard let user = consumerKey, password = consumerSecret else {
            guard let completion = completion else { return }
            completion(success: false, value: nil)
            return
        }

        Alamofire.request(.GET, requestURLString)
            .authenticate(user: user, password: password)
            .responseJSON { response in
                if response.result.isSuccess {
                    self.statuses = Mapper<Statuses>().map(response.result.value!)
                    guard let completion = completion else { return }
                    completion(success: true, value: self.statuses)
                } else {
                    guard let completion = completion else { return }
                    completion(success: false, value: nil)
                }
        }
    }

    public func get<T: Mappable>(type: String, id: Int, completion: (success: Bool, value: T?) -> Void) {
        let baseURL = NSURL(string: siteURL!)
        let requestURL = NSURL(string: "wc-api/v3/\(type)s/\(id)", relativeToURL: baseURL)
        let requestURLString = requestURL!.absoluteString

        guard let user = consumerKey, password = consumerSecret else {
            completion(success: false, value: nil)
            return
        }

        Alamofire.request(.GET, requestURLString)
            .authenticate(user: user, password: password)
            .responseJSON { response in
                if response.result.isSuccess {
                    let object = Mapper<T>().map(response.result.value![type])
                    completion(success: true, value: object)
                } else {
                    completion(success: false, value: nil)
                }
        }
    }

    public func getArray<T: Mappable>(type: RequestType, slug: String, parameters: [String: String]?, completion: (success: Bool, value: [T]?) -> Void) {
        guard let url = siteURL, user = consumerKey, password = consumerSecret else {
            completion(success: false, value: nil)
            return
        }

        let baseURL = NSURL(string: url)
        let requestURL = NSURL(string: "wc-api/v3/\(slug)", relativeToURL: baseURL)
        let requestURLString = requestURL!.absoluteString

        Alamofire.request(.GET, requestURLString, parameters: parameters)
            .authenticate(user: user, password: password)
            .responseJSON { response in
                if response.result.isSuccess {
                    let objects = Mapper<T>().mapArray(response.result.value![type.rawValue])!
                    completion(success: true, value: objects)
                } else {
                    completion(success: false, value: nil)
                }
        }
    }

    public func post<T: Mappable>(type: String, parameters: [String : AnyObject], completion: (success: Bool, value: T?) -> Void) {
        let baseURL = NSURL(string: siteURL!)
        let requestURL = NSURL(string: "wc-api/v3/\(type)s", relativeToURL: baseURL)
        let requestURLString = requestURL!.absoluteString

        guard let user = consumerKey, password = consumerSecret else {
            completion(success: false, value: nil)
            return
        }

        Alamofire.request(.POST, requestURLString, parameters: parameters, encoding: .JSON)
            .authenticate(user: user, password: password)
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
