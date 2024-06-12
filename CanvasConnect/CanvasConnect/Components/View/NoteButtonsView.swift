//
//  NoteButtonsView.swift
//  CanvasConnect
//
//  Created by Abdul on 29/04/2024.
//

import SwiftUI

struct NoteButtonsView: View {
    let note: Note
    @ObservedObject var viewModel: NoteButtonsViewModel
    @State private var showComments = false
    
    init(note: Note, viewModel: NoteButtonsViewModel) {
        self.note = note
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(spacing: 24) {
            // Like Button
            Button(action: {
                viewModel.note.isLiked ?? false ? viewModel.unlikeNote() : viewModel.likeNote()
            }) {
                Image(systemName: viewModel.note.isLiked ?? false ? "heart.fill" : "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(viewModel.note.isLiked ?? false ? .red : .blue)
            }
            
            // Comment Button
            if note.canComment ?? false {
                Button(action: {
                    showComments.toggle()
                }, label: {
                    Image(systemName: "message")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.blue)
                })
            }
        }
        .sheet(isPresented: $showComments) {
            NoteCommentsView(note: note)
        }
    }
}

//#Preview {
//    NoteButtonsView()
//}
