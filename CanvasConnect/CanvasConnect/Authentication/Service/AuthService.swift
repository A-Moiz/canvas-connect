//
//  AuthService.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import Firebase
import FirebaseAuth
import Foundation
import FirebaseFirestoreSwift

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    private var showAlert = false
    private var isLoading = false
    private var alertMessage = ""
    
    @Published var emailNotSent: Bool = false
    @Published var message: String = ""
    
    static let shared = AuthService()
    
    init() {
        Task { try await loadUserData() }
        self.userSession = Auth.auth().currentUser
    }
    
//    // Login
//    // MAIN
//    @MainActor
//    func login(withEmail email: String, password: String) async throws {
//        do {
//            let result = try await Auth.auth().signIn(withEmail: email, password: password)
//            self.userSession = result.user
//            try await loadUserData()
//        } catch {
//            print("DEBUG: Failed to log in user with error \(error.localizedDescription)")
//            throw error
//        }
//    }
    
    @MainActor
    func login(withEmail email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                print("DEBUG: Failed to log in user with error \(error.localizedDescription)")
                completion(error)
            } else if let user = authResult?.user {
                self?.userSession = user
                Task {
                    do {
                        try await self?.loadUserData()
                        completion(nil)
                    } catch {
                        completion(error)
                    }
                }
            } else {
                completion(error)
            }
        }
    }
    
    // Create User with email and password
    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            
            // Send verification email
            try await result.user.sendEmailVerification()
            
            // Wait for email verification
            while !result.user.isEmailVerified {
                try await result.user.reload()
                try await Task.sleep(nanoseconds: 5)
            }
            
            await uploadUserData(uid: result.user.uid, username: username, email: email, isEmailVerified: result.user.isEmailVerified)
        } catch {
            print("DEBUG: Failed to register user with error \(error.localizedDescription)")
        }
    }
    
//    // Restting password
//    // MAIN
//    func sendPasswordResetEmail(for email: String) {
//        Auth.auth().sendPasswordReset(withEmail: email) { error in
//            if let error = error {
//                print("BEFORE: \(self.emailNotSent)")
//                self.emailNotSent = true
//                print("AFTER: \(self.emailNotSent)")
//                self.message = error.localizedDescription
//                print("Error sending password reset email: \(error.localizedDescription)")
//            } else {
//                print("Password reset email sent successfully")
//            }
//        }
//    }
    
    // Resetting password
    func sendPasswordResetEmail(for email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
    
    // Loading user data
    @MainActor
    func loadUserData() async throws {
        self.userSession = Auth.auth().currentUser
        guard let currentUid = userSession?.uid else { return }
        self.currentUser = try await UserService.fetchUser(withUid: currentUid)
    }
    
    // Signing out User
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
    // Uploading user data to Firebase
    private func uploadUserData(uid: String, username: String, email: String, isEmailVerified: Bool) async {
        let user = User(id: uid, username: username, email: email, isEmailVerified: isEmailVerified)
        self.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
    
    // Checking if username is valid
    func checkUsername(_ username: String) async throws -> Bool {
        guard !username.contains(" ") else {
            return false
        }
        
        let usersRef = Firestore.firestore().collection("users")
        let querySnapshot = try await usersRef.whereField("username", isEqualTo: username).getDocuments()
        return querySnapshot.documents.isEmpty
    }
    
    // Checking if email is valid
    func checkEmail(_ email: String) async throws -> Bool {
        guard !email.contains(" ") else {
            return false
        }
        
        let usersRef = Firestore.firestore().collection("users")
        let querySnapshot = try await usersRef.whereField("email", isEqualTo: email.lowercased()).getDocuments()
        return querySnapshot.documents.isEmpty
    }
}
