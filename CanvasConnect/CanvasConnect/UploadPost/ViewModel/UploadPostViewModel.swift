//
//  UploadPostViewModel.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import Foundation
import PhotosUI
import SwiftUI
import Firebase
import FirebaseStorage

@MainActor
class UploadPostViewModel: ObservableObject {
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    
    @Published var postImage: Image?
    private var uiImage: UIImage?
    @Published var isSpoiler = false
    @Published var hasWatermark = false
    @Published var canComment = false
    
    // Loads image and sets it as postImage
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }
    
    // Uploads post to Firestore with caption, image, and post metadata
    func uploadPost(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let uiImage = uiImage else { return }
        
        let postRef = Firestore.firestore().collection("posts").document()
        guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else { return }
        let post = Post(id: postRef.documentID, ownerUid: uid, caption: caption, likes: 0, imageUrl: imageUrl, timestamp: Timestamp(), isLiked: false, saves: 0, isSpoiler: isSpoiler, hasWatermark: hasWatermark, canComment: canComment)
        guard let encodedPost = try? Firestore.Encoder().encode(post) else { return }
        
        let userRef = Firestore.firestore().collection("users").document(uid)
        try await userRef.updateData(["postCount": FieldValue.increment(Int64(1))])
        
        try await postRef.setData(encodedPost)
    }
}
