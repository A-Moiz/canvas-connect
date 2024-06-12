//
//  NoteCommentView.swift
//  CanvasConnect
//
//  Created by Abdul on 29/04/2024.
//

import SwiftUI
import Firebase

struct NoteCommentsView: View {
    @StateObject var viewModel = NoteCommentViewModel()
    @StateObject var background = BackgroundSelectionViewModel()
    @State private var commentText: String = ""
    @State private var comments: [Comment] = []
    @State private var commentPosted: Bool = false
    let note: Note
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.commentDetails.sorted(by: { $0.key < $1.key }), id: \.key) { commentDetail in
                        let (commentID, (comment, username, profileImageUrl, timestamp)) = commentDetail
                        NoteCommentView(comment: comment, username: username, profileImageUrl: profileImageUrl, note: note, timestamp: timestamp)
                            .padding()
                    }
                }
            }
            .onAppear(perform: {
                viewModel.fetchComments(for: note)
            })
            .navigationTitle("Comments")
            .background(Image(background.backgroundImages[background.commentBG])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            )
            .actionSheet(isPresented: $commentPosted) {
                ActionSheet(
                    title: Text("Confirmation"),
                    message: Text("Comment has been posted"),
                    buttons: [
                        .default(Text("OK"))
                    ]
                )
            }
            
            HStack {
                TextField("Comment...", text: $commentText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {
                    viewModel.addComment(commentText: commentText, note: note)
                    commentPosted.toggle()
                    commentText = ""
                }, label: {
                    Image(systemName: "paperplane")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.blue)
                        .padding()
                })
            }
        }
    }
}

//#Preview {
//    NoteCommentView()
//}
