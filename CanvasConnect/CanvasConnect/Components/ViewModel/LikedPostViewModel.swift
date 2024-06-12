//
//  LikedPostViewModel.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import Foundation

class LikedPostViewModel: ObservableObject {
    private let user: User
    @Published var posts = [Post]()
    @Published var likedPosts = [Post]()
    var filteredPosts = [Post]()
    
    init(user: User) {
        self.user = user
        Task { try await fetchLikedPosts() }
    }
    
    @MainActor
    func fetchLikedPosts() {
        PostService().fetchLikedPosts(uid: user.id) { likedPosts in
            DispatchQueue.main.async {
                self.likedPosts = likedPosts
                self.filteredPosts = likedPosts
            }
        }
    }
}
