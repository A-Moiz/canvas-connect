//
//  NotesViewModel.swift
//  CanvasConnect
//
//  Created by Abdul on 29/04/2024.
//

import Foundation

class NotesViewModel: ObservableObject {
    private let user: User
    @Published var notes = [Note]()
    var filteredNotes = [Note]()
    
    init(user: User) {
        self.user = user
        Task { try await fetchUserNotes() }
    }
    
    @MainActor
    func fetchUserNotes() async throws {
        do {
            self.notes = try await NoteService.fetchUserNotes(uid: user.id)
            self.filteredNotes = self.notes
        } catch {
            print("Error fetching user notes: \(error)")
            throw error
        }
    }
    
    @MainActor
    func filterUserNotes(keyword: String) async throws {
        do {
            if keyword.isEmpty {
                self.filteredNotes = self.notes
            } else {
                self.filteredNotes = try await NoteService.filterUserNotes(uid: user.id, keyword: keyword)
            }
        } catch {
            print("Error filtering user notes by caption: \(error)")
            throw error
        }
    }
}
