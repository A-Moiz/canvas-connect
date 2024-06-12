//
//  SavedPostsView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import SwiftUI
import Kingfisher

struct SavedPostsView: View {
    let user: User
    @StateObject private var viewModel: SavedPostViewModel
    @StateObject var background = BackgroundSelectionViewModel()

    private let gridItems: [GridItem] = Array(repeating: .init(.flexible(), spacing: 1), count: 3)
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1

    init(user: User) {
        self.user = user
        _viewModel = StateObject(wrappedValue: SavedPostViewModel(user: user))
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
            }
            .background(Image(background.backgroundImages[background.appBG])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all))
            .navigationTitle("Saved Posts")
        }
        .onAppear {
            Task {
                viewModel.fetchSavedPosts()
            }
        }
    }
}

//#Preview {
//    SavedPostsView()
//}
