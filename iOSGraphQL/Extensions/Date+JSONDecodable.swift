import Foundation
import Apollo

extension Date: JSONDecodable {
    public init(jsonValue value: JSONValue) throws {

        guard let timeInterval = try? TimeInterval(jsonValue: value) else {
            throw JSONDecodingError.couldNotConvert(value: value, to: Date.self)
        }
        self = Date(timeIntervalSinceReferenceDate: timeInterval)
    }
}
