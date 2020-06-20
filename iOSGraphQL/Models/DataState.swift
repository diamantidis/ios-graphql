//
//  DataState.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 6/20/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import Foundation

enum DataState<Data, Error> {
    case idle
    case inProgress
    case completed(Data)
    case error(Error)
}
