//
//  NoteCommentView.swift
//  CanvasConnect
//
//  Created by Abdul on 29/04/2024.
//

import SwiftUI
import Kingfisher
import Firebase

struct NoteCommentView: View {
    @StateObject var viewModel = NoteCommentViewModel()
    let comment: String
    let username: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let note: Note
    @StateObject var frame = ImageFrames()
    
    init(comment: String, username: String, profileImageUrl: String, note: Note, timestamp: Timestamp) {
        self.comment = comment
        self.username = username
        self.profileImageUrl = profileImageUrl
        self.note = note
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
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    NoteCommentView()
//}
