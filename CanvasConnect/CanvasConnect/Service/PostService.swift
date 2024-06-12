//
//  PostService.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import Foundation
import Firebase

struct PostService {
    
    private static let postsCollection = Firestore.firestore().collection("posts")
    
//    // Fetch all posts to display on Feed
//    static func fetchFeedPosts() async throws -> [Post] {
//        do {
//            let snapshot = try await postsCollection.getDocuments()
//            var posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
//            
//            for i in 0 ..< posts.count {
//                let post = posts[i]
//                let ownerUid = post.ownerUid
//                let postUser = try await UserService.fetchUser(withUid: ownerUid)
//                posts[i].user = postUser
//            }
//            
//            return posts
//        } catch {
//            throw error
//        }
//    }
    
    // Fetch all posts to display on Feed except current users
    static func fetchFeedPosts() async throws -> [Post] {
        let uid = Auth.auth().currentUser?.uid
        
        do {
            let snapshot = try await postsCollection.getDocuments()
            var posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
            
            // Filter out posts belonging to the current user
            posts = posts.filter { $0.ownerUid != uid }
            
            // Fetch user data for each post's owner
            for i in 0 ..< posts.count {
                let post = posts[i]
                let ownerUid = post.ownerUid
                let postUser = try await UserService.fetchUser(withUid: ownerUid)
                posts[i].user = postUser
            }
            
            return posts
            
        } catch {
            throw error
        }
    }
    
    // Fetch users posts
    static func fetchUserPosts(uid: String) async throws -> [Post] {
        do {
            let querySnapshot = try await postsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
            return try querySnapshot.documents.compactMap { document in
                try document.data(as: Post.self)
            }
        } catch {
            print("Error fetching feed posts")
            throw error
        }
    }
    
    
    // Like post
    func likePosts(_ post: Post, completion: @escaping() -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("posts").document(post.id).updateData(["likes" : post.likes + 1]) { _ in
            userLikesRef.document(post.id).setData([:]) { _ in
                completion()
            }
        }
    }
    
    // Unlike post
    func unlikePost(_ post: Post, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard post.likes > 0 else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("posts").document(post.id).updateData(["likes" : post.likes - 1]) { _ in
            userLikesRef.document(post.id).delete() { _ in
                completion()
            }
        }
        
    }
    
    // Fetch all posts user has liked
    func fetchLikedPosts(uid: String, completion: @escaping ([Post]) -> Void) {
        Firestore.firestore().collection("users").document(uid).collection("user-likes").getDocuments { snapshot, error in
            if let error = error {
                print("Error getting liked posts: \(error)")
                completion([])
                return
            }
            
            var likedPosts = [Post]()
            let dispatchGroup = DispatchGroup()
            
            for document in snapshot!.documents {
                let postID = document.documentID
                
                dispatchGroup.enter()
                
                Firestore.firestore().collection("posts").document(postID).getDocument { postSnapshot, postError in
                    defer {
                        dispatchGroup.leave()
                    }
                    
                    if let postError = postError {
                        print("Error fetching post with ID \(postID): \(postError)")
                        return
                    }
                    
                    if let postDocument = postSnapshot, let post = try? postDocument.data(as: Post.self) {
                        likedPosts.append(post)
                    }
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(likedPosts)
            }
        }
    }
    
    // Fetch all posts user has saved
    func fetchSavedPosts(uid: String, completion: @escaping ([Post]) -> Void) {
        Firestore.firestore().collection("users").document(uid).collection("user-saved").getDocuments { snapshot, error in
            if let error = error {
                print("Error getting saved posts: \(error)")
                completion([])
                return
            }
            
            var savedPosts = [Post]()
            let dispatchGroup = DispatchGroup()
            
            for document in snapshot!.documents {
                let postID = document.documentID
                
                dispatchGroup.enter()
                
                Firestore.firestore().collection("posts").document(postID).getDocument { postSnapshot, postError in
                    defer {
                        dispatchGroup.leave()
                    }
                    
                    if let postError = postError {
                        print("Error fetching post with ID \(postID): \(postError)")
                        return
                    }
                    
                    if let postDocument = postSnapshot, let post = try? postDocument.data(as: Post.self) {
                        savedPosts.append(post)
                    }
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(savedPosts)
            }
        }
    }
    
    // Check if user liked post
    func checkIfUserLikedPost(_ post: Post, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .document(post.id).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    
    // Save post
    func savePosts(_ post: Post, completion: @escaping() -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userSavesRef = Firestore.firestore().collection("users").document(uid).collection("user-saved")
        
        Firestore.firestore().collection("posts").document(post.id).updateData(["saves" : post.saves + 1]) { _ in
            userSavesRef.document(post.id).setData([:]) { _ in
                completion()
            }
        }
    }
    
    // Unsave post
    func unsavePost(_ post: Post, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard post.saves > 0 else { return }
        
        let userSavesRef = Firestore.firestore().collection("users").document(uid).collection("user-saved")
        
        Firestore.firestore().collection("posts").document(post.id).updateData(["likes" : post.saves - 1]) { _ in
            userSavesRef.document(post.id).delete() { _ in
                completion()
            }
        }
        
    }
    
    // Check if user saved post
    func checkIfUserSavedPost(_ post: Post, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-saved")
            .document(post.id).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    
    // Filtering user posts by caption
    static func filterUserPostsByCaption(uid: String, keyword: String) async throws -> [Post] {
        do {
            let querySnapshot = try await postsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
            let posts = try querySnapshot.documents.compactMap { document -> Post? in
                try document.data(as: Post.self)
            }.filter { post in
                post.caption.contains(keyword)
            }
            return posts
        } catch {
            print("Error filtering user posts by caption: \(error)")
            throw error
        }
    }
    
    //    static func openImageURL(of post: Post) async {
    //        do {
    //            let postDocument = try await Firestore.firestore().collection("posts").document(post.id).getDocument()
    //            guard let postData = postDocument.data(),
    //                  let imageURLString = postData["imageUrl"] as? String,
    //                  let imageURL = URL(string: imageURLString) else {
    //                print("Invalid image URL or post data")
    //                return
    //            }
    //            await UIApplication.shared.open(imageURL, options: [:], completionHandler: nil)
    //            print("Image URL String is: \(imageURLString)")
    //            print("Image URL is: \(imageURL)")
    //        } catch {
    //            print("Error fetching post data: \(error)")
    //        }
    //    }
    
    // Delete post
    func deletePost(_ post: Post, completion: @escaping (Error?) -> Void) {
        Task {
            do {
                guard let currentUserID = Auth.auth().currentUser?.uid else {
                    completion(nil)
                    return
                }
                
                let postsCollection = Firestore.firestore().collection("posts")
                guard post.ownerUid == currentUserID else {
                    completion(NSError(domain: "PostService", code: 401, userInfo: [NSLocalizedDescriptionKey: "You are not authorized to delete this post."]))
                    return
                }
                
                try await postsCollection.document(post.id).delete()
                let userRef = Firestore.firestore().collection("users").document(currentUserID)
                try await userRef.updateData(["postCount": FieldValue.increment(-Int64(1))])
                completion(nil)
                print("Post deleted")
            } catch {
                completion(error)
                print("Post not deleted")
            }
        }
    }
}
