//
//  NewPostForm.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 6/20/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import SwiftUI
import Combine


struct NewPostForm: View {

    @ObservedObject var viewModel: NewPostViewModel
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack {
                        VStack(alignment: .leading) {
                            Spacer()
                            Text("Title")
                                .font(.callout)
                                .bold()
                            TextField("Enter a title...", text: self.$viewModel.title)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .padding()
                    }

                    VStack(alignment: .leading) {
                        Spacer()
                        Text("Published at:")
                            .font(.callout)
                            .bold()

                        DateField("Select a date", date: self.$viewModel.publishedAt)
                    }
                    .padding()

                    VStack(alignment: .leading) {
                        Spacer()
                        Text("Tag")
                            .font(.callout)
                            .bold()

                        PickerField("Select a tag",
                                    data: self.viewModel.tags,
                                    selectionIndex: self.$viewModel.selectedTagIndex)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding()
                }
            }
            .navigationBarTitle(Text("New Post"), displayMode: .inline)
            .navigationBarItems(leading: CancelButton(), trailing: SaveBarItem())
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
            .onDisappear {
                UIScrollView.appearance().bounces = true
            }
        }
    }

    private func CancelButton() -> some View {
        return Button(action: {
            self.isPresented.toggle()
        }) {
            Text("Cancel")
        }
    }

    private func SaveBarItem() -> AnyView {
        switch self.$viewModel.state.wrappedValue {
        case .idle, .error:
            return AnyView(SaveButton(with: "Save")
                .disabled(false))
        case .inProgress:
            return AnyView(SaveButton(with: "Saving...")
                .disabled(true))
        case .completed:
            self.$isPresented.wrappedValue = false
            return AnyView(EmptyView())
        }
    }

    private func SaveButton<S: StringProtocol>(with text: S) -> AnyView {
        return AnyView(Button(action: {
            self.viewModel.send(event: .onSave)
        }) {
            Text(text).bold()
        })
    }
}

struct NewPostForm_Previews: PreviewProvider {
    @State private static var isPresented: Bool = true
    @State private static var viewModel = NewPostViewModel(service: MockBlogService())

    static var previews: some View {
        NewPostForm(viewModel: viewModel, isPresented: $isPresented)
    }
}
