import Foundation
import ObjectMapper

public class DoubleTransform: TransformType {
    public typealias Object = Double
    public typealias JSON = String

    public init() {}

    public func transformFromJSON(value: AnyObject?) -> Double? {
        if let value = value as? String {
            return Double(value)
        }
        if let value = value as? Double {
            return value
        }
        return nil
    }

    public func transformToJSON(value: Double?) -> String? {
        guard let value = value else { return nil }
        return value.description
    }
}
