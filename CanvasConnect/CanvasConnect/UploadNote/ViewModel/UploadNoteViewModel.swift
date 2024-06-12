//
//  UploadNoteViewModel.swift
//  CanvasConnect
//
//  Created by Abdul on 29/04/2024.
//

import Foundation
import PhotosUI
import SwiftUI
import Firebase
import FirebaseStorage

@MainActor
class UploadNoteViewModel: ObservableObject {
    @Published var hasWatermark = false
    @Published var canComment = false
    
    // Uploads post to Firestore with caption, image, and post metadata
    func uploadNote(text: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let noteRef = Firestore.firestore().collection("notes").document()
        let note = Note(id: noteRef.documentID, ownerUid: uid, text: text, likes: 0, timestamp: Timestamp(), isLiked: false, canComment: canComment)
        guard let encodedNote = try? Firestore.Encoder().encode(note) else { return }
        
        let userRef = Firestore.firestore().collection("users").document(uid)
        try await userRef.updateData(["noteCount": FieldValue.increment(Int64(1))])
        
        try await noteRef.setData(encodedNote)
    }
}
