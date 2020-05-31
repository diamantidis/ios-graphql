//
//  Author.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 5/30/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import Foundation

struct Author {
    var id: CustomUUID
    var name: String
    var twitter: String

    init(author: AuthorDetails) {
        self.id = author.id
        self.name = author.name
        self.twitter = author.twitter
    }
}
