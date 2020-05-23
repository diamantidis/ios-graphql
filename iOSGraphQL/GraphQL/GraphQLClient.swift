//
//  GraphQLClient.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 5/23/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import Apollo

enum GraphQLClient {
    static var apollo = ApolloClient(url: URL(string: "http://127.0.0.1:8080/graphql")!)
}
