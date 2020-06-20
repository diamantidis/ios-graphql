//
//  NewPostViewModel.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 6/20/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import Foundation
import Combine

class NewPostViewModel: ObservableObject {
    // MARK: - Enumerations
    enum Event {
        case onSave
    }

    // MARK: - Public properties
    // Input
    @Published var title: String = ""
    @Published var publishedAt: Date?
    @Published var selectedTagIndex: Int?

    // Output
    @Published var state: DataState<Post, GraphQLError> = .idle
    var tags = Tag.allCases.map { $0.rawValue }

    // MARK: - Initializers
    init(service: BlogService) {
        self.service = service
    }

    // MARK: - Public methods
    func send(event: Event) {
        switch event {
        case .onSave:
            self.state = .inProgress
            self.createNewPost()
        }
    }

    // MARK: - Private properties
    private var cancellableSet = Set<AnyCancellable>()
    private var service: BlogService

    // MARK: - Private methods
    private func createNewPost() {
        guard let tagIndex = self.selectedTagIndex, let publishedAt = self.publishedAt else {
            self.state = .error(.createError)
            return
        }
        self.service
            .createPost(
                title: self.title,
                tags: [Tag.allCases[tagIndex]],
                publishedAt: publishedAt
            )
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map {
                return DataState.completed($0)
            }
            .catch {error in
                return Just(DataState.error(error))
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.state, on: self)
            .store(in: &cancellableSet)
    }
}
