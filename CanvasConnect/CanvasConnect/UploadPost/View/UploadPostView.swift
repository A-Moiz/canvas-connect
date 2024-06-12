//
//  UploadPostView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    @State private var caption = ""
    @State private var imagePresented = false
    @StateObject var viewModel = UploadPostViewModel()
    @Environment(\.presentationMode) var presentationMode
    @StateObject var background = BackgroundSelectionViewModel()
    @StateObject var frame = ImageFrames()
    @State private var captionEmpty = false
    
    var body: some View {
        ScrollView {            
            // Image + Caption
            VStack(spacing: 8) {
                if let image = viewModel.postImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: frame.postWidth, height: frame.postHeight)
                        .clipped()
                }
                
                TextField("Caption...", text: $caption)
                    .padding()
            }
            .padding()
            
            // Spoiler toggle
            Toggle("Spoiler/NSFW", isOn: $viewModel.isSpoiler)
                .padding()
            
            // Watermark toggle
            Toggle("Add Watermark", isOn: $viewModel.hasWatermark)
                .padding()
            
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
                    uploadPost()
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
        .navigationTitle("Upload")
        .navigationBarBackButtonHidden(true)
        .background(Image(background.backgroundImages[background.appBG])
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
        )
        .onAppear {
            imagePresented.toggle()
        }
        .photosPicker(isPresented: $imagePresented, selection: $viewModel.selectedImage)
        .alert(isPresented: $captionEmpty) {
            Alert(
                title: Text("Caption unfilled"),
                message: Text("Please add a caption to your work before uploading"),
                primaryButton: .destructive(Text("OK")),
                secondaryButton: .cancel() {
                    clearPostDataAndReturnToFeed()
                }
            )
        }
    }
    
    // Cancel upload
    func clearPostDataAndReturnToFeed() {
        caption = ""
        viewModel.selectedImage = nil
        viewModel.postImage = nil
        presentationMode.wrappedValue.dismiss()
    }
    
    // Uploading posts
    func uploadPost() {
        if caption.isEmpty {
            captionEmpty = true
        } else {
            Task {
                do {
                    try await viewModel.uploadPost(caption: caption)
                    clearPostDataAndReturnToFeed()
                } catch {
                    print("Failed to upload post: \(error)")
                }
            }
        }
    }
}

#Preview {
    UploadPostView()
}
