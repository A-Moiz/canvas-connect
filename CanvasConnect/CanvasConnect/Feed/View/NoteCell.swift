//
//  NoteCell.swift
//  CanvasConnect
//
//  Created by Abdul on 29/04/2024.
//

import SwiftUI

struct NoteCell: View {
    let note: Note
    @State private var isLiked: Bool = false
    @ObservedObject var viewModel: NoteButtonsViewModel
    @StateObject var frame = ImageFrames()
    
    init(note: Note) {
        self.note = note
        self.viewModel = NoteButtonsViewModel(note: note)
    }
    
    var body: some View {
        HStack {
            if let user = note.user {
                NavigationLink(destination: ProfileView(user: user)) {
                    CircularProfileImageView(user: user)
                        .frame(width: frame.profileWidth, height: frame.profileHeight)
                }
                
                VStack {
                    HStack(spacing: 10) {
                        Text(user.username)
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Text("Posted \(formattedTimestamp())")
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                    
                    HStack {
                        Text(note.text)
                            .font(.body)
                    }
                    .padding(8)
                    .background(Color.green.opacity(0.7))
                    .cornerRadius(10)
                    
                    NoteButtonsView(note: note, viewModel: viewModel)
                }
            }
        }
    }
    
    private func formattedTimestamp() -> String {
        let timestamp = note.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let formattedDate = dateFormatter.string(from: timestamp)
        return formattedDate
    }
}

//#Preview {
//    NoteCell()
//}
