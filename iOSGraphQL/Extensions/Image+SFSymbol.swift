//
//  Image+SFSymbol.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 6/20/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import SwiftUI

extension Image {
    enum SFSymbol: String, CaseIterable {
        case plus = "plus.circle.fill"
    }

    init(symbol: SFSymbol) {
        self.init(systemName: symbol.rawValue)
    }
}
