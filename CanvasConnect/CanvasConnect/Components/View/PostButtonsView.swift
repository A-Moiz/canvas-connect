//
//  PostButtonsView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import SwiftUI
import Firebase

struct PostButtonsView: View {
    let post: Post
    @ObservedObject var viewModel: PostButtonsViewModel
    @State private var showComments = false
    
    init(post: Post, viewModel: PostButtonsViewModel) {
        self.post = post
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        HStack(spacing: 24) {
            
            // Like Button
            Button(action: {
                viewModel.post.isLiked ?? false ? viewModel.unlikePost() : viewModel.likePost()
            }) {
                Image(systemName: viewModel.post.isLiked ?? false ? "heart.fill" : "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(viewModel.post.isLiked ?? false ? .red : .green)
                //  .foregroundColor(viewModel.post.isLiked ?? false ? .red : .blue)
            }
            
            // Bookmark Button
            Button(action: {
                viewModel.post.isSaved ?? false ? viewModel.unsavePost() : viewModel.savePost()
            }) {
                Image(systemName: viewModel.post.isSaved ?? false ? "bookmark.fill" : "bookmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(viewModel.post.isSaved ?? false ? .blue : .green)
                //  .foregroundColor(viewModel.post.isSaved ?? false ? .blue : .blue)
            }
            
            // Comment Button
            if post.canComment ?? false {
                Button(action: {
                    showComments.toggle()
                }, label: {
                    Image(systemName: "message")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.green)
                    //  .foregroundColor(.blue)
                })
            }
            
            // Toggle Blur Button
            if post.isSpoiler ?? false {
                Button(action: {
                    viewModel.toggleBlur()
                }) {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.green)
                    //  .foregroundColor(.blue)
                }
            }
        }
        .sheet(isPresented: $showComments) {
            CommentsView(post: post)
        }
    }
}

//#Preview {
//    PostButtonsView()
//}
