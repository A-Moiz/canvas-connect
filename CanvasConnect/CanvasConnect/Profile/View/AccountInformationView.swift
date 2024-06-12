//
//  AccountInformationView.swift
//  CanvasConnect
//
//  Created by Abdul on 03/05/2024.
//

import SwiftUI

struct AccountInformationView: View {
    let user: User
    @StateObject var background = BackgroundSelectionViewModel()
    @StateObject var frame = ImageFrames()
    @State private var comment = ""
    @State private var error = false
    @ObservedObject var viewModel: EditProfileViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                // Image
                CircularProfileImageView(user: viewModel.user)
                    .frame(width: frame.PfpW, height: frame.PfpH)
                    .padding()
                
                // Name
                Text(viewModel.user.fullname ?? "")
                    .font(.title)
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.black)
                        .opacity(0.6)

                    Divider()
                }
                
                // Details
                VStack {
                    // Email
                    HStack {
                        Text("Email:")
                            .bold()
                        
                        Spacer()
                        
                        Text(user.email)
                    }
                    .padding()
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.black)
                            .opacity(0.6)

                        Divider()
                    }
                    
                    // Username
                    HStack {
                        Text("Username:")
                            .bold()
                        
                        Spacer()
                        
                        Text(user.username)
                    }
                    .padding()
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.black)
                            .opacity(0.6)

                        Divider()
                    }
                    
                    // Bio
                    HStack {
                        Text("Bio:")
                            .bold()
                        
                        Spacer()
                        
                        Text(viewModel.user.bio ?? "")
                    }
                    .padding()
                }
            }
            .navigationTitle("Account details")
            .background(Image(background.backgroundImages[background.appBG])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            )
        }
    }
}

//#Preview {
//    AccountInformationView(user: User.MOCK_USERS[0])
//}
