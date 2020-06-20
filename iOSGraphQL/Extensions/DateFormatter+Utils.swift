//
//  DateFormatter+Utils.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 6/20/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var yearMonthDay: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}
