//
//  RegistrationViewModel.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import Foundation
import FirebaseAuth

class RegistrationViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""

    func createUser() async throws {
        try await AuthService.shared.createUser(email: email.lowercased(), password: password, username: username)
        DispatchQueue.main.async {
            self.username = ""
            self.email = ""
            self.password = ""
        }
    }

    func checkUsername() async throws -> Bool {
        do {
            let isAvailable = try await AuthService.shared.checkUsername(username)
            return isAvailable
        } catch {
            print("Error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func checkUsernameLength() async throws -> Bool {
        do {
            let isValid = username.count >= 6
            return isValid
        } catch {
            print("Error: \(error.localizedDescription)")
            throw error
        }
    }

    func checkEmail() async throws -> Bool {
        do {
            let isAvailable = try await AuthService.shared.checkEmail(email)
            return isAvailable
        } catch {
            print("Error: \(error.localizedDescription)")
            throw error
        }
    }
}
