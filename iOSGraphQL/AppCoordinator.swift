//
//  AppCoordinator.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 6/20/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import SwiftUI

final class AppCoordinator: Coordinator {
    private let services: Services

    init(services: Services) {
        self.services = services
    }

    @discardableResult
    func rootView() -> some View {
        return postsListView()
    }

    private lazy var postsListCoordinator: PostListCoordinator = {
        return PostListCoordinator(service: self.services.blogService)
    }()

    private func postsListView() -> some View {
        return postsListCoordinator.rootView()
    }
}
