//
//  NoteButtonsViewModel.swift
//  CanvasConnect
//
//  Created by Abdul on 29/04/2024.
//

import Foundation

class NoteButtonsViewModel: ObservableObject {
    
    private let service = NoteService()
    @Published var note: Note
    
    init(note: Note) {
        self.note = note
        checkIfUserLikedNote()
    }
    
    func likeNote() {
        service.likeNote(note) {
            self.note.isLiked = true
        }
    }
    
    func unlikeNote() {
        service.unlikeNote(note) {
            self.note.isLiked = false
        }
    }
    
    func checkIfUserLikedNote() {
        service.checkIfUserLikedNote(note) { isLiked in
            if isLiked {
                self.note.isLiked = true
            }
        }
    }
    
    func deleteNote() async {
        try await service.deleteNote(note) { error in
            if let error = error {
                print("Error deleting note: \(error)")
            } else {
                print("Note deleted successfully")
            }
        }
    }
}
