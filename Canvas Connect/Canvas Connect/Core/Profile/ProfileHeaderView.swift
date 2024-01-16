//
//  ProfileHeaderView.swift
//  Canvas Connect
//
//  Created by Abdul on 14/01/2024.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    let user: User
    
    var body: some View {
        // Header
        VStack(spacing: 10) {
            // Banner
            Image(user.bannerImageUrl ?? "")
                .resizable()
                .scaledToFill()
                .frame(width: 400, height: 200)
                .clipShape(Rectangle())
            
            // Image and stats
            HStack {
                Image(user.profileImageUrl ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                
                Spacer()
                
                HStack(spacing: 8) {
                    // Posts
                    UserStatView(value: 3, title: "Posts")
                    
                    // Followers
                    UserStatView(value: 12, title: "Followers")
                    
                    // Following
                    UserStatView(value: 24, title: "Following")
                }
            }
            .padding(.horizontal)
            
            // Name + Bio
            VStack(alignment: .leading, spacing: 4) {
                if let fullname = user.fullname {
                    Text(fullname)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                
                if let bio = user.bio {
                    Text(bio)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            // Button(s)
            Button {
                print("Edit Profile")
            } label: {
                Text("Edit Profile")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .foregroundColor(.black)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 1))
            }
            
            
            Divider()
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USERS[0])
}
