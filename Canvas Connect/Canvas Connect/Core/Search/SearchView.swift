//
//  SearchView.swift
//  Canvas Connect
//
//  Created by Abdul on 13/01/2024.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(User.MOCK_USERS) {user in
                        NavigationLink(value: user) {
                            HStack {
                                Image(user.profileImageUrl ?? "")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                
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
                .navigationDestination(for: User.self, destination: { user in
                    ProfileView(user: user)
                })
                .padding(.top, 8)
                .searchable(text: $searchText, prompt: "Search...")
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SearchView()
}