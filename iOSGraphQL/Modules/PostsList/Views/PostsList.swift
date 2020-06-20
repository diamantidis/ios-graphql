//
//  PostsList.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 6/20/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import SwiftUI

struct PostsList: View {
    @ObservedObject var viewModel: PostsListViewModel
    var navigationView: (Binding<Bool>) -> AnyView

    // MARK: - Private properties
    @State private var isPresented = false

    var body: some View {
        NavigationView {
            ContentView(for: self.$viewModel.state.wrappedValue)
                .navigationBarTitle("Posts")
                .navigationBarItems(trailing: AddNewButton())
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
                }
        }
        .sheet(
            isPresented: self.$isPresented,
            onDismiss: { self.viewModel.loadPosts() },
            content: { self.navigationView(self.$isPresented) }
        )
    }

    private func ContentView(for state: DataState<[Post], GraphQLError>) -> AnyView {
        switch state {
        case .idle, .inProgress:
            return AnyView(Text("Loading"))
        case .completed(let posts):
            return AnyView(Text("Completed: \(posts.count)"))
        case .error(let error):
            return AnyView(Text("Error: \(error.localizedDescription)"))
        }
    }

    private func AddNewButton() -> AnyView {
        return AnyView(Button(action: {
            self.$isPresented.wrappedValue = true
        }) {
            Image(symbol: .plus)
                .font(.title)
        })
    }
}

struct PostsList_Previews: PreviewProvider {
    @State private static var viewModel = PostsListViewModel(service: MockBlogService())

    static var previews: some View {
        PostsList(viewModel: viewModel, navigationView: { _ in
            return AnyView(Text("Custom Sheet"))
        })
    }
}
