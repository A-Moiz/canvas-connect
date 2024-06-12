//
//  UploadNoteView.swift
//  CanvasConnect
//
//  Created by Abdul on 29/04/2024.
//

import SwiftUI

struct UploadNoteView: View {
    @StateObject var viewModel = UploadNoteViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var note = ""
    @StateObject var background = BackgroundSelectionViewModel()
    @StateObject var frame = ImageFrames()
    @State private var noteEmpty = false
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        ScrollView {
            VStack {
                // Image
                CircularProfileImageView(user: user)
                    .frame(width: frame.PfpW, height: frame.PfpH)
                    .padding()
                
                Divider()
                
                HStack {
                    Text("Note:")
                        .padding(.leading, 8)
                        .frame(width: 100, alignment: .leading)
                    
                    VStack {
                        TextEditor(text: $note)
                            .frame(height: 60)
                                
                        Divider()
                    }
                }
                .font(.subheadline)
                .frame(height: 36)
                .padding()
            }
            
            // Comments toggle
            Toggle("Allow comments", isOn: $viewModel.canComment)
                .padding()
            
            Spacer()
            
            HStack(spacing: 20) {
                // Cancel Button
                Button(action: {
                    clearPostDataAndReturnToFeed()
                }) {
                    Image(systemName: "arrowshape.backward")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 64)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                
                // Upload Button
                Button(action: {
                    uploadNote()
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 64)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
            }
            .padding()
        }
        .navigationTitle("Upload Note")
        .navigationBarBackButtonHidden(true)
        .background(Image(background.backgroundImages[background.appBG])
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
        )
        .alert(isPresented: $noteEmpty) {
            Alert(
                title: Text("Note unfilled"),
                message: Text("Please write something in the text field before trying to upload"),
                primaryButton: .destructive(Text("OK")),
                secondaryButton: .cancel() {
                    clearPostDataAndReturnToFeed()
                }
            )
        }
    }
    
    // Cancel upload
    func clearPostDataAndReturnToFeed() {
        note = ""
        presentationMode.wrappedValue.dismiss()
    }
    
    // Uploading note
    func uploadNote() {
        if note.isEmpty {
            noteEmpty = true
        } else {
            Task {
                do {
                    try await viewModel.uploadNote(text: note)
                    clearPostDataAndReturnToFeed()
                } catch {
                    print("Failed to upload note: \(error)")
                }
            }
        }
    }
}

#Preview {
    UploadNoteView(user: User.MOCK_USERS[0])
}
