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

    public func get<T: Mappable>(type: String, id: Int? = nil, email: String? = nil, completion: ((success: Bool, value: T?) -> Void)?) {
        let baseURL = NSURL(string: siteURL!)
        var requestURL: NSURL?
        if let id = id {
            requestURL = NSURL(string: "wc-api/v3/\(type)s/\(id)", relativeToURL: baseURL)
        }
        if let email = email {
            requestURL = NSURL(string: "wc-api/v3/customers/email/\(email)", relativeToURL: baseURL)
        }
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
                    let object = Mapper<T>().map(response.result.value![type])
                    guard let completion = completion else { return }
                    completion(success: true, value: object)
                } else {
                    guard let completion = completion else { return }
                    completion(success: false, value: nil)
                }
        }
    }

    public func getArray<T: Mappable>(type: RequestType, slug: String, parameters: [String: AnyObject]?, completion: ((success: Bool, value: [T]?) -> Void)?) {
        guard let url = siteURL, user = consumerKey, password = consumerSecret else {
            guard let completion = completion else { return }
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
                    guard let completion = completion else { return }
                    completion(success: true, value: objects)
                } else {
                    guard let completion = completion else { return }
                    completion(success: false, value: nil)
                }
        }
    }

    public func post<T: Mappable>(type: String, parameters: [String : AnyObject], completion: ((success: Bool, value: T?) -> Void)?) {
        let baseURL = NSURL(string: siteURL!)
        let requestURL = NSURL(string: "wc-api/v3/\(type)s", relativeToURL: baseURL)
        let requestURLString = requestURL!.absoluteString

        guard let user = consumerKey, password = consumerSecret else {
            guard let completion = completion else { return }
            completion(success: false, value: nil)
            return
        }

        Alamofire.request(.POST, requestURLString, parameters: parameters, encoding: .JSON)
            .authenticate(user: user, password: password)
            .responseJSON { response in
                if response.result.isSuccess {
                    let object = Mapper<T>().map(response.result.value![type])
                    guard let completion = completion else { return }
                    completion(success: true, value: object)
                } else {
                    guard let completion = completion else { return }
                    completion(success: false, value: nil)
                }
        }
    }
    
    public func put<T: Mappable>(type: String, id: Int, parameters: [String : AnyObject], completion: ((success: Bool, value: T?) -> Void)?) {
        let baseURL = NSURL(string: siteURL!)
        let requestURL = NSURL(string: "wc-api/v3/\(type)s/\(id)", relativeToURL: baseURL)
        let requestURLString = requestURL!.absoluteString

        guard let user = consumerKey, password = consumerSecret else {
            guard let completion = completion else { return }
            completion(success: false, value: nil)
            return
        }

        Alamofire.request(.PUT, requestURLString, parameters: parameters, encoding: .JSON)
            .authenticate(user: user, password: password)
            .responseJSON { response in
                if response.result.isSuccess {
                    let object = Mapper<T>().map(response.result.value![type])
                    guard let completion = completion else { return }
                    completion(success: true, value: object)
                } else {
                    guard let completion = completion else { return }
                    completion(success: false, value: nil)
                }
        }
    }
    
    public func delete(type: String, id: Int, parameters: [String : AnyObject]?, completion: ((success: Bool) -> Void)?) {
        let baseURL = NSURL(string: siteURL!)
        let requestURL = NSURL(string: "wc-api/v3/\(type)s/\(id)", relativeToURL: baseURL)
        let requestURLString = requestURL!.absoluteString

        guard let user = consumerKey, password = consumerSecret else {
            guard let completion = completion else { return }
            completion(success: false)
            return
        }

        Alamofire.request(.DELETE, requestURLString, parameters: parameters)
            .authenticate(user: user, password: password)
            .responseJSON { response in
                if response.result.isSuccess && response.response?.statusCode == 200 {
                    guard let completion = completion else { return }
                    completion(success: true)
                } else {
                    guard let completion = completion else { return }
                    completion(success: false)
                }
        }
    }
    
}
