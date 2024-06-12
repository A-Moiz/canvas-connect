//
//  AddEmailView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import SwiftUI

struct AddEmailView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    @StateObject var background = BackgroundSelectionViewModel()
    @State private var isEmailValid = false
    @State private var showAlert = false
    @State private var navigateToNextView = false
    @State private var showEmailAlert = false
    
    var body: some View {
        VStack {
            // Title
            Text("Enter your email")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.vertical)
                .foregroundColor(.white)
            
            // Description
            Text("You'll use this email to sign into your account")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            // Email TextField
            TextField("Enter your email", text: $viewModel.email)
                .textInputAutocapitalization(.never)
                .modifier(TextFieldModifier())
                .padding(.horizontal, 24)
                .onChange(of: viewModel.email) { email in
                    isEmailValid = isValidEmail(email)
                }
            
            // Validation Text
            if !isEmailValid {
                Text("Please enter a valid email address")
                    .font(.caption)
                    .foregroundColor(.red)
            }
            
            // Next Button
            Button(action: {
                Task {
                    do {
                        let isAvailable = try await viewModel.checkEmail()
                        if isAvailable {
                            showEmailAlert.toggle()
                        } else {
                            showAlert.toggle()
                        }
                    } catch {
                        print("Error checking email availability: \(error.localizedDescription)")
                    }
                }
            }) {
                Text("Next")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 360, height: 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
            }
            .padding(.vertical)
            .disabled(!isEmailValid)
            
            if showAlert {
                Text("The email you entered is already in use. Please use a different email.")
                    .font(.caption)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
        }
        .background(
            NavigationLink(
                destination: CreateUsernameView(),
                isActive: $navigateToNextView,
                label: EmptyView.init
            )
            .hidden()
        )
        .background(Image(background.backgroundImages[background.authenticationBG])
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all))
        .alert(isPresented: $showEmailAlert) {
            Alert(
                title: Text("Verify Email"),
                message: Text("Please check your email address, you will NOT be able to change this later. \n\nIs \n\n\(viewModel.email) \n\nyour correct email address?"),
                primaryButton: .destructive(Text("Yes")) {
                    navigateToNextView = true
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

#Preview {
    AddEmailView()
}
