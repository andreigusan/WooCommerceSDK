import Foundation
import ObjectMapper

public class DoubleTransform: TransformType {
    public typealias Object = Double
    public typealias JSON = String

    public init() {}

    public func transformFromJSON(value: AnyObject?) -> Double? {
        if let string = value as? String {
            return Double(string)
        }
        if let double = value as? Double {
            return double
        }
        return nil
    }

    public func transformToJSON(value: Double?) -> String? {
        guard let value = value else { return nil }
        return value.description
    }
}
