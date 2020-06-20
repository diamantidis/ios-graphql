//
//  NewPostCoordinator.swift
//  iOSGraphQL
//
//  Created by Ioannis Diamantidis on 6/20/20.
//  Copyright © 2020 Ioannis Diamantidis. All rights reserved.
//

import SwiftUI

class NewPostCoordinator: Coordinator {
    init(service: BlogService, isPresented: Binding<Bool>) {
        self.service = service
        self.isPresented = isPresented
    }

    func rootView() -> some View {
        let viewModel = NewPostViewModel(service: self.service)
        return NewPostForm(viewModel: viewModel, isPresented: isPresented)
    }

    private let service: BlogService
    private let isPresented: Binding<Bool>
}
