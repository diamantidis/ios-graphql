//
//  PostsListViewModel.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 6/20/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import Foundation
import Combine

class PostsListViewModel: ObservableObject {
    @Published var state: DataState<[Post], GraphQLError> = .idle

    init(service: BlogService) {
        self.service = service
    }

    deinit {
        cancellable?.cancel()
    }

    func loadPosts() {
        self.state = .inProgress
        cancellable = service.fetchPosts()
            .map {
                return DataState.completed($0)
            }
            .catch {error in
                return Just(DataState.error(error))
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.state, on: self)
    }

    private var cancellable: AnyCancellable?
    private let service: BlogService
}
