//
//  CompleteSignUpView.swift
//  Canvas Connect
//
//  Created by Abdul on 14/01/2024.
//

import SwiftUI

struct CompleteSignUpView: View {
    var body: some View {
        VStack {
            
            Spacer()
            
            // Title
            Text("Welcome to Canvas Connect,\nUsername")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.vertical)
                .multilineTextAlignment(.center)
            
            // Logo
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 200)
                .clipShape(Circle())
                .padding(.bottom, 8)
            
            // Description
            Text("Click below to comeplete the sign up process and start using Canvas Connect")
                .font(.footnote)
                .padding(.vertical)
                .multilineTextAlignment(.center)
            
            // Next
            Button {
                print("Complete sign up")
            } label: {
                Text("Complete sign up")
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
    CompleteSignUpView()
}
