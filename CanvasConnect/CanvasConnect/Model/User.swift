//
//  User.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import Foundation
import Firebase

struct User: Identifiable, Hashable, Codable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var bannerImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String
    var externalLink: String?
    var instagramLink: String?
    var facebookLink: String?
    var discordLink: String?
    var youtubeLink: String?
    var twitterLink: String?
    var patreonLink: String?
    var receiveEmail: Bool?
    var isEmailVerified: Bool = false
    var postCount: Int? = 0
    var noteCount: Int? = 0
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "SunGod", profileImageUrl: nil, bannerImageUrl: nil, fullname: "Monkey D Luffy", bio: "I'm gonna be King of the Pirates!", email: "luffy@gmail.com", externalLink: "https://www.google.com"),
        
            .init(id: NSUUID().uuidString, username: "KingOfHell", profileImageUrl: nil, bannerImageUrl: nil, fullname: "Roronoa Zoro", bio: "I'm going to be the world's greatest Swordsman!", email: "zoro@gmail.com", externalLink: "https://www.google.com"),
        
            .init(id: NSUUID().uuidString, username: "WeatherQueen", profileImageUrl: nil, bannerImageUrl: nil, fullname: "Nami", bio: "I'm going to draw a map of the World!", email: "nami@gmail.com", externalLink: "https://www.google.com"),
        
            .init(id: NSUUID().uuidString, username: "SniperKing", profileImageUrl: nil, bannerImageUrl: nil, fullname: "Usopp", bio: "I'm going to become a brave warrior of the sea!", email: "usopp@gmail.com", externalLink: "https://www.google.com"),
        
            .init(id: NSUUID().uuidString, username: "BlackLeg", profileImageUrl: nil, bannerImageUrl: nil, fullname: "Vinsmoke Sanji", bio: "I'm going to find the All Blue!", email: "sanji@gmail.com", externalLink: "https://www.google.com")
    ]
}
