//
//  MainTabView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import SwiftUI

struct MainTabView: View {
    let user: User
    @State private var selectedIndex = 0
    @ObservedObject var editProfileViewModel: EditProfileViewModel
    @StateObject var background = BackgroundSelectionViewModel()
    
    init(user: User) {
        self.user = user
        self.editProfileViewModel = EditProfileViewModel(user: user)
    }
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            // FeedView()
            SocialFeedView(user: user)
                .environmentObject(background)
                .tabItem {
                    Label("Home", systemImage: selectedIndex == 0 ? "house.fill" : "house")
                }
                .tag(0)
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: selectedIndex == 1 ? "magnifyingglass.circle.fill" : "magnifyingglass.circle")
                }
                .tag(1)
            
            CurrentProfileView(user: user)
                .tabItem {
                    Label("Profile", systemImage: selectedIndex == 2 ? "person.fill" : "person")
                }
                .tag(2)
        }
        .accentColor(.black)
    }
}

//#Preview {
//    MainTabView()
//}
