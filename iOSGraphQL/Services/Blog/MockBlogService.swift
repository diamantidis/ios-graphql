//
//  MockBlogService.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 6/20/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//
import Foundation
import Combine

class MockBlogService: BlogService {
    func fetchPosts() -> AnyPublisher<[Post], GraphQLError> {
        let future = Future<[Post], GraphQLError> {promise in
            DispatchQueue.global(qos: .background).async { [weak self] in
                sleep(1)
                guard let self = self else {
                    return promise(.failure(.fetchError))
                }
                promise(.success(self.posts))
            }
        }
        return future.eraseToAnyPublisher()
    }

    func createPost(title: String, tags: [Tag], publishedAt: Date) -> AnyPublisher<Post, GraphQLError> {

        let future = Future<Post, GraphQLError> {promise in
            DispatchQueue.global(qos: .background).async { [weak self] in
                sleep(1)
                guard let self = self else {
                    return promise(.failure(.createError))
                }

                let post = Post(
                    title: title,
                    publishedAt: publishedAt,
                    tags: tags,
                    author: self.author
                )
                self.posts.append(post)
                promise(.success(post))
            }
        }
        return future.eraseToAnyPublisher()
    }
    func editPost(with id: CustomUUID, title: String, tags: [Tag]) -> AnyPublisher<Post, GraphQLError> {
        let future = Future<Post, GraphQLError> {promise in
            DispatchQueue.global(qos: .background).async { [weak self] in
                sleep(1)
                guard let self = self else {
                    return promise(.failure(.editError))
                }

                let postIndex = self.posts.firstIndex { $0.id == id }
                guard let index = postIndex else {
                    promise(.failure(.editError))
                    return
                }

                self.posts[index].title = title
                self.posts[index].tags = tags
                promise(.success(self.posts[index]))
            }
        }
        return future.eraseToAnyPublisher()
    }

    func deletePost(with id: CustomUUID) -> AnyPublisher<Bool, GraphQLError> {
        let future = Future<Bool, GraphQLError> {promise in
            DispatchQueue.global(qos: .background).async { [weak self] in
                sleep(1)
                guard let self = self else {
                    return promise(.failure(.deleteError))
                }

                let postIndex = self.posts.firstIndex { $0.id == id }
                guard let index = postIndex else {
                    return promise(.failure(.deleteError))
                }

                self.posts.remove(at: index)
                promise(.success(true))
            }
        }
        return future.eraseToAnyPublisher()
    }

    private var posts: [Post] = [
        Post(
            title: "First Post",
            publishedAt: Date(),
            tags: [.swift],
            author: Author(name: "test", twitter: "twitter")
        )
    ]

    private var author: Author = Author(
        name: "Ioannis Diamantidis",
        twitter: "@diamantidis_io"
    )
}
