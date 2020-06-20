//
//  BlogService.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 6/20/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import Combine

protocol BlogService {
    func fetchPosts() -> AnyPublisher<[Post], GraphQLError>
    func createPost(title: String, tags: [Tag], authorId: CustomUUID) -> AnyPublisher<Post, GraphQLError>
    func editPost(with id: CustomUUID, title: String, tags: [Tag]) -> AnyPublisher<Post, GraphQLError>
    func deletePost(with id: CustomUUID) -> AnyPublisher<Bool, GraphQLError>
}
