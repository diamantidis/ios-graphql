//
//  SceneDelegate.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 5/23/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private func deletePost(with id: CustomUUID) {
        let mutation = DeletePostMutation(id: id)

        GraphQLClient.apollo.perform(mutation: mutation) {result in
            switch result {
            case .failure(let error):
                print("=============")
                print(error)
                print("=============")
            case .success(let result):
                print("=============")
                print("Is deleted? \(result.data?.deletePost)")
                print("=============")
            }
        }
    }

    private func editPost(with id: CustomUUID, title: String, tags: [Tag]) {
        let mutation = EditPostMutation(id: id, title: title, tags: tags)

        GraphQLClient.apollo.perform(mutation: mutation) {result in
            switch result {
            case .failure(let error):
                print("=============")
                print(error)
                print("=============")
            case .success(let result):
                print("=============")
                print("Updated title: \(result.data?.editPost?.title)")
                print("=============")
            }
        }
    }

    private func createPost(title: String, tags: [Tag], authorId: CustomUUID) {
        let input = PostInput(authorId: authorId, tags: tags, title: title)
        let mutation = CreatePostMutation(input: input)

        GraphQLClient.apollo.perform(mutation: mutation) {result in
            switch result {
            case .failure(let error):
                print("=============")
                print(error)
                print("=============")
            case .success(let result):
                print("=============")
                print(result.data?.createPost)
                print("=============")
            }
        }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        let query = AllPostsQuery()
        GraphQLClient.apollo.fetch(query: query) { result in
            guard let data = try? result.get().data else { return }
            let posts = data.posts.map { Post(post: $0) }
            print(posts)

            if let post = posts.first {
//                self.deletePost(with: post.id)
//                self.editPost(with: post.id, title: "New title", tags: [.swift])
                self.createPost(title: "Test title", tags: [.swift, .graphQl], authorId: post.author.id)
            }
        }

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

