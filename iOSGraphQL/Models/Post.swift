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
    var title: String
    let publishedAt: Date
    var tags: [Tag]
    var author: Author

    init(post: AllPostsQuery.Data.Post) {
        self.id = post.id
        self.title = post.title
        self.publishedAt = post.publishedAt
        self.tags = post.tags
        self.author = Author(author: post.author.fragments.authorDetails)
    }

    init(post: CreatePostMutation.Data.CreatePost) {
        self.id = post.id
        self.title = post.title
        self.publishedAt = post.publishedAt
        self.tags = post.tags
        self.author = Author(author: post.author.fragments.authorDetails)
    }

    init(post: EditPostMutation.Data.EditPost) {
        self.id = post.id
        self.title = post.title
        self.publishedAt = post.publishedAt
        self.tags = post.tags
        self.author = Author(author: post.author.fragments.authorDetails)
    }

    init(title: String, publishedAt: Date, tags: [Tag], author: Author) {
        self.id = CustomUUID()
        self.title = title
        self.publishedAt = publishedAt
        self.tags = tags
        self.author = author
    }
}
