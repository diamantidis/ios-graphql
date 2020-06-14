//
//  CustomUUID.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 5/30/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import Foundation
import Apollo

public struct CustomUUID: JSONDecodable {
    let value: UUID

    public init(jsonValue value: JSONValue) throws {
        guard let stringValue = (value as AnyObject)["value"] as? String, let uuid = UUID(uuidString: stringValue) else {
            throw JSONDecodingError.couldNotConvert(value: value, to: CustomUUID.self)
        }

        self.value = uuid
    }
}

extension CustomUUID: JSONEncodable {
    public var jsonValue: JSONValue {
        return ["value": value.uuidString]
    }
}
