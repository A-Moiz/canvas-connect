//
//  DisplayImageView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import SwiftUI
import Kingfisher

struct DisplayImageView: View {
    let post: Post
    @State var user: User
    @ObservedObject var viewModel: PostButtonsViewModel
    @StateObject var background = BackgroundSelectionViewModel()
    @State private var showDeleteAlert = false
    @State private var relaunch = false
    @StateObject var frame = ImageFrames()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 12) {
                
                HStack {
                    Spacer()
                    
                    Text("Posted \(formattedTimestamp())")
                        .font(.caption)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    // Delete post Button
                    if post.ownerUid.elementsEqual(user.id) {
                        Button(action: {
                            showDeleteAlert.toggle()
                        }) {
                            Image(systemName: "x.circle")
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                
                if post.hasWatermark ?? false {
                    if post.isSpoiler ?? false {
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: frame.postWidth, height: frame.postHeight)
                            .clipped()
                            .overlay(WatermarkTextView(user: user))
                            .blur(radius: viewModel.isBlurApplied ? 30 : 0)
                    } else {
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: frame.postWidth, height: frame.postHeight)
                            .clipped()
                            .overlay(WatermarkTextView(user: user))
                    }
                } else if post.isSpoiler ?? false {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: frame.postWidth, height: frame.postHeight)
                        .clipped()
                        .blur(radius: viewModel.isBlurApplied ? 30 : 0)
                } else {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: frame.postWidth, height: frame.postHeight)
                        .clipped()
                }
                
                VStack(alignment: .center, spacing: 8) {
                    Text("By \(user.username)")
                        .font(.title2)
                        .bold()
                    
                    Text(post.caption)
                        .font(.title2)
                    
                    Divider()
                    
                    PostButtonsView(post: post, viewModel: viewModel)
                    
                    Text("Likes: \(post.likes)")
                        .font(.footnote)
                }
                .padding()
            }
            .padding()
        }
        .background(Image(background.backgroundImages[background.appBG])
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
        )
        .navigationBarTitle(Text("Post Details"), displayMode: .inline)
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Delete post"),
                message: Text("Are you sure you want to delete this post? This action cannot be undon."),
                primaryButton: .destructive(Text("Delete")) {
                    Task {
                        do {
                            try await viewModel.deletePost()
                            user.postCount = (user.postCount ?? 0) - 1
                            relaunch = true
                        } catch {
                            relaunch = false
                            print("Error deleting post:", error.localizedDescription)
                        }
                    }
                },
                secondaryButton: .cancel()
            )
        }
        .sheet(isPresented: $relaunch) {
            EmptyView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController = UIHostingController(rootView: ContentView())
                            scene.windows.first?.makeKeyAndVisible()
                        }
                    }
                }
        }
    }
    
    private func formattedTimestamp() -> String {
        let timestamp = post.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let formattedDate = dateFormatter.string(from: timestamp)
        return formattedDate
    }
}

//#Preview {
//    DisplayImageView()
//}
