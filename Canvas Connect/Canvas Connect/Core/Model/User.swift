//
//  User.swift
//  Canvas Connect
//
//  Created by Abdul on 14/01/2024.
//

import Foundation

struct User: Identifiable, Hashable, Codable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var bannerImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "Sun God", profileImageUrl: "luffy-pfp", bannerImageUrl: "one-piece-banner", fullname: "Monkey D Luffy", bio: "I'm gonna be King of the Pirates!", email: "luffy@gmail.com"),
        
        .init(id: NSUUID().uuidString, username: "King of Hell", profileImageUrl: "zoro-pfp", bannerImageUrl: "one-piece-banner2", fullname: "Roronoa Zoro", bio: "I'm going to be the world's greatest Swordsman!", email: "zoro@gmail.com"),
        
        .init(id: NSUUID().uuidString, username: "Weather Queen", profileImageUrl: "nami-pfp", bannerImageUrl: "one-piece-banner3", fullname: "Nami", bio: "I'm going to draw a map of the World!", email: "nami@gmail.com"),
        
        .init(id: NSUUID().uuidString, username: "Sniper King", profileImageUrl: "usopp-pfp", bannerImageUrl: "one-piece-banner", fullname: "Usopp", bio: "I'm going to become a brave warrior of the sea!", email: "usopp@gmail.com"),
        
        .init(id: NSUUID().uuidString, username: "Black Leg", profileImageUrl: "sanji-pfp", bannerImageUrl: "one-piece-banner2", fullname: "Vinsmoke Sanji", bio: "I'm going to find the All Blue!", email: "sanji@gmail.com")
    ]
}
