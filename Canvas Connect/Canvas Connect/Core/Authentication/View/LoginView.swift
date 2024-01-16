//
//  LoginView.swift
//  Canvas Connect
//
//  Created by Abdul on 13/01/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Welcome Back to Canvas Connect\nLet's get you signed in.")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                
                // Logo
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 200)
                    .clipShape(Circle())
                    .padding(.bottom, 8)
                
                // TextFields
                VStack {
                    TextField("Enter your email", text: $email)
                        .autocapitalization(.none)
                        .modifier(TextFieldModifier())
                    
                    SecureField("Enter your password", text: $password)
                        .modifier(TextFieldModifier())
                }
                
                // Forgot password
                Button {
                    print("Forgot password")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                // Login
                Button {
                    print("Login")
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
                
                // Sign up
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
                
//                NavigationLink {
//                    Text("Sign up")
//                } label: {
//                    HStack {
//                        Text("Don't have an account?")
//                        
//                        Text("Sign up")
//                            .fontWeight(.semibold)
//                    }
//                    .font(.footnote)
//                }
            }
        }
    }
}

#Preview {
    LoginView()
}
