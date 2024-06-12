//
//  LoginViewModel.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    @Published var emailNotSent: Bool = false
    @Published var message: String = ""
    
    @Published var loginError: Bool = false
    @Published var loginMessage: String = ""
    
//    @MainActor
//    func signIn() async {
//        do {
//            try await AuthService.shared.login(withEmail: email, password: password)
//            self.errorMessage = ""
//        } catch {
//            self.errorMessage = "Invalid email or password"
//            print("Error signing in: \(error.localizedDescription)")
//        }
//    }
    
    @MainActor
    func signIn() async {
        AuthService.shared.login(withEmail: email, password: password) { error in
            if let error = error {
                self.loginError = true
                self.loginMessage = error.localizedDescription
            } else {
                print("Signed in")
            }
        }
    }
    
//    @MainActor
//    func resetPassword() async {
//        do {
//            try await AuthService.shared.sendPasswordResetEmail(for: email)
//        } catch {
//            print("BOOL: \(AuthService.shared.emailNotSent)")
//            emailNotSent = true
//            print("Error sending email: \(error.localizedDescription)")
//            print("\(AuthService.shared.message)")
//            message = error.localizedDescription
//            print("\(message)")
//        }
//    }
    
    @MainActor
    func resetPassword() {
        AuthService.shared.sendPasswordResetEmail(for: email) { error in
            if let error = error {
                self.emailNotSent = true
                self.message = error.localizedDescription
            } else {
                print("Email sent to \(self.email)")
            }
        }
    }

}
