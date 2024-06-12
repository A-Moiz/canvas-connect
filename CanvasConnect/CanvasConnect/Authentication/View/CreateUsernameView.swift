//
//  CreateUsernameView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import SwiftUI

struct CreateUsernameView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    @StateObject var background = BackgroundSelectionViewModel()
    @State private var showAlert = false
    @State private var navigateToCreatePassword = false

    var body: some View {
        VStack {
            // Title
            Text("Create a username")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.vertical)
                .foregroundColor(.white)
            
            // Description
            Text("You won't be able to change this later on")
                .font(.footnote)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            // Username TextField
            TextField("Enter your username", text: $viewModel.username)
                .autocapitalization(.none)
                .modifier(TextFieldModifier())
            
            // Next Button
            Button(action: {
                Task {
                    do {
                        let available = try await viewModel.checkUsername()
                        let valid = try await viewModel.checkUsernameLength()
                        if available && valid {
                            showAlert = false
                            navigateToCreatePassword = true
                        } else {
                            showAlert = true
                        }
                    } catch {
                        print("Error checking username availability: \(error.localizedDescription)")
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
            .disabled(viewModel.username.isEmpty)
            
            Spacer()
        }
        .background(Image(background.backgroundImages[background.authenticationBG])
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all))
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Invalid Username"),
                message: Text("The username you entered is already taken or invalid. Please choose a different username, a username cannot have any spaces and must be at least 6 characters long."),
                dismissButton: .default(Text("OK"))
            )
        }
        NavigationLink(destination: CreatePasswordView(), isActive: $navigateToCreatePassword) {
            EmptyView()
        }
        .hidden()
    }
}

#Preview {
    CreateUsernameView()
}
