//
//  NoteCommentViewModel.swift
//  CanvasConnect
//
//  Created by Abdul on 29/04/2024.
//

import Foundation
import Firebase
import FirebaseAuth

class NoteCommentViewModel: ObservableObject {
    @Published var notes = [Comment]()
    @Published var commentDetails = [String: (comment: String, username: String, profileImageUrl: String, timeStamp: Timestamp)]()
    
    func addComment(commentText: String, note: Note) {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        let commentsCollection = db.collection("comments")
        
        let comment = Comment(id: NSUUID().uuidString, comment: commentText, timestamp: Timestamp(), userId: currentUserID, postId: note.id)
        
        do {
            try commentsCollection.addDocument(from: comment) { error in
                if let error = error {
                    print("Error adding comment: \(error.localizedDescription)")
                } else {
                    print("Comment added successfully")
                }
            }
        } catch {
            print("Error encoding comment: \(error.localizedDescription)")
        }
    }
    
    func isCurrentUser() -> Bool {
        var uid = Auth.auth().currentUser?.uid
        return uid == Auth.auth().currentUser?.uid
    }
    
    func fetchComments(for note: Note) {
        let db = Firestore.firestore()
        let commentsCollection = db.collection("comments")
        
        let query = commentsCollection.whereField("postId", isEqualTo: note.id)
        
        query.addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error fetching comments: \(error.localizedDescription)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No comments found")
                return
            }
            
            for document in documents {
                guard let comment = try? document.data(as: Comment.self) else {
                    print("Error decoding comment")
                    continue
                }
                
                self.getUserDetails(userId: comment.userId) { username, profileImageUrl in
                    if let username = username, let profileImageUrl = profileImageUrl {
                        self.commentDetails[comment.id] = (comment.comment, username, profileImageUrl, comment.timestamp)
                    } else {
                        print("Failed to retrieve user details for comment")
                    }
                }
            }
        }
    }
    
    func getUserDetails(userId: String, completion: @escaping (String?, String?) -> Void) {
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        
        usersCollection.document(userId).getDocument { snapshot, error in
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                completion(nil, nil)
                return
            }
            
            guard let data = snapshot?.data(),
                  let username = data["username"] as? String,
                  let profileImageUrl = data["profileImageUrl"] as? String else {
                print("Error: Username or profile image URL not found for user with ID \(userId)")
                completion(nil, nil)
                return
            }
            
            completion(username, profileImageUrl)
        }
    }
}
