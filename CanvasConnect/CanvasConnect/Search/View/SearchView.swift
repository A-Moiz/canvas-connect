//
//  SearchView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject var viewModel = SearchViewModel()
    @StateObject var background = BackgroundSelectionViewModel()
    @StateObject var frame = ImageFrames()
    
    var filteredUsers: [User] {
        guard !searchText.isEmpty else {
            return viewModel.users
        }
        return viewModel.users.filter { user in
            let usernameMatch = user.username.lowercased().contains(searchText.lowercased())
            let nameMatch = user.fullname?.lowercased().contains(searchText.lowercased()) ?? false
            return usernameMatch || nameMatch
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(filteredUsers) { user in
                        NavigationLink(destination: ProfileView(user: user)) {
                            HStack {
                                CircularProfileImageView(user: user)
                                    .frame(width: frame.profileWidth, height: frame.profileHeight)
                                
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
                .searchable(text: $searchText, prompt: "Search...")
            }
            .navigationTitle("Search")
            .background(Image(background.backgroundImages[background.appBG])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all))
        }
    }
}

//#Preview {
//    SearchView()
//}
