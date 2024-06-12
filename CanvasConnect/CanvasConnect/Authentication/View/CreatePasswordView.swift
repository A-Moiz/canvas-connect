//
//  CreatePasswordView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import SwiftUI

struct CreatePasswordView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    @StateObject var background = BackgroundSelectionViewModel()
    @State private var isPasswordValid = false
    @State private var showAlert = false
    @State private var navigateToNextView = false
    
    var body: some View {
        VStack {
            // Title
            Text("Create a password")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.vertical)
                .foregroundColor(.white)
            
            // Description
            Text("You'll use this password to login to your account")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            // Description
            Text("Your password must be at least 6 characters long")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                .padding(.top, 4)
            
            // Password TextField
            SecureField("Enter your password", text: $viewModel.password, onCommit: {
                validatePassword()
            })
            .autocapitalization(.none)
            .modifier(TextFieldModifier())
            .padding(.top)
            
            // Next Button
            Button(action: {
                validatePassword()
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
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Password"), message: Text("Password must be at least 6 characters long and contain only letters and numbers."), dismissButton: .default(Text("OK")))
            }
            
            Spacer()
        }
        .background(
            NavigationLink(
                destination: CompleteSignUpView(),
                isActive: $navigateToNextView,
                label: EmptyView.init
            )
            .hidden()
        )
        .background(Image(background.backgroundImages[background.authenticationBG])
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all))
    }
    
    private func validatePassword() {
        let password = viewModel.password
        let passwordRegex = "^[a-zA-Z0-9]{6,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        isPasswordValid = passwordPredicate.evaluate(with: password)
        
        if !isPasswordValid {
            showAlert = true
        } else {
            DispatchQueue.main.async {
                navigateToNextView = true
            }
        }
    }
}

#Preview {
    CreatePasswordView()
}
