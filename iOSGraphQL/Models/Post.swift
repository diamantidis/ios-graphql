//
//  Post.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 5/23/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import Foundation

struct Post {
    let id: CustomUUID
    let title: String
    let publishedAt: Date
    let tags: [Tag]

    init(post: AllPostsQuery.Data.Post) {
        self.id = post.id
        self.title = post.title
        self.publishedAt = post.publishedAt
        self.tags = post.tags
    }
}
