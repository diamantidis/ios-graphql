// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// Tags
public enum Tag: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// About Vapor
  case vapor
  /// About Swift
  case swift
  /// About GraphQL
  case graphQl
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "Vapor": self = .vapor
      case "Swift": self = .swift
      case "GraphQL": self = .graphQl
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .vapor: return "Vapor"
      case .swift: return "Swift"
      case .graphQl: return "GraphQL"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: Tag, rhs: Tag) -> Bool {
    switch (lhs, rhs) {
      case (.vapor, .vapor): return true
      case (.swift, .swift): return true
      case (.graphQl, .graphQl): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [Tag] {
    return [
      .vapor,
      .swift,
      .graphQl,
    ]
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
