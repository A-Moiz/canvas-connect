//
//  DisplayFollowViewModel.swift
//  CanvasConnect
//
//  Created by Abdul on 03/04/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class DisplayFollowViewModel: ObservableObject {
    @Published var followers = [User]()
    @Published var following = [User]()
    
    func fetchFollowedUsers() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Current user ID not found.")
            return
        }
        
        let followedUsersRef = Firestore.firestore().collection("users").document(currentUserID).collection("user-followed")
        followedUsersRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching followed users: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else {
                print("Snapshot is nil.")
                return
            }
            
            var followedUsers = [User]()
            let dispatchGroup = DispatchGroup()
            
            for document in snapshot.documents {
                let followedUserID = document.documentID
                dispatchGroup.enter()
                self.fetchUser(withUid: followedUserID) { user in
                    if let user = user {
                        followedUsers.append(user)
                    }
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                self.followers = followedUsers
            }
        }
    }
    
    func fetchFollowingUsers() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Current user ID not found.")
            return
        }
        
        let followingUsersRef = Firestore.firestore().collection("users").document(currentUserID).collection("user-follows")
        followingUsersRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching following users: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else {
                print("Snapshot is nil.")
                return
            }
            
            var followingUsers = [User]()
            let dispatchGroup = DispatchGroup()
            
            for document in snapshot.documents {
                let followingUserID = document.documentID
                dispatchGroup.enter()
                self.fetchUser(withUid: followingUserID) { user in
                    if let user = user {
                        followingUsers.append(user)
                    }
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                self.following = followingUsers
            }
        }
    }
    
    private func fetchUser(withUid uid: String, completion: @escaping (User?) -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Error fetching user with ID \(uid): \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let snapshot = snapshot, snapshot.exists, let user = try? snapshot.data(as: User.self) else {
                print("User with ID \(uid) not found.")
                completion(nil)
                return
            }
            
            completion(user)
        }
    }
}
