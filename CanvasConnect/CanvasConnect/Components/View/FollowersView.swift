//
//  FollowersView.swift
//  CanvasConnect
//
//  Created by Abdul on 03/04/2024.
//

import SwiftUI

struct FollowersView: View {
    @StateObject var viewModel = DisplayFollowViewModel()
    @StateObject var background = BackgroundSelectionViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.followers) { follower in
                        NavigationLink(destination: ProfileView(user: follower)) {
                            HStack {
                                CircularProfileImageView(user: follower)
                                    .frame(width: 40, height: 40)
                                
                                VStack(alignment: .leading) {
                                    Text(follower.username)
                                        .fontWeight(.semibold)
                                    
                                    if let fullname = follower.fullname {
                                        Text(fullname)
                                    }
                                }
                                .font(.footnote)
                                
                                Spacer()
                            }
                            .foregroundColor(.black)
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.top, 8)
            }
            .navigationTitle("Followers")
            .background(Image(background.backgroundImages[background.appBG])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all))
        }
        .onAppear {
            viewModel.fetchFollowedUsers()
        }
    }
}

#Preview {
    FollowersView()
}
