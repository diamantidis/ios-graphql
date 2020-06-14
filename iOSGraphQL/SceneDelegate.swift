//
//  SceneDelegate.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 5/23/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

enum GraphQLError: Error {
    case fetchError
    case createError
    case editError
    case deleteError
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var cancellable: AnyCancellable?

    deinit {
        cancellable?.cancel()
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        cancellable = self.fetchPosts()
            .flatMap { posts in
                return self.createPost(title: "New post", tags: [.swift], authorId: posts.first!.author.id)
            }
            .flatMap { post -> Future<EditPostMutation.Data.EditPost, GraphQLError> in
                let updatedTags = post.tags + [.vapor, .graphQl]
                return self.editPost(with: post.id, title: "Updated Title", tags: updatedTags)
            }
            .flatMap { post in
                return self.deletePost(with: post.id)
            }
            .sink(
                receiveCompletion: { print($0) },
                receiveValue: { print($0) }
            )

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}


extension SceneDelegate {
    private func fetchPosts() -> Future<[Post], GraphQLError> {
        let query = AllPostsQuery()

        let future = Future<[Post], GraphQLError> { promise in
            GraphQLClient.apollo.fetch(query: query) { result in
                guard let data = try? result.get().data else {
                    return promise(.failure(GraphQLError.fetchError))
                }
                let posts = data.posts.map { Post(post: $0) }
                return promise(.success(posts))
            }
        }

        return future
    }

    private func createPost(title: String, tags: [Tag], authorId: CustomUUID) -> Future<CreatePostMutation.Data.CreatePost, GraphQLError> {
        let input = PostInput(authorId: authorId, tags: tags, title: title)
        let mutation = CreatePostMutation(input: input)

        let future = Future<CreatePostMutation.Data.CreatePost, GraphQLError> { promise in
            GraphQLClient.apollo.perform(mutation: mutation) { result in
                guard let post = try? result.get().data?.createPost else {
                    return promise(.failure(.createError))
                }
                return promise(.success(post))
            }
        }
        return future
    }

    private func editPost(with id: CustomUUID, title: String, tags: [Tag]) -> Future<EditPostMutation.Data.EditPost, GraphQLError> {
        let mutation = EditPostMutation(id: id, title: title, tags: tags)

        let future = Future<EditPostMutation.Data.EditPost, GraphQLError> { promise in
            GraphQLClient.apollo.perform(mutation: mutation) { result in
                guard let post = try? result.get().data?.editPost else {
                    return promise(.failure(.editError))
                }
                return promise(.success(post))
            }
        }

        return future
    }

    private func deletePost(with id: CustomUUID) -> Future<Bool, GraphQLError> {
        let mutation = DeletePostMutation(id: id)

        let future = Future<Bool, GraphQLError> { promise in
            GraphQLClient.apollo.perform(mutation: mutation) { result in
                guard let result = try? result.get().data?.deletePost else {
                    return promise(.failure(.deleteError))
                }
                return promise(.success(result))
            }
        }

        return future
    }
}
