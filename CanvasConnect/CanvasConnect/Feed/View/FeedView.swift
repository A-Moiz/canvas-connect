//
//  FeedView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

// MAIN
//import SwiftUI
//
//struct FeedView: View {
//    @StateObject var viewModel = FeedViewModel()
//    @State private var showOpenAppMenu = false
//    @State private var isUploadArtSelected = false
//    @StateObject var background = BackgroundSelectionViewModel()
//
//    var body: some View {
//        NavigationView {
//            ZStack(alignment: .bottomTrailing) {
//
//                Image(background.backgroundImages[background.appBG])
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .edgesIgnoringSafeArea(.all)
//
//                ScrollView {
//                    LazyVStack(spacing: 32) {
//                        ForEach(viewModel.posts) { post in
//                            FeedCell(post: post, viewModel: PostButtonsViewModel(post: post))
//                        }
//                    }
//                    .padding(.top, 8)
//                }
//                .navigationTitle("Feed")
//
//                VStack {
//                    Menu {
//                        Button("Upload Art") {
//                            isUploadArtSelected = true
//                        }
//
//                        Button("Create Art") {
//                            showOpenAppMenu.toggle()
//                        }
//                    } label: {
//                        Image(systemName: "plus.diamond.fill")
//                            .resizable()
//                            .frame(width: 50, height: 50)
//                            .padding()
//                            .foregroundColor(.orange)
//                    }
//                }
//                .actionSheet(isPresented: $showOpenAppMenu) {
//                    ActionSheet(
//                        title: Text("Open App"),
//                        buttons: [
//                            .default(Text("Open Pages")) {
//                                print("Opening Pages app")
//                            },
//                            .default(Text("Open Procreate")) {
//                                print("Opening Procreate")
//                            },
//                            .cancel()
//                        ]
//                    )
//                }
//            }
//            .background(
//                NavigationLink(
//                    destination: UploadPostView(),
//                    isActive: $isUploadArtSelected
//                ) { EmptyView()}.hidden()
//            )
//        }
//    }
//}

//#Preview {
//    FeedView()
//}
