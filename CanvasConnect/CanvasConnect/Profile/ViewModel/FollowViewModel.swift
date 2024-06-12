//
//  FollowViewModel.swift
//  CanvasConnect
//
//  Created by Abdul on 02/04/2024.
//

//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//
//class FollowViewModel: ObservableObject {
//    @Published var user: User
//    @Published var viewedUser: User
//    @Published var isFollowerUpdated = false
//
//    init(user: User, viewedUser: User, isFollowerUpdated: Bool = false) {
//        self.user = user
//        self.viewedUser = viewedUser
//        self.isFollowerUpdated = isFollowerUpdated
//    }
//
//    func followUser(_ followedUserID: String, completion: @escaping () -> Void) {
//        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
//        print("Current User ID is: \(currentUserID)")
//        print("Followed User ID is: \(followedUserID)")
//
//        let userFollowsRef = Firestore.firestore().collection("users").document(currentUserID).collection("user-follows")
//
//        userFollowsRef.document(followedUserID).setData([:]) { error in
//            if let error = error {
//                print("Error following user: \(error.localizedDescription)")
//            } else {
//                print("Successfully followed user with ID: \(followedUserID)")
//                completion()
//            }
//        }
//    }
//
//    func isFollowingUser(_ userID: String, completion: @escaping (Bool) -> Void) {
//        guard let currentUserID = Auth.auth().currentUser?.uid else {
//            completion(false)
//            return
//        }
//
//        let userFollowsRef = Firestore.firestore().collection("users").document(currentUserID).collection("user-follows")
//
//        userFollowsRef.document(userID).getDocument { document, error in
//            if let error = error {
//                print("Error checking follow status: \(error.localizedDescription)")
//                completion(false)
//                return
//            }
//
//            if let document = document, document.exists {
//                completion(true)
//            } else {
//                completion(false)
//            }
//        }
//    }
//
//    func unfollowUser(_ followedUserID: String, completion: @escaping () -> Void) {
//        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
//        print("Current User ID is: \(currentUserID)")
//        print("Unfollowed User ID is: \(followedUserID)")
//
//        let userFollowsRef = Firestore.firestore().collection("users").document(currentUserID).collection("user-follows")
//
//        userFollowsRef.document(followedUserID).delete { error in
//            if let error = error {
//                print("Error unfollowing user: \(error.localizedDescription)")
//            } else {
//                print("Successfully unfollowed user with ID: \(followedUserID)")
//                completion()
//            }
//        }
//    }
//
//    func getUserFollowCount(completion: @escaping (Int) -> Void) {
//        guard !viewedUser.id.isEmpty else {
//            completion(0)
//            return
//        }
//
//        let userFollowsRef = Firestore.firestore().collection("users").document(viewedUser.id).collection("user-follows")
//
//        userFollowsRef.getDocuments { snapshot, error in
//            if let error = error {
//                print("Error fetching user follow count: \(error.localizedDescription)")
//                completion(0)
//                return
//            }
//
//            if let snapshot = snapshot {
//                completion(snapshot.documents.count)
//            } else {
//                completion(0)
//            }
//        }
//    }
//
////    func getFollowedUserCount(completion: @escaping (Int) -> Void) {
////        guard !viewedUser.id.isEmpty else {
////            completion(0)
////            return
////        }
////
////        let followedUserRef = Firestore.firestore().collection("users").document(viewedUser.id).collection("user-follows")
////
////        followedUserRef.getDocuments { snapshot, error in
////            if let error = error {
////                print("Error fetching followed user count: \(error.localizedDescription)")
////                completion(0)
////                return
////            }
////
////            if let snapshot = snapshot {
////                completion(snapshot.documents.count)
////            } else {
////                completion(0)
////            }
////        }
////    }
//
//    func getFollowedUserCount(completion: @escaping (Int) -> Void) {
//        guard !viewedUser.id.isEmpty else {
//            completion(0)
//            return
//        }
//
//        let followedUserRef = Firestore.firestore().collection("users").document(viewedUser.id).collection("user-follows")
//
//        followedUserRef.getDocuments { snapshot, error in
//            if let error = error {
//                print("Error fetching followed user count: \(error.localizedDescription)")
//                completion(0)
//                return
//            }
//
//            // Count the number of documents (i.e., number of users being followed)
//            if let snapshot = snapshot {
//                completion(snapshot.documents.count)
//            } else {
//                completion(0)
//            }
//        }
//    }
//}

// VERSION 2:
import Foundation
import FirebaseAuth
import FirebaseFirestore

class FollowViewModel: ObservableObject {
    @Published var user: User
    @Published var viewedUser: User
    @Published var isFollowerUpdated = false
    @Published var areFollowing = false
    @Published var areFollowingUpdated = false
    
    init(user: User, viewedUser: User, isFollowerUpdated: Bool = false) {
        self.user = user
        self.viewedUser = viewedUser
        self.isFollowerUpdated = isFollowerUpdated
    }
    
    func followUser(_ followedUserID: String, completion: @escaping () -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        
        let followedUserRef = Firestore.firestore().collection("users").document(followedUserID).collection("user-followed")
        
        followedUserRef.document(currentUserID).setData([:]) { error in
            if let error = error {
                print("Error adding follower: \(error.localizedDescription)")
            } else {
                print("Successfully added follower: \(currentUserID)")
                completion()
            }
        }
        
        let userFollowsRef = Firestore.firestore().collection("users").document(currentUserID).collection("user-follows")
        userFollowsRef.document(followedUserID).setData([:]) { error in
            if let error = error {
                print("Error following user: \(error.localizedDescription)")
            } else {
                print("Successfully followed user: \(followedUserID)")
                completion()
            }
        }
    }
    
    func isFollowingUser(_ userID: String, completion: @escaping (Bool) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        
        let userFollowsRef = Firestore.firestore().collection("users").document(currentUserID).collection("user-follows")
        
        userFollowsRef.document(userID).getDocument { document, error in
            if let error = error {
                print("Error checking follow status: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let document = document, document.exists {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func unfollowUser(_ followedUserID: String, completion: @escaping () -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        print("Current user id: \(currentUserID)")
        
        let followedUserRef = Firestore.firestore().collection("users").document(followedUserID).collection("user-followed")
        
        print("Viewing user id: \(followedUserID)")
        
        followedUserRef.document(currentUserID).delete { error in
            if let error = error {
                print("Error removing follower: \(error.localizedDescription)")
            } else {
                print("Successfully removed follower: \(currentUserID)")
                completion()
            }
        }
        
        let userFollowsRef = Firestore.firestore().collection("users").document(currentUserID).collection("user-follows")
        userFollowsRef.document(followedUserID).delete { error in
            if let error = error {
                print("Error unfollowing user: \(error.localizedDescription)")
            } else {
                print("Successfully unfollowed user: \(followedUserID)")
                completion()
            }
        }
    }
    
    func getUserFollowCount(completion: @escaping (Int) -> Void) {
        guard !viewedUser.id.isEmpty else {
            completion(0)
            return
        }
        
        let userFollowsRef = Firestore.firestore().collection("users").document(viewedUser.id).collection("user-follows")
        
        userFollowsRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching user follow count: \(error.localizedDescription)")
                completion(0)
                return
            }
            
            if let snapshot = snapshot {
                completion(snapshot.documents.count)
            } else {
                completion(0)
            }
        }
    }
    
    func getFollowedUserCount(completion: @escaping (Int) -> Void) {
        guard !viewedUser.id.isEmpty else {
            completion(0)
            return
        }
        
        let followedUserRef = Firestore.firestore().collection("users").document(viewedUser.id).collection("user-followed")
        
        followedUserRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching followed user count: \(error.localizedDescription)")
                completion(0)
                return
            }
            
            if let snapshot = snapshot {
                completion(snapshot.documents.count)
            } else {
                completion(0)
            }
        }
    }
    
//    func areUsersFollowingEachOther(completion: @escaping (Bool) -> Void) {
//        guard let currentUserID = Auth.auth().currentUser?.uid else {
//            completion(false)
//            return
//        }
//        
//        isFollowingUser(viewedUser.id) { currentUserIsFollowing in
//            self.isFollowingUser(currentUserID) { viewedUserIsFollowing in
//                completion(currentUserIsFollowing && viewedUserIsFollowing)
//            }
//        }
//    }
    
//    func areUsersFollowingEachOther() -> Bool {
//        guard let currentUserID = Auth.auth().currentUser?.uid else {
//            return false
//        }
//        
//        var areFollowing = false
//        
//        let dispatchGroup = DispatchGroup()
//        
//        dispatchGroup.enter()
//        isFollowingUser(viewedUser.id) { currentUserIsFollowing in
//            self.isFollowingUser(currentUserID) { viewedUserIsFollowing in
//                areFollowing = currentUserIsFollowing && viewedUserIsFollowing
//                dispatchGroup.leave()
//            }
//        }
//        
//        dispatchGroup.wait()
//        return areFollowing
//    }
    
    func areUsersFollowingEachOther() -> Bool {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            return false
        }
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        isFollowingUser(viewedUser.id) { currentUserIsFollowing in
            self.areFollowing = currentUserIsFollowing
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        isFollowingUser(currentUserID) { viewedUserIsFollowing in
            self.areFollowing = self.areFollowing && viewedUserIsFollowing
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.areFollowingUpdated = true
            if self.areFollowing {
                print("Both users are following each other")
            } else {
                print("Users are not following each other")
            }
        }
        
        return areFollowing
    }
}
