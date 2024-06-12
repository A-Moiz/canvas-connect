//
//  FeedCell.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

//import SwiftUI
//import Kingfisher
//struct FeedCell: View {
//    
//    let post: Post
//    @State private var isLiked: Bool = false
//    @ObservedObject var viewModel: PostButtonsViewModel
//    @StateObject var frame = ImageFrames()
//    
//    init(post: Post) {
//        self.post = post
//        self.viewModel = PostButtonsViewModel(post: post)
//        self.viewModel.isBlurApplied = post.isSpoiler ?? false
//    }
//    
//    var body: some View {
//        
//        VStack(spacing: 12) {
//            
//            HStack() {
//                Spacer()
//                if let user = post.user {
//                    CircularProfileImageView(user: user)
//                        .frame(width: frame.profileWidth, height: frame.profileHeight)
//                        .padding(.trailing, 8)
//                    
//                    Text(user.username)
//                        .font(.headline)
//                        .fontWeight(.semibold)
//                    
//                    Spacer()
//                }
//                
//                Text("Posted \(formattedTimestamp())")
//                    .font(.caption)
//                    .foregroundColor(.black)
//                Spacer()
//            }
//            .padding()
//            
//            if let user = post.user {
//                if post.hasWatermark ?? false && post.isSpoiler ?? false {
//                    KFImage(URL(string: post.imageUrl))
//                        .resizable()
//                        .frame(width: frame.postWidth, height: frame.postHeight)
//                        .cornerRadius(frame.postRadius)
//                        //.scaledToFill()
//                        //.frame(height: postHeight)
//                        //.frame(height: 350)
//                        //.cornerRadius(12)
//                        .clipped()
//                        .overlay(WatermarkTextView(user: user))
//                        .blur(radius: viewModel.isBlurApplied ? 30 : 0)
//                } else if post.hasWatermark ?? false {
//                    KFImage(URL(string: post.imageUrl))
//                        .resizable()
//                        //.scaledToFill()
//                        .frame(width: frame.postWidth, height: frame.postHeight)
//                        .cornerRadius(frame.postRadius)
//                        //.cornerRadius(12)
//                        .clipped()
//                        .overlay(WatermarkTextView(user: user))
//                } else if post.isSpoiler ?? false {
//                    KFImage(URL(string: post.imageUrl))
//                        .resizable()
//                        //.scaledToFill()
//                        .frame(width: frame.postWidth, height: frame.postHeight)
//                        .cornerRadius(frame.postRadius)
//                        //.cornerRadius(12)
//                        .clipped()
//                        .blur(radius: viewModel.isBlurApplied ? 30 : 0)
//                } else {
//                    KFImage(URL(string: post.imageUrl))
//                        .resizable()
//                        //.scaledToFill()
//                        .frame(width: frame.postWidth, height: frame.postHeight)
//                        .cornerRadius(frame.postRadius)
//                        //.cornerRadius(12)
//                        .clipped()
//                }
//            }
//            
//            PostButtonsView(post: post, viewModel: viewModel)
//            
//            Text("\(post.likes) likes")
//                .font(.caption)
//            
//            Text(post.caption)
//                .font(.body)
//        }
//        .padding()
//    }
//    
//    private func formattedTimestamp() -> String {
//        let timestamp = post.timestamp.dateValue()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd MMMM yyyy"
//        let formattedDate = dateFormatter.string(from: timestamp)
//        return formattedDate
//    }
//}

// TESTING:
import SwiftUI
import Kingfisher

struct FeedCell: View {
    
    let post: Post
    @State private var isLiked: Bool = false
    @ObservedObject var viewModel: PostButtonsViewModel
    @StateObject var frame = ImageFrames()
    
    init(post: Post) {
        self.post = post
        self.viewModel = PostButtonsViewModel(post: post)
        self.viewModel.isBlurApplied = post.isSpoiler ?? false
    }
    
    var body: some View {
        
        VStack(spacing: 12) {
            
            HStack() {
                Spacer()
                if let user = post.user {
                    NavigationLink(destination: ProfileView(user: user)) {
                        CircularProfileImageView(user: user)
                            .frame(width: frame.profileWidth, height: frame.profileHeight)
                            .padding(.trailing, 8)
                        
                        Text(user.username)
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                }
                
                Spacer()
                
                Text("Posted \(formattedTimestamp())")
                    .font(.caption)
                    .foregroundColor(.black)
                Spacer()
            }
            .padding()
            
            if let user = post.user {
                if post.hasWatermark ?? false && post.isSpoiler ?? false {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .frame(width: frame.postWidth, height: frame.postHeight)
                        .cornerRadius(frame.postRadius)
                        .clipped()
                        .overlay(WatermarkTextView(user: user))
                        .blur(radius: viewModel.isBlurApplied ? 30 : 0)
                        .shadow(radius: 20)
                } else if post.hasWatermark ?? false {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .frame(width: frame.postWidth, height: frame.postHeight)
                        .cornerRadius(frame.postRadius)
                        .clipped()
                        .overlay(WatermarkTextView(user: user))
                        .shadow(radius: 20)
                } else if post.isSpoiler ?? false {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .frame(width: frame.postWidth, height: frame.postHeight)
                        .cornerRadius(frame.postRadius)
                        .clipped()
                        .blur(radius: viewModel.isBlurApplied ? 30 : 0)
                        .shadow(radius: 20)
                } else {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .frame(width: frame.postWidth, height: frame.postHeight)
                        .cornerRadius(frame.postRadius)
                        .clipped()
                        .shadow(radius: 20)
                }
            }
            
            PostButtonsView(post: post, viewModel: viewModel)
            
            Text("\(post.likes) likes")
                .font(.caption)
            
            Text(post.caption)
                .font(.body)
        }
        .padding()
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
//    FeedCell()
//}
