//
//  Post.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 5/23/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import Foundation

struct Post: Codable {
    var id: Int
    var title: String

    init(post: AllPostsQuery.Data.Post) {
        self.id = post.id
        self.title = post.title
    }
}
