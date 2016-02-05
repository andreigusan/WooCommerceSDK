import Foundation
import ObjectMapper

public class FloatTransform: TransformType {
    public typealias Object = Float
    public typealias JSON = String

    public init() {}

    public func transformFromJSON(value: AnyObject?) -> Float? {
        guard let value = value as? NSString else { return nil }
        return value.floatValue
    }

    public func transformToJSON(value: Float?) -> String? {
        guard let value = value else { return nil }
        return value.description
    }
}
