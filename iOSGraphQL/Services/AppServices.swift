//
//  AppServices.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 6/20/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import Foundation
import Apollo

class AppServices: Services {
    // MARK: - Public properties
    var blogService: BlogService {
        if isMock {
            return MockBlogService()
        } else {
            return GraphQLBlogService(client: graphQLClient)
        }
    }

    // MARK: - Initializers
    init(graphQLClient: ApolloClient) {
        self.graphQLClient = graphQLClient
    }

    // MARK: - Private properties
    private let graphQLClient: ApolloClient
    private let isMock = true
}

