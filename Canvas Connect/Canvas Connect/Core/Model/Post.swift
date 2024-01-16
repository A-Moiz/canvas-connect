//
//  Post.swift
//  Canvas Connect
//
//  Created by Abdul on 14/01/2024.
//

import Foundation

struct Post: Identifiable, Hashable, Codable {
    let id: String
    let ownderUid: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let timestamp: Date
    var user: User?
}

extension Post {
    static var MOCK_POSTS: [Post] = [
        .init(id: NSUUID().uuidString, ownderUid: NSUUID().uuidString, caption: "One Piece", likes: 100, imageUrl: "image-1", timestamp: Date(), user: User.MOCK_USERS[0]),
        
        .init(id: NSUUID().uuidString, ownderUid: NSUUID().uuidString, caption: "One Piece", likes: 200, imageUrl: "image-2", timestamp: Date(), user: User.MOCK_USERS[1]),
        
        .init(id: NSUUID().uuidString, ownderUid: NSUUID().uuidString, caption: "One Piece", likes: 300, imageUrl: "image-3", timestamp: Date(), user: User.MOCK_USERS[2]),
        
        .init(id: NSUUID().uuidString, ownderUid: NSUUID().uuidString, caption: "One Piece", likes: 400, imageUrl: "image-4", timestamp: Date(), user: User.MOCK_USERS[3]),
        
        .init(id: NSUUID().uuidString, ownderUid: NSUUID().uuidString, caption: "One Piece", likes: 500, imageUrl: "image-5", timestamp: Date(), user: User.MOCK_USERS[4]),
        
        .init(id: NSUUID().uuidString, ownderUid: NSUUID().uuidString, caption: "One Piece", likes: 600, imageUrl: "image-6", timestamp: Date(), user: User.MOCK_USERS[0])
    ]
}
