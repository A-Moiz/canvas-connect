//
//  NotesView.swift
//  CanvasConnect
//
//  Created by Abdul on 29/04/2024.
//

import SwiftUI

struct NotesView: View {
    let user: User
    @StateObject var background = BackgroundSelectionViewModel()
    @StateObject var viewModel: NotesViewModel
    @StateObject var frame = ImageFrames()
    @State private var searchText = ""
    
    init(user: User) {
        self.user = user
        _viewModel = StateObject(wrappedValue: NotesViewModel(user: user))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.filteredNotes) { note in
                        HStack(spacing: 10) {
                            VStack {
                                CircularProfileImageView(user: user)
                                    .frame(width: frame.profileWidth, height: frame.profileHeight)
                                Spacer()
                            }
                            
                            VStack {
                                HStack(spacing: 10) {
                                    Text(user.username)
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                    
                                    Text("Posted \(formattedTimestamp(note.timestamp.dateValue()))")
                                        .font(.caption)
                                        .foregroundColor(.black)
                                }
                                
                                HStack {
                                    Text(note.text)
                                        .font(.body)
                                }
                                
                                NoteButtonsView(note: note, viewModel: NoteButtonsViewModel(note: note))
                            }
                            .padding(8)
                            .background(Color.green.opacity(0.7))
                            .cornerRadius(10)
                            
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Notes")
            .background(Image(background.backgroundImages[background.appBG])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            )
            .searchable(text: $searchText, prompt: "search notes")
        }
        .onChange(of: searchText) { newValue in
            Task {
                do {
                    if newValue.isEmpty {
                        try await viewModel.fetchUserNotes()
                    } else {
                        try await viewModel.filterUserNotes(keyword: newValue)
                    }
                } catch {
                    print("Error filtering notes: \(error.localizedDescription)")
                }
            }
        }
        .onAppear {
            Task {
                try await viewModel.fetchUserNotes()
            }
        }
    }
    private func formattedTimestamp(_ timestamp: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let formattedDate = dateFormatter.string(from: timestamp)
        return formattedDate
    }
}

//#Preview {
//    NotesView(user: User.MOCK_USERS[0])
//}
