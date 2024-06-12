//
//  PostGridView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    let user: User
    @StateObject private var viewModel: PostGridViewModel
    @StateObject var background = BackgroundSelectionViewModel()
    @State private var searchText = ""

    private let gridItems: [GridItem] = Array(repeating: .init(.flexible(), spacing: 1), count: 3)
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1

    init(user: User) {
        self.user = user
        _viewModel = StateObject(wrappedValue: PostGridViewModel(user: user))
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 1) {
                    ForEach(viewModel.filteredPosts) { post in
                        NavigationLink(destination: DisplayImageView(post: post, user: user, viewModel: PostButtonsViewModel(post: post))) {
                            KFImage(URL(string: post.imageUrl))
                                .resizable()
                                .scaledToFill()
                                .frame(width: imageDimension, height: imageDimension)
                                .clipped()
                        }
                    }
                }
                .background(Image(background.backgroundImages[background.appBG])
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all))
            }
            .navigationTitle("Posts") 
            .searchable(text: $searchText, prompt: "Search posts")
        }
        .onChange(of: searchText) { newValue in
            Task {
                do {
                    if newValue.isEmpty {
                        try await viewModel.fetchUserPosts()
                    } else {
                        try await viewModel.filterUserPostsByCaption(keyword: newValue)
                    }
                } catch {
                    print("Error filtering posts: \(error)")
                }
            }
        }
        .onAppear {
            Task {
                try await viewModel.fetchUserPosts()
            }
        }
    }
}

//#Preview {
//    PostGridView()
//}
