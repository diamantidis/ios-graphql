//
//  GraphQLBlogService.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 6/20/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import Combine
import Apollo

class GraphQLBlogService: BlogService {

    init(client: ApolloClient) {
        self.client = client
    }

    func fetchPosts() -> AnyPublisher<[Post], GraphQLError> {
        let query = AllPostsQuery()

        let future = Future<[Post], GraphQLError> {[weak self] promise in
            guard let self = self else {
                return promise(.failure(.fetchError))
            }

            self.client.fetch(query: query) { result in
                guard let data = try? result.get().data else {
                    return promise(.failure(.fetchError))
                }
                let posts = data.posts.map { Post(post: $0) }
                return promise(.success(posts))
            }
        }

        return future.eraseToAnyPublisher()
    }

    func createPost(title: String, tags: [Tag], authorId: CustomUUID) -> AnyPublisher<Post, GraphQLError> {

        let input = PostInput(authorId: authorId, tags: tags, title: title)
        let mutation = CreatePostMutation(input: input)

        let future = Future<Post, GraphQLError> {[weak self] promise in
            guard let self = self else {
                return promise(.failure(.createError))
            }
            self.client.perform(mutation: mutation) { result in
                guard let data = try? result.get().data else {
                    return promise(.failure(.createError))
                }
                let post = Post(post: data.createPost)
                return promise(.success(post))
            }
        }
        return future.eraseToAnyPublisher()
    }

    func editPost(with id: CustomUUID, title: String, tags: [Tag]) -> AnyPublisher<Post, GraphQLError> {
        let mutation = EditPostMutation(id: id, title: title, tags: tags)

        let future = Future<Post, GraphQLError> {[weak self] promise in
            guard let self = self else {
                return promise(.failure(.editError))
            }
            self.client.perform(mutation: mutation) { result in
                guard let editPost = try? result.get().data?.editPost else {
                    return promise(.failure(.editError))
                }
                let post = Post(post: editPost)
                return promise(.success(post))
            }
        }

        return future.eraseToAnyPublisher()
    }

    func deletePost(with id: CustomUUID) -> AnyPublisher<Bool, GraphQLError> {
        let mutation = DeletePostMutation(id: id)

        let future = Future<Bool, GraphQLError> { [weak self] promise in
            guard let self = self else {
                return promise(.failure(.deleteError))
            }

            self.client.perform(mutation: mutation) { result in
                guard let result = try? result.get().data?.deletePost else {
                    return promise(.failure(.deleteError))
                }
                return promise(.success(result))
            }
        }

        return future.eraseToAnyPublisher()
    }

    private let client: ApolloClient
}
