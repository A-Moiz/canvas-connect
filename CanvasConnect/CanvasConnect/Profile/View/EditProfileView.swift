//
//  EditProfileView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EditProfileViewModel
    @StateObject var background = BackgroundSelectionViewModel()
    let user: User
    var onProfileUpdated: (() -> Void)?
    
    init(user: User, viewModel: EditProfileViewModel, onProfileUpdated: (() -> Void)? = nil) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.onProfileUpdated = onProfileUpdated
    }
    
    var body: some View {
        ScrollView {
            VStack {
                // Toolbar
                VStack {
                    HStack {
                        Button("Cancel") {
                            dismiss()
                        }
                        .foregroundColor(.black)
                        
                        Spacer()
                        
                        Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Button {
                            Task {
                                do {
                                    try await viewModel.updateUserData()
                                    dismiss()
                                    onProfileUpdated?()
                                } catch {
                                    print("Error updating user data: \(error.localizedDescription)")
                                }
                            }
                        } label: {
                            Text("Done")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)
                    
                    Divider()
                }
                
                // Edit banner + profile pic
                VStack {
                    // Banner
                    PhotosPicker(selection: $viewModel.selectedBannerImage) {
                        VStack {
                            if let image = viewModel.bannerImage {
                                image
                                    .resizable()
                                    .foregroundColor(.white)
                                    .background(.gray)
                                    .clipShape(Rectangle())
                                    .frame(width: 400, height: 200)
                            } else {
                                BannerImageView(user: viewModel.user)
                            }
                            
                            Text("Edit Banner Image")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.vertical, 8)
                    
                    // Profile Picture
                    PhotosPicker(selection: $viewModel.selectedProfileImage) {
                        VStack {
                            if let image = viewModel.profileImage {
                                image
                                    .resizable()
                                    .foregroundColor(.white)
                                    .background(.gray)
                                    .clipShape(Circle())
                                    .frame(width: 80, height: 80)
                            } else {
                                CircularProfileImageView(user: viewModel.user)
                                    .frame(width: 80, height: 80)
                            }
                            
                            Text("Edit Profile Picture")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                Divider()
                
                // Edit profile info
                VStack {
                    // Name
                    HStack {
                        Text("Full name")
                            .padding(.leading, 8)
                            .frame(width: 100, alignment: .leading)
                        
                        VStack {
                            TextField("Enter your name...", text: $viewModel.fullname)
                            
                            Divider()
                        }
                    }
                    .font(.subheadline)
                    .frame(height: 50)
                    
                    // Bio
                    HStack {
                        Text("Bio")
                            .padding(.leading, 8)
                            .frame(width: 100, alignment: .leading)
                        
                        VStack {
                            TextEditor(text: $viewModel.bio)
                                .frame(height: 60)
                                    
                            Divider()
                        }
                    }
                    .font(.subheadline)
                    .frame(height: 36)
                    
                    // Receive commissions
                    HStack {
                        Toggle("Receive art requests via email?", isOn: $viewModel.receiveEmail)
                            .padding(.leading, 8)
                            .padding(.top, 8)
                            .frame(alignment: .leading)
                        
                        Spacer()
                    }
                    
                    // Links
                    VStack(alignment: .leading, spacing: 4) {
                        // External link
                        HStack {
                            Image(systemName: "link")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(.leading, 12)
                                .frame(width: 100, alignment: .leading)
                            
                            TextField("Enter social link here...", text: $viewModel.link)
                        }
                        .font(.subheadline)
                        .frame(height: 50)
                        
                        // Instagram link
                        HStack {
                            Image("instagram-logo")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.leading, 12)
                                .frame(width: 100, alignment: .leading)
                            
                            TextField("Link to Instagram profile...", text: $viewModel.instagramLink)
                        }
                        .font(.subheadline)
                        .frame(height: 50)
                        
                        // Facebook link
                        HStack {
                            Image("facebook-logo")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .padding(.leading, 10)
                                .frame(width: 100, alignment: .leading)
                            
                            TextField("Link to Facebook profile...", text: $viewModel.facebookLink)
                        }
                        .font(.subheadline)
                        .frame(height: 50)
                        
                        // Discord link
                        HStack {
                            Image("discord-logo")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.leading, 12)
                                .frame(width: 100, alignment: .leading)
                            
                            TextField("Link to Discord server...", text: $viewModel.discordLink)
                        }
                        .font(.subheadline)
                        .frame(height: 50)
                        
                        // YouTube link
                        HStack {
                            Image("youtube-logo")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.leading, 12)
                                .frame(width: 100, alignment: .leading)
                            
                            TextField("Link to YouTube channel...", text: $viewModel.youtubeLink)
                        }
                        .font(.subheadline)
                        .frame(height: 50)
                        
                        // Twitter link
                        HStack {
                            Image("x-logo")
                                .resizable()
                                .frame(width: 55, height: 55)
                                .frame(width: 100, alignment: .leading)
                            
                            TextField("Link to Twitter profile...", text: $viewModel.twitterLink)
                        }
                        .font(.subheadline)
                        .frame(height: 50)
                        
                        // Patreon link
                        HStack {
                            Image("patreon-logo")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.leading, 12)
                                .frame(width: 100, alignment: .leading)
                            
                            TextField("Link to Patreon profile...", text: $viewModel.patreonLink)
                        }
                        .font(.subheadline)
                        .frame(height: 50)
                    }
                }
                .padding(.horizontal, 4)
            }
        }
        .background(Image(background.backgroundImages[background.appBG])
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all))
    }
}

//#Preview {
//    EditProfileView()
//}
