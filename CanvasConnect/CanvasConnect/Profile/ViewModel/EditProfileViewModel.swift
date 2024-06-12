//
//  EditProfileViewModel.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import Foundation
import PhotosUI
import Firebase
import SwiftUI

@MainActor
class EditProfileViewModel: ObservableObject {
    
    @Published var user: User
    
    @Published var selectedProfileImage: PhotosPickerItem? {
        didSet { Task { await loadProfileImage(fromItem: selectedProfileImage) }}
    }
        
    @Published var selectedBannerImage: PhotosPickerItem? {
        didSet { Task { await loadBannerImage(fromItem: selectedBannerImage) }}
    }
    
    @Published var profileImage: Image?
    @Published var bannerImage: Image?
    @Published var fullname = ""
    @Published var bio = ""
    
    @Published var link = ""
    @Published var instagramLink = ""
    @Published var facebookLink = ""
    @Published var discordLink = ""
    @Published var youtubeLink = ""
    @Published var twitterLink = ""
    @Published var patreonLink = ""
    @Published var receiveEmail = false
    
    private var uiImage: UIImage?
    private var banner: UIImage?
    
    @Published var isDataUpdated = false
    
    init(user: User) {
        self.user = user
        
        if let fullname = user.fullname {
            self.fullname = fullname
        }
        
        if let bio = user.bio {
            self.bio = bio
        }
        
        if let externalLink = user.externalLink {
            self.link = externalLink
        }
        
        if let instagramLink = user.instagramLink {
            self.instagramLink = instagramLink
        }
        
        if let facebookLink = user.facebookLink {
            self.facebookLink = facebookLink
        }
        
        if let discordLink = user.discordLink {
            self.discordLink = discordLink
        }
        
        if let youtubeLink = user.youtubeLink {
            self.youtubeLink = youtubeLink
        }
        
        if let twitterLink = user.twitterLink {
            self.twitterLink = twitterLink
        }
        
        if let patreonLink = user.patreonLink {
            self.patreonLink = patreonLink
        }
        
        if let receiveEmail = user.receiveEmail {
            self.receiveEmail = receiveEmail
        }
    }
    
    func loadProfileImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func loadBannerImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else { return }
        self.banner = uiImage
        self.bannerImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws {
        // Collection to store user data
        var data = [String: Any]()
        
        // Update Banner image
        if let banner = banner {
            isDataUpdated = true
            let imageUrl = try? await ImageUploader.uploadBanner(image: banner)
            user.bannerImageUrl = imageUrl
            data["bannerImageUrl"] = imageUrl
        }

        // Update profile image
        if let uiImage = uiImage {
            isDataUpdated = true
            let imageUrl = try? await ImageUploader.uploadImage(image: uiImage)
            user.profileImageUrl = imageUrl
            data["profileImageUrl"] = imageUrl
        }

        // Update name
        if !fullname.isEmpty && user.fullname != fullname {
            isDataUpdated = true
            user.fullname = fullname
            data["fullname"] = fullname
        }

        // Update bio
        if user.bio != bio {
            isDataUpdated = true
            user.bio = bio
            data["bio"] = bio
        }
        
        // Update links
        if user.externalLink != link {
            isDataUpdated = true
            user.externalLink = link
            data["externalLink"] = link
        }
        
        // Instagram
        if user.instagramLink != instagramLink {
            isDataUpdated = true
            user.instagramLink = instagramLink
            data["instagramLink"] = instagramLink
        }
        
        // Facebook
        if user.facebookLink != facebookLink {
            isDataUpdated = true
            user.facebookLink = facebookLink
            data["facebookLink"] = facebookLink
        }
        
        // Discord
        if user.discordLink != discordLink {
            isDataUpdated = true
            user.discordLink = discordLink
            data["discordLink"] = discordLink
        }
        
        // YouTube
        if user.youtubeLink != youtubeLink {
            isDataUpdated = true
            user.youtubeLink = youtubeLink
            data["youtubeLink"] = youtubeLink
        }
        
        // Twitter
        if user.twitterLink != twitterLink {
            isDataUpdated = true
            user.twitterLink = twitterLink
            data["twitterLink"] = twitterLink
        }
        
        // Patreon
        if user.patreonLink != patreonLink {
            isDataUpdated = true
            user.patreonLink = patreonLink
            data["patreonLink"] = patreonLink
        }
        
        // Commission
        if user.receiveEmail != receiveEmail {
            isDataUpdated = true
            user.receiveEmail = receiveEmail
            data["receiveEmail"] = receiveEmail
        }
        
        // Uploading to firebase database
        try await Firestore.firestore().collection("users").document(user.id).updateData(data)
    }
}
