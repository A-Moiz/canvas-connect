//
//  LoginView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @StateObject var background = BackgroundSelectionViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                // Welcome message
                Text("Hello again!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                
                Text("Welcome back to Canvas Connect.")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.white)
                
                // Logo
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 200)
                    .clipShape(Circle())
                    .padding(.bottom, 8)
                
                // TextFields
                VStack {
                    TextField("Enter your email", text: $viewModel.email)
                        .autocapitalization(.none)
                        .modifier(TextFieldModifier())
                    
                    SecureField("Enter your password", text: $viewModel.password)
                        .modifier(TextFieldModifier())
                }
                
                // Forgot password
                Button {
                    Task { await viewModel.resetPassword() }
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .alert(isPresented: $viewModel.emailNotSent) {
                    Alert(
                        title: Text("Error sending email"),
                        message: Text("\(viewModel.message)"),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                // Error message
                Text(viewModel.errorMessage)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .padding(.top, 8)
                
                // Login button
                Button {
                    Task {
                        await viewModel.signIn()
                    }
                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 44)
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                }
                .padding(.vertical)
                .alert(isPresented: $viewModel.loginError) {
                    Alert(
                        title: Text("Error"),
                        message: Text("\(viewModel.loginMessage)"),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                // Divider
                HStack {
                    Rectangle()
                        .frame(width: 150, height: 0.5)
                    
                    Text("OR")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Rectangle()
                        .frame(width: 150, height: 0.5)
                }
                .foregroundColor(.gray)
                
                // Sign up button
                Button {
                } label: {
                    NavigationLink(destination: AddEmailView()) {
                        Text("Sign up")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 44)
                            .background(Color(.systemRed))
                            .cornerRadius(10)
                    }
                    .padding(.vertical)
                }
                
                Spacer()
            }
            .background(Image(background.backgroundImages[background.authenticationBG])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    LoginView()
}
