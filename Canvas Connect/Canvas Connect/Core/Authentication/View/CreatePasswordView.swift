//
//  CreatePasswordView.swift
//  Canvas Connect
//
//  Created by Abdul on 14/01/2024.
//

import SwiftUI

struct CreatePasswordView: View {
    @State private var password = ""
    var body: some View {
        VStack {
            // Title
            Text("Create a password")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.vertical)
            
            // Description
            Text("You'll use this password to login to your account")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            // Description
            Text("Your password must be at least 6 charactersl long")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                .padding(.top, 4)
            
            // Email TextField
            SecureField("Enter your password", text: $password)
                .autocapitalization(.none)
                .modifier(TextFieldModifier())
                .padding(.top)
            
            // Next
            NavigationLink {
                CompleteSignUpView()
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
    CreatePasswordView()
}
