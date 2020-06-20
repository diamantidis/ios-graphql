//
//  PostListCoordinator.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 6/20/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import SwiftUI

class PostListCoordinator: Coordinator {
    init(service: BlogService) {
        self.service = service

    }

    @discardableResult
    func rootView() -> PostsList {
        let viewModel = PostsListViewModel(service: self.service)
        viewModel.loadPosts()

        return PostsList(viewModel: viewModel, navigationView: { isPresented in
            self.newPostCoordinator = NewPostCoordinator(service: self.service, isPresented: isPresented)

            return AnyView(self.newPostCoordinator?.rootView())
        })
    }

    private var newPostCoordinator: NewPostCoordinator?
    private let service: BlogService
}
