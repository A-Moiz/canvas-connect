//
//  PostButtonsViewModel.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import Foundation

class PostButtonsViewModel: ObservableObject {
    
    private let service = PostService()
    @Published var post: Post
    @Published var isBlurApplied: Bool = false
    
    init(post: Post) {
        self.post = post
        checkIfUserLikedPost()
        checkIfUserSavedPost()
    }
    
    func likePost() {
        service.likePosts(post) {
            self.post.isLiked = true
        }
    }
    
    func unlikePost() {
        service.unlikePost(post) {
            self.post.isLiked = false
        }
    }
    
    func checkIfUserLikedPost() {
        service.checkIfUserLikedPost(post) { isLiked in
            if isLiked {
                self.post.isLiked = true
            }
        }
    }
    
    func savePost() {
        service.savePosts(post) {
            self.post.isSaved = true
        }
    }
    
    func unsavePost() {
        service.unsavePost(post) {
            self.post.isSaved = false
        }
    }
    
    func checkIfUserSavedPost() {
        service.checkIfUserSavedPost(post) { isSaved in
            if isSaved {
                self.post.isSaved = true
            }
        }
    }
    
    func toggleBlur() {
        isBlurApplied.toggle()
    }
    
    func deletePost() async {
        try await service.deletePost(post) { error in
            if let error = error {
                print("Error deleting post: \(error)")
            } else {
                print("Post deleted successfully")
            }
        }
    }
}
