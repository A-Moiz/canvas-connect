//
//  CompleteSignUpView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import SwiftUI

struct CompleteSignUpView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    @StateObject var background = BackgroundSelectionViewModel()

    var body: some View {
        VStack {
            Spacer()

            // Title
            Text("Welcome to Canvas Connect,\n\(viewModel.username)")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.vertical)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)

            // Logo
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 200)
                .clipShape(Circle())
                .padding(.bottom, 8)

            // Description
            VStack(spacing: 10) {
                //Text("An email has been sent to your inbox to verify your address")
                Text("You must verify your email in order to use this application.")
                    .multilineTextAlignment(.center)
                Text("Email will be sent to \(viewModel.email)")
                    .multilineTextAlignment(.center)
                //Text("Click below to verify your email address")
                Text("Click below to get the verification email")
                    .font(.footnote)
                    .padding(.vertical)
                    .multilineTextAlignment(.center)
            }
            .foregroundColor(.white)
            .padding()

            // Next
            Button {
                Task {try await viewModel.createUser()}
            } label: {
                Text("Verify email address")
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
        .background(Image(background.backgroundImages[background.authenticationBG])
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    CompleteSignUpView()
}
