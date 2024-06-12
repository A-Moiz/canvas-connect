//
//  ProfileHeaderView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import SwiftUI

struct ProfileHeaderView: View {
    @State private var isFollowing = false
    @State private var followCount: Int = 0
    @State private var followersCount: Int = 0
    @ObservedObject var viewModel: EditProfileViewModel
    @ObservedObject var followModel: FollowViewModel
    @Binding var showEditProfile: Bool
    let user: User
    @StateObject var frame = ImageFrames()
    
    init(viewModel: EditProfileViewModel, followModel: FollowViewModel, showEditProfile: Binding<Bool>, user: User) {
        self.viewModel = viewModel
        self.followModel = followModel
        self._showEditProfile = showEditProfile
        self.user = user
    }
    
    var body: some View {
        VStack(spacing: 10) {
            
            VStack {
                // Banner
                BannerImageView(user: viewModel.user)
                
                VStack {
                    HStack {
                        // Image
                        CircularProfileImageView(user: viewModel.user)
                            .frame(width: frame.currentPfpW, height: frame.currentPfpH)
                        
                        VStack {
                            // Username
                            Text(user.username)
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            // Name
                            if let fullname = viewModel.user.fullname {
                                Text(fullname)
                                    .font(.title2)
                            }
                        }
                    }
                    .padding(.top)
                    
                    // Stats
                    HStack(spacing: 8) {
                        // Posts
                        VStack {
                            if let postCount = user.postCount {
                                Text("\(postCount)")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                            } else {
                                Text("0")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                            }
                            Text("Posts")
                                .font(.footnote)
                        }
                        .frame(width: 76)
                        
                        // Notes
                        VStack {
                            if let notesCount = user.noteCount {
                                Text("\(notesCount)")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                            } else {
                                Text("0")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                            }
                            Text("Notes")
                                .font(.footnote)
                        }
                        .frame(width: 76)
                        
                        // Followers
                        VStack {
                            Text("\(followersCount)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            Text("Followers")
                                .font(.footnote)
                        }
                        .frame(width: 76)
                        
                        // Following
                        VStack {
                            Text("\(followCount)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            Text("Following")
                                .font(.footnote)
                        }
                        .frame(width: 76)
                    }
                    .padding(.top)
                }
            }
            
            // Bio + Links
            VStack(spacing: 8) {
                // Bio
                if let bio = viewModel.user.bio {
                    Text(bio)
                        .font(.footnote)
                        .padding()
                }
                
                Divider()
                
                // Social Links
                HStack(spacing: 20) {
                    
                    // External Link
                    if !viewModel.link.isEmpty {
                        Button(action: {
                            openURL(viewModel.link)
                        }) {
                            Image(systemName: "link")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    // Instagram Link
                    if !viewModel.instagramLink.isEmpty {
                        Button(action: {
                            openURL(viewModel.instagramLink)
                        }) {
                            Image("instagram-logo")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                    
                    // Facebook Link
                    if !viewModel.facebookLink.isEmpty {
                        Button(action: {
                            openURL(viewModel.facebookLink)
                        }) {
                            Image("facebook-logo")
                                .resizable()
                                .frame(width: 35, height: 35)
                        }
                    }
                    
                    // Discord Link
                    if !viewModel.discordLink.isEmpty {
                        Button(action: {
                            openURL(viewModel.discordLink)
                        }) {
                            Image("discord-logo")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                    
                    // YouTube Link
                    if !viewModel.youtubeLink.isEmpty {
                        Button(action: {
                            openURL(viewModel.youtubeLink)
                        }) {
                            Image("youtube-logo")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                    
                    // Twitter Link
                    if !viewModel.twitterLink.isEmpty {
                        Button(action: {
                            openURL(viewModel.twitterLink)
                        }) {
                            Image("x-logo")
                                .resizable()
                                .frame(width: 55, height: 55)
                        }
                    }
                    
                    // Patreon Link
                    if !viewModel.patreonLink.isEmpty {
                        Button(action: {
                            openURL(viewModel.patreonLink)
                        }) {
                            Image("patreon-logo")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            // Edit Profile/Follow Button
            Button {
                if viewModel.user.isCurrentUser {
                    showEditProfile.toggle()
                } else {
                    toggleFollow()
                    print("Follow user...")
                }
            } label: {
                Text(buttonText)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .background(viewModel.user.isCurrentUser ? .white : Color(.systemBlue))
                    .foregroundColor(viewModel.user.isCurrentUser ? .black : .white)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(viewModel.user.isCurrentUser ? .gray : .clear, lineWidth: 1)
                    )
            }
        }
        .onAppear(perform: {
            fetchFollowStatus()
            followModel.getUserFollowCount { count in
                followCount = count
            }
            followModel.getFollowedUserCount { followers in
                followersCount = followers
            }
        })
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: viewModel.user, viewModel: viewModel)
        }
    }
    
    func openURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    private var buttonText: String {
        if viewModel.user.isCurrentUser {
            return "Edit Profile"
        } else {
            return isFollowing ? "Following" : "Follow"
        }
    }
    
    private func toggleFollow() {
        if isFollowing {
            unfollowUser()
        } else {
            followUser()
        }
    }
    
    private func followUser() {
        isFollowing = true
        followModel.followUser(user.id) {
            print("Follow success")
        }
    }
    
    private func unfollowUser() {
        isFollowing = false
        followModel.unfollowUser(user.id) {
            print("Unfollow success")
        }
    }
    
    func fetchFollowStatus() {
        followModel.isFollowingUser(user.id) { isFollowing in
            self.isFollowing = isFollowing
            print(isFollowing)
        }
    }
}

//#Preview {
//    ProfileHeaderView()
//}
