//
//  UserService.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct UserService {
    
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
//    static func fetchAllUsers() async throws -> [User] {
//        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
//        return snapshot.documents.compactMap({ try? $0.data(as: User.self) })
//    }
    
    static func fetchAllUsers() async throws -> [User] {
        let uid = Auth.auth().currentUser?.uid
        
        do {
            let snapshot = try await Firestore.firestore().collection("users").getDocuments()
            let users = snapshot.documents.compactMap { document -> User? in
                guard let user = try? document.data(as: User.self) else { return nil }
                return user.id != uid ? user : nil
            }
            return users
        } catch {
            throw error
        }
    }
}
