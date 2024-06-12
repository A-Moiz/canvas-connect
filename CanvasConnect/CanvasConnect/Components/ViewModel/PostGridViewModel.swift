//
//  PostGridViewModel.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import Foundation

class PostGridViewModel: ObservableObject {
    private let user: User
    @Published var posts = [Post]()
    var filteredPosts = [Post]()
    
    init(user: User) {
        self.user = user
        Task { try await fetchUserPosts() }
    }
    
    @MainActor
    func fetchUserPosts() async throws {
        do {
            self.posts = try await PostService.fetchUserPosts(uid: user.id)
            self.filteredPosts = self.posts
        } catch {
            print("Error fetching user posts: \(error)")
            throw error
        }
    }
    
    @MainActor
    func filterUserPostsByCaption(keyword: String) async throws {
        do {
            if keyword.isEmpty {
                self.filteredPosts = self.posts
            } else {
                self.filteredPosts = try await PostService.filterUserPostsByCaption(uid: user.id, keyword: keyword)
            }
        } catch {
            print("Error filtering user posts by caption: \(error)")
            throw error
        }
    }
}
