//
//  CreateUsernameView.swift
//  Canvas Connect
//
//  Created by Abdul on 14/01/2024.
//

import SwiftUI

struct CreateUsernameView: View {
    @State private var username = ""
    var body: some View {
        VStack {
            // Title
            Text("Create a username")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.vertical)
            
            // Email TextField
            TextField("Enter your email", text: $username)
                .autocapitalization(.none)
                .modifier(TextFieldModifier())
            
            // Next
            NavigationLink {
                CreatePasswordView()
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
    CreateUsernameView()
}
