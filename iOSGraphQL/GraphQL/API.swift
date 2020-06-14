// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// Tags
public enum Tag: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// About GraphQL
  case graphQl
  /// About Swift
  case swift
  /// About Vapor
  case vapor
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "GraphQL": self = .graphQl
      case "Swift": self = .swift
      case "Vapor": self = .vapor
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .graphQl: return "GraphQL"
      case .swift: return "Swift"
      case .vapor: return "Vapor"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: Tag, rhs: Tag) -> Bool {
    switch (lhs, rhs) {
      case (.graphQl, .graphQl): return true
      case (.swift, .swift): return true
      case (.vapor, .vapor): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [Tag] {
    return [
      .graphQl,
      .swift,
      .vapor,
    ]
  }
}

public struct PostInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - authorId
  ///   - tags
  ///   - title
  public init(authorId: CustomUUID, tags: [Tag], title: String) {
    graphQLMap = ["authorId": authorId, "tags": tags, "title": title]
  }

  public var authorId: CustomUUID {
    get {
      return graphQLMap["authorId"] as! CustomUUID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "authorId")
    }
  }

  public var tags: [Tag] {
    get {
      return graphQLMap["tags"] as! [Tag]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "tags")
    }
  }

  public var title: String {
    get {
      return graphQLMap["title"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "title")
    }
  }
}

public final class AllPostsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query AllPosts {
      posts {
        __typename
        id
        title
        publishedAt
        tags
        author {
          __typename
          ...AuthorDetails
        }
      }
    }
    """

  public let operationName: String = "AllPosts"

  public var queryDocument: String { return operationDefinition.appending(AuthorDetails.fragmentDefinition) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("posts", type: .nonNull(.list(.nonNull(.object(Post.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(posts: [Post]) {
      self.init(unsafeResultMap: ["__typename": "Query", "posts": posts.map { (value: Post) -> ResultMap in value.resultMap }])
    }

    public var posts: [Post] {
      get {
        return (resultMap["posts"] as! [ResultMap]).map { (value: ResultMap) -> Post in Post(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Post) -> ResultMap in value.resultMap }, forKey: "posts")
      }
    }

    public struct Post: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Post"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(CustomUUID.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("publishedAt", type: .nonNull(.scalar(Date.self))),
        GraphQLField("tags", type: .nonNull(.list(.nonNull(.scalar(Tag.self))))),
        GraphQLField("author", type: .nonNull(.object(Author.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: CustomUUID, title: String, publishedAt: Date, tags: [Tag], author: Author) {
        self.init(unsafeResultMap: ["__typename": "Post", "id": id, "title": title, "publishedAt": publishedAt, "tags": tags, "author": author.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: CustomUUID {
        get {
          return resultMap["id"]! as! CustomUUID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var publishedAt: Date {
        get {
          return resultMap["publishedAt"]! as! Date
        }
        set {
          resultMap.updateValue(newValue, forKey: "publishedAt")
        }
      }

      public var tags: [Tag] {
        get {
          return resultMap["tags"]! as! [Tag]
        }
        set {
          resultMap.updateValue(newValue, forKey: "tags")
        }
      }

      public var author: Author {
        get {
          return Author(unsafeResultMap: resultMap["author"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "author")
        }
      }

      public struct Author: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Author"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(AuthorDetails.self),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: CustomUUID, name: String, twitter: String) {
          self.init(unsafeResultMap: ["__typename": "Author", "id": id, "name": name, "twitter": twitter])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var authorDetails: AuthorDetails {
            get {
              return AuthorDetails(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public final class CreatePostMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation CreatePost($input: PostInput!) {
      createPost(input: $input) {
        __typename
        id
        title
        publishedAt
        tags
        author {
          __typename
          ...AuthorDetails
        }
      }
    }
    """

  public let operationName: String = "CreatePost"

  public var queryDocument: String { return operationDefinition.appending(AuthorDetails.fragmentDefinition) }

  public var input: PostInput

  public init(input: PostInput) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createPost", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(CreatePost.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createPost: CreatePost) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createPost": createPost.resultMap])
    }

    public var createPost: CreatePost {
      get {
        return CreatePost(unsafeResultMap: resultMap["createPost"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "createPost")
      }
    }

    public struct CreatePost: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Post"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(CustomUUID.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("publishedAt", type: .nonNull(.scalar(Date.self))),
        GraphQLField("tags", type: .nonNull(.list(.nonNull(.scalar(Tag.self))))),
        GraphQLField("author", type: .nonNull(.object(Author.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: CustomUUID, title: String, publishedAt: Date, tags: [Tag], author: Author) {
        self.init(unsafeResultMap: ["__typename": "Post", "id": id, "title": title, "publishedAt": publishedAt, "tags": tags, "author": author.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: CustomUUID {
        get {
          return resultMap["id"]! as! CustomUUID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var publishedAt: Date {
        get {
          return resultMap["publishedAt"]! as! Date
        }
        set {
          resultMap.updateValue(newValue, forKey: "publishedAt")
        }
      }

      public var tags: [Tag] {
        get {
          return resultMap["tags"]! as! [Tag]
        }
        set {
          resultMap.updateValue(newValue, forKey: "tags")
        }
      }

      public var author: Author {
        get {
          return Author(unsafeResultMap: resultMap["author"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "author")
        }
      }

      public struct Author: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Author"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(AuthorDetails.self),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: CustomUUID, name: String, twitter: String) {
          self.init(unsafeResultMap: ["__typename": "Author", "id": id, "name": name, "twitter": twitter])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var authorDetails: AuthorDetails {
            get {
              return AuthorDetails(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public final class DeletePostMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation DeletePost($id: CustomUUID!) {
      deletePost(id: $id)
    }
    """

  public let operationName: String = "DeletePost"

  public var id: CustomUUID

  public init(id: CustomUUID) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("deletePost", arguments: ["id": GraphQLVariable("id")], type: .nonNull(.scalar(Bool.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(deletePost: Bool) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "deletePost": deletePost])
    }

    public var deletePost: Bool {
      get {
        return resultMap["deletePost"]! as! Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "deletePost")
      }
    }
  }
}

public final class EditPostMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation EditPost($id: CustomUUID!, $title: String!, $tags: [Tag!]!) {
      editPost(id: $id, tags: $tags, title: $title) {
        __typename
        id
        title
        publishedAt
        tags
      }
    }
    """

  public let operationName: String = "EditPost"

  public var id: CustomUUID
  public var title: String
  public var tags: [Tag]

  public init(id: CustomUUID, title: String, tags: [Tag]) {
    self.id = id
    self.title = title
    self.tags = tags
  }

  public var variables: GraphQLMap? {
    return ["id": id, "title": title, "tags": tags]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("editPost", arguments: ["id": GraphQLVariable("id"), "tags": GraphQLVariable("tags"), "title": GraphQLVariable("title")], type: .object(EditPost.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(editPost: EditPost? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "editPost": editPost.flatMap { (value: EditPost) -> ResultMap in value.resultMap }])
    }

    public var editPost: EditPost? {
      get {
        return (resultMap["editPost"] as? ResultMap).flatMap { EditPost(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "editPost")
      }
    }

    public struct EditPost: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Post"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(CustomUUID.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("publishedAt", type: .nonNull(.scalar(Date.self))),
        GraphQLField("tags", type: .nonNull(.list(.nonNull(.scalar(Tag.self))))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: CustomUUID, title: String, publishedAt: Date, tags: [Tag]) {
        self.init(unsafeResultMap: ["__typename": "Post", "id": id, "title": title, "publishedAt": publishedAt, "tags": tags])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: CustomUUID {
        get {
          return resultMap["id"]! as! CustomUUID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var publishedAt: Date {
        get {
          return resultMap["publishedAt"]! as! Date
        }
        set {
          resultMap.updateValue(newValue, forKey: "publishedAt")
        }
      }

      public var tags: [Tag] {
        get {
          return resultMap["tags"]! as! [Tag]
        }
        set {
          resultMap.updateValue(newValue, forKey: "tags")
        }
      }
    }
  }
}

public struct AuthorDetails: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment AuthorDetails on Author {
      __typename
      id
      name
      twitter
    }
    """

  public static let possibleTypes: [String] = ["Author"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(CustomUUID.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("twitter", type: .nonNull(.scalar(String.self))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: CustomUUID, name: String, twitter: String) {
    self.init(unsafeResultMap: ["__typename": "Author", "id": id, "name": name, "twitter": twitter])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: CustomUUID {
    get {
      return resultMap["id"]! as! CustomUUID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  public var twitter: String {
    get {
      return resultMap["twitter"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "twitter")
    }
  }
}
