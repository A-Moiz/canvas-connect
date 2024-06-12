//
//  FollowingView.swift
//  CanvasConnect
//
//  Created by Abdul on 03/04/2024.
//

import SwiftUI

struct  FollowingView: View {
    @StateObject var viewModel = DisplayFollowViewModel()
    @StateObject var background = BackgroundSelectionViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.following) { user in
                        NavigationLink(destination: ProfileView(user: user)) {
                            HStack {
                                CircularProfileImageView(user: user)
                                    .frame(width: 40, height: 40)
                                
                                VStack(alignment: .leading) {
                                    Text(user.username)
                                        .fontWeight(.semibold)
                                    
                                    if let fullname = user.fullname {
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
            .navigationTitle("Following")
            .background(Image(background.backgroundImages[background.appBG])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all))
        }
        .onAppear {
            viewModel.fetchFollowingUsers()
        }
    }
}

#Preview {
    FollowingView()
}
