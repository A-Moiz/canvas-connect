//
//  SavedPostViewModel.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import Foundation

class SavedPostViewModel: ObservableObject {
    private let user: User
    @Published var posts = [Post]()
    @Published var savedPost = [Post]()
    var filteredPosts = [Post]()
    
    init(user: User) {
        self.user = user
        Task { try await fetchSavedPosts() }
    }
    
    @MainActor
    func fetchSavedPosts() {
        PostService().fetchSavedPosts(uid: user.id) { savedPosts in
            DispatchQueue.main.async {
                self.savedPost = savedPosts
                self.filteredPosts = savedPosts
            }
        }
    }
}
