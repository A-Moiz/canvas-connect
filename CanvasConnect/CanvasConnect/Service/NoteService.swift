//
//  NoteService.swift
//  CanvasConnect
//
//  Created by Abdul on 29/04/2024.
//

import Foundation
import Firebase

struct NoteService {
    
    private static let notesCollection = Firestore.firestore().collection("notes")
    
    // Fetch all notes to display on Feed
    static func fetchFeedNotes() async throws -> [Note] {
        let uid = Auth.auth().currentUser?.uid
        
        do {
            let snapshot = try await notesCollection.getDocuments()
            var notes = try snapshot.documents.compactMap({ try $0.data(as: Note.self) })
            
            notes = notes.filter { $0.ownerUid != uid }
            
            for i in 0 ..< notes.count {
                let note = notes[i]
                let ownerUid = note.ownerUid
                let noteUser = try await UserService.fetchUser(withUid: ownerUid)
                notes[i].user = noteUser
            }
            
            return notes
            
        } catch {
            throw error
        }
    }

    // Fetch users notes
    static func fetchUserNotes(uid: String) async throws -> [Note] {
        do {
            let querySnapshot = try await notesCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
            return try querySnapshot.documents.compactMap { document in
                try document.data(as: Note.self)
            }
        } catch {
            print("Error fetching feed notes")
            throw error
        }
    }
    
    // Filtering user notes
    static func filterUserNotes(uid: String, keyword: String) async throws -> [Note] {
        do {
            let querySnapshot = try await notesCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
            let notes = try querySnapshot.documents.compactMap { document -> Note? in
                try document.data(as: Note.self)
            }.filter { note in
                note.text.contains(keyword)
            }
            return notes
        } catch {
            print("Error filtering user posts by caption: \(error)")
            throw error
        }
    }
    
    // Like Note
    func likeNote(_ note: Note, completion: @escaping() -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("notes").document(note.id).updateData(["likes" : note.likes + 1]) { _ in
            userLikesRef.document(note.id).setData([:]) { _ in
                completion()
            }
        }
    }
    
    // Unlike note
    func unlikeNote(_ note: Note, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard note.likes > 0 else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("notes").document(note.id).updateData(["likes" : note.likes - 1]) { _ in
            userLikesRef.document(note.id).delete() { _ in
                completion()
            }
        }
        
    }
//    
//    // Fetch all posts user has liked
//    func fetchLikedPosts(uid: String, completion: @escaping ([Post]) -> Void) {
//        Firestore.firestore().collection("users").document(uid).collection("user-likes").getDocuments { snapshot, error in
//            if let error = error {
//                print("Error getting liked posts: \(error)")
//                completion([])
//                return
//            }
//            
//            var likedPosts = [Post]()
//            let dispatchGroup = DispatchGroup()
//            
//            for document in snapshot!.documents {
//                let postID = document.documentID
//                
//                dispatchGroup.enter()
//                
//                Firestore.firestore().collection("posts").document(postID).getDocument { postSnapshot, postError in
//                    defer {
//                        dispatchGroup.leave()
//                    }
//                    
//                    if let postError = postError {
//                        print("Error fetching post with ID \(postID): \(postError)")
//                        return
//                    }
//                    
//                    if let postDocument = postSnapshot, let post = try? postDocument.data(as: Post.self) {
//                        likedPosts.append(post)
//                    }
//                }
//            }
//            
//            dispatchGroup.notify(queue: .main) {
//                completion(likedPosts)
//            }
//        }
//    }
//    
    // Check if user liked notee
    func checkIfUserLikedNote(_ note: Note, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .document(note.id).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    
    // Delete note
    func deleteNote(_ note: Note, completion: @escaping (Error?) -> Void) {
        Task {
            do {
                guard let currentUserID = Auth.auth().currentUser?.uid else {
                    completion(nil)
                    return
                }
                
                let postsCollection = Firestore.firestore().collection("notes")
                guard note.ownerUid == currentUserID else {
                    completion(NSError(domain: "NoteService", code: 401, userInfo: [NSLocalizedDescriptionKey: "You are not authorized to delete this note."]))
                    return
                }
                
                try await postsCollection.document(note.id).delete()
                let userRef = Firestore.firestore().collection("users").document(currentUserID)
                try await userRef.updateData(["noteCount": FieldValue.increment(-Int64(1))])
                completion(nil)
                print("Note deleted")
            } catch {
                completion(error)
                print("Note not deleted")
            }
        }
    }
}
