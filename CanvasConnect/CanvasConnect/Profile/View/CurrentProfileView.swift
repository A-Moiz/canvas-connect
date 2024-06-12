//
//  CurrentProfileView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import SwiftUI

struct CurrentProfileView: View {
    let user: User
    @StateObject var viewModel: EditProfileViewModel
    @StateObject var followModel: FollowViewModel
    @StateObject var background = BackgroundSelectionViewModel()
    @State private var profileUpdated = false
    @State private var showEditProfile = false
    @State private var showLikedPosts = false
    @State private var showSavedPosts = false
    @State private var showFollowers = false
    @State private var showFollowing = false
    @State private var showContact = false
    @State private var showDetails = false
    //@State private var showBackground = false
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
        self._followModel = StateObject(wrappedValue: FollowViewModel(user: user, viewedUser: user))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                // Header
                ProfileHeaderView(viewModel: viewModel, followModel: followModel, showEditProfile: $showEditProfile, user: user)
                
                // Posts
                PostGridView(user: user)
                
                // Notes
                NotesView(user: user)
            }
            .background(Image(background.backgroundImages[background.appBG])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all))
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
//                        // Select Background
//                        Button(action: {
//                            showBackground.toggle()
//                        }) {
//                            Label("Change Background", systemImage: "iphone.gen3")
//                        }
                        
                        // Followers
                        Button(action: {
                            showFollowers.toggle()
                        }) {
                            Label("View Followers", systemImage: "person")
                        }
                        
                        // Following
                        Button(action: {
                            showFollowing.toggle()
                        }) {
                            Label("View Following", systemImage: "person")
                        }
                        
                        // View liked posts
                        Button(action: {
                            showLikedPosts.toggle()
                        }) {
                            Label("View Liked Posts", systemImage: "heart")
                        }
                        
                        // View saved posts
                        Button(action: {
                            showSavedPosts.toggle()
                        }) {
                            Label("View Saved Posts", systemImage: "bookmark")
                        }
                        
                        // Change password
                        Button(action: {
                            //AuthService.shared.sendPasswordResetEmail(for: user.email)
                            AuthService.shared.sendPasswordResetEmail(for: user.email) { error in
                                if let error = error {
                                    print("Error sending password reset email: \(error.localizedDescription)")
                                } else {
                                    print("Password reset email sent successfully")
                                }
                            }
                            AuthService.shared.signOut()
                        }) {
                            Label("Change password", systemImage: "person.badge.key")
                        }
                        
                        // View account details
                        Button(action: {
                            showDetails.toggle()
                        }) {
                            Label("View account details", systemImage: "person.text.rectangle")
                        }
                        
                        // Contact us
                        Button(action: {
                            showContact.toggle()
                        }) {
                            Label("Contact us", systemImage: "square.and.pencil")
                        }
                        
                        // Sign out
                        Button(action: {
                            AuthService.shared.signOut()
                        }) {
                            Label("Sign out", systemImage: "person.crop.circle.badge.xmark")
                        }
                        
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                    }
                }
            }
            .fullScreenCover(isPresented: $showEditProfile) {
                EditProfileView(user: user, viewModel: viewModel, onProfileUpdated: {
                    profileUpdated.toggle()
                })
            }
            .sheet(isPresented: $showLikedPosts) {
                LikedPostsView(user: user)
            }
            .sheet(isPresented: $showSavedPosts) {
                SavedPostsView(user: user)
            }
            .sheet(isPresented: $showFollowers) {
                FollowersView()
            }
            .sheet(isPresented: $showFollowing) {
                FollowingView()
            }
            .sheet(isPresented: $showContact) {
                ContactView(user: user, viewModel: viewModel)
            }
            .sheet(isPresented: $showDetails) {
                AccountInformationView(user: user, viewModel: viewModel)
            }
//            .sheet(isPresented: $showBackground) {
//                BackgroundSelectView()
//                    .environmentObject(background)
//            }
            .onAppear {
                if profileUpdated {
                    profileUpdated = false
                }
            }
        }
    }
}

//#Preview {
//    CurrentProfileView()
//}
