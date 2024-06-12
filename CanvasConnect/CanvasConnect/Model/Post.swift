//
//  Post.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import Foundation
import Firebase

struct Post: Identifiable, Hashable, Codable {
    let id: String
    let ownerUid: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let timestamp: Timestamp
    var user: User?
    var isLiked: Bool? = false
    var isSaved: Bool? = false
    var saves: Int
    var isSpoiler: Bool? = false
    var hasWatermark: Bool? = false
    var canComment: Bool? = false
}

extension Post {
    static var MOCK_POSTS: [Post] = [
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "One Piece", likes: 100, imageUrl: "image-1", timestamp: Timestamp(), user: User.MOCK_USERS[0], isLiked: false, saves: 0),
        
            .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "One Piece", likes: 200, imageUrl: "image-2", timestamp: Timestamp(), user: User.MOCK_USERS[1], isLiked: false, saves: 0),
        
            .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "One Piece", likes: 300, imageUrl: "image-3", timestamp: Timestamp(), user: User.MOCK_USERS[2], isLiked: false, saves: 0),
        
            .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "One Piece", likes: 400, imageUrl: "image-4", timestamp: Timestamp(), user: User.MOCK_USERS[3], isLiked: false, saves: 0),
        
            .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "One Piece", likes: 500, imageUrl: "image-5", timestamp: Timestamp(), user: User.MOCK_USERS[4], isLiked: false, saves: 0),
        
            .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "One Piece", likes: 600, imageUrl: "image-6", timestamp: Timestamp(), user: User.MOCK_USERS[0], isLiked: false, saves: 0)
    ]
}
