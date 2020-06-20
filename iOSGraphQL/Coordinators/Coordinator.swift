//
//  Coordinator.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 6/20/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import SwiftUI

protocol Coordinator {
    associatedtype U: View
    func rootView() -> U
}
