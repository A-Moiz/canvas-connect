//
//  CommentView.swift
//  CanvasConnect
//
//  Created by Abdul on 15/04/2024.
//

import SwiftUI
import Kingfisher
import Firebase

struct CommentView: View {
    @StateObject var viewModel = CommentsViewModel()
    let comment: String
    let username: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let post: Post
    @StateObject var frame = ImageFrames()
    
    init(comment: String, username: String, profileImageUrl: String, post: Post, timestamp: Timestamp) {
        self.comment = comment
        self.username = username
        self.profileImageUrl = profileImageUrl
        self.post = post
        self.timestamp = timestamp
    }
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 10) {
            // Profile Image
            if profileImageUrl != "" {
                KFImage(URL(string: profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: frame.profileWidth, height: frame.profileHeight)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .clipShape(Circle())
                    .foregroundColor(Color(.systemGray4))
                    .frame(width: frame.profileWidth, height: frame.profileHeight)
            }
            
            HStack {
                // Username + Comment
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(username)")
                        .font(.headline)
                    
                    Text("\(comment)")
                        .lineLimit(nil)
                }
                .padding(8)
                .background(Color.green.opacity(0.7))
                .cornerRadius(10)
            }
            
//            VStack {
//                Text("\(formattedTimestamp())")
//                Spacer()
//            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
//    private func formattedTimestamp() -> String {
//        let timestamp = post.timestamp.dateValue()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yyyy 'at' HH:mm"
//        let formattedDate = dateFormatter.string(from: timestamp)
//        return formattedDate
//    }
}

//#Preview {
//    CommentView(comment: "", post: Post.MOCK_POSTS[0])
//}
