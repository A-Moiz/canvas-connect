//
//  ProfileView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import SwiftUI
import MessageUI

struct ProfileView: View {
    let user: User
    @StateObject var viewModel: EditProfileViewModel
    @ObservedObject var followModel: FollowViewModel
    @State private var showEditProfile = false
    @State private var showLikedPosts = false
    @StateObject var background = BackgroundSelectionViewModel()
    @State private var showEmailOptions = false
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
        self._followModel = ObservedObject(wrappedValue: FollowViewModel(user: user, viewedUser: user))
    }
    
    var body: some View {
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
            .ignoresSafeArea()
        )
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    
                    // View liked posts
                    Button(action: {
                        showLikedPosts.toggle()
                    }) {
                        Label("View Liked Posts", systemImage: "heart")
                    }
                    
                    // Email commission
                    if user.receiveEmail ?? false {
                        Button(action: {
                            // Action sheet
                            showEmailOptions = true
                        }, label: {
                            Label("Email this artist", systemImage: "envelope")
                        })
                    }
                    
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.black)
                }
            }
        }
        .sheet(isPresented: $showLikedPosts) {
            LikedPostsView(user: user)
        }
        .actionSheet(isPresented: $showEmailOptions) {
            ActionSheet(title: Text("Choose Email Client"), buttons: [
                .default(Text("Open Gmail"), action: {
                    openGmail()
                }),
                .default(Text("Open Outlook"), action: {
                    openOutlook()
                }),
                .default(Text("Open Mail"), action: {
                    openMail()
                }),
                .default(Text("Email Artist"), action: {
                    sendEmail()
                }),
                .cancel()
            ])
        }
    }
    
    func openGmail() {
        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id422689480") else { return }
        
        UIApplication.shared.open(appStoreURL, options: [:]) { success in
            if success {
                print("Opened Gmail successfully")
            } else {
                print("Failed to open Gmail")
            }
        }
    }
    
    func openOutlook() {
        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id951937596") else { return }
        
        UIApplication.shared.open(appStoreURL, options: [:]) { success in
            if success {
                print("Opened Outlook successfully")
            } else {
                print("Failed to open Outlook")
            }
        }
    }
    
    func openMail() {
        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id1108187098") else { return }
        
        UIApplication.shared.open(appStoreURL, options: [:]) { success in
            if success {
                print("Opened Mail successfully")
            } else {
                print("Failed to open Mail")
            }
        }
    }
    
    func sendEmail() {
        let recipientEmail = user.email
        let subject = "Artwork Commission"
        
        if let url = URL(string: "mailto:\(recipientEmail)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") {
            UIApplication.shared.open(url)
        }
    }
}

//#Preview {
//    ProfileView()
//}
