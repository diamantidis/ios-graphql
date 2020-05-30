// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

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
      }
    }
    """

  public let operationName: String = "AllPosts"

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
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: CustomUUID, title: String, publishedAt: Date) {
        self.init(unsafeResultMap: ["__typename": "Post", "id": id, "title": title, "publishedAt": publishedAt])
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
    }
  }
}
