//
//  FeedViewModel.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import Foundation

class FeedViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    @Published var notes = [Note]()
    
    init() {
        Task { try await fetchPosts() }
        Task { try await fetchNotes() }
    }
    
    @MainActor
    func fetchPosts() async throws {
        self.posts = try await PostService.fetchFeedPosts()
    }
    
    @MainActor
    func fetchNotes() async throws {
        self.notes = try await NoteService.fetchFeedNotes()
    }
}
