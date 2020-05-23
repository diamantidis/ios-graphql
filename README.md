# iOS GraphQL app
[![Swift](https://img.shields.io/badge/Swift-5-f05038.svg)](https://swift.org)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Twitter: @diamantidis_io](https://img.shields.io/badge/Twitter-@diamantidis_io-blue.svg?logo=twitter&color=1da1f2&style=flat)](https://twitter.com/diamantidis_io)

A demo iOS app that uses [Apollo iOS] to communicate with a [GraphQL server built with Vapor].

## Requirements
* Xcode 11
* Swift 5
* Ruby
* Bundler

## Installation

To clone the repo:

```sh
git clone https://github.com/diamantidis/ios-graphql.git && cd ios-graphql
```

### Dependencies 

To install the dependencies
```sh
bundle install
bundle exec pod install
```

### Server

This app communicates with an example server, available on my [vapor-graphql] repo. To setup and run the server, follow the instructions on this repo. By default, the server will run on port `8080` and if you want to change it, you can change it on  [GraphQLClient.swift].

## Running the app

To run the app from Xcode:
```
xed .
```
And then hit, Command(⌘) + R.

## Author
I'm [Ioannis Diamantidis] and you can find me on:
* [Twitter]
* [Email]
* [LinkedIn]

## License

This project is licensed under the terms of the MIT license. See the [LICENSE] file.

[Apollo iOS]: https://github.com/apollographql/apollo-ios
[vapor-graphql]: https://github.com/diamantidis/vapor-graphql
[GraphQL server built with Vapor]: https://github.com/diamantidis/vapor-graphql

[GraphQLClient.swift]: iOSGraphQL/GraphQL/GraphQLClient.swift

[Ioannis Diamantidis]: https://diamantidis.github.io
[Twitter]: https://twitter.com/diamantidis_io
[LinkedIn]: http://linkedin.com/in/ioannis-diamantidis
[Email]: mailto:diamantidis@outlook.com
[LICENSE]: LICENSE
