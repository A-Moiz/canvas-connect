//
//  AddEmailView.swift
//  Canvas Connect
//
//  Created by Abdul on 13/01/2024.
//

import SwiftUI

struct AddEmailView: View {
    @State private var email = ""
    var body: some View {
        VStack {
            // Title
            Text("Add your email")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.vertical)
            
            // Description
            Text("You'll use this email to sign into your account")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            // Email TextField
            TextField("Enter your email", text: $email)
                .autocapitalization(.none)
                .modifier(TextFieldModifier())
            
            // Next
            NavigationLink {
                CreateUsernameView()
            } label: {
                Text("Next")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 360, height: 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
            }
            .padding(.vertical)
            
            Spacer()
        }
    }
}

#Preview {
    AddEmailView()
}
