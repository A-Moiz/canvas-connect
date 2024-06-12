//
//  Notes.swift
//  CanvasConnect
//
//  Created by Abdul on 29/04/2024.
//

import Foundation
import Firebase

struct Note: Identifiable, Hashable, Codable {
    let id: String
    let ownerUid: String
    let text: String
    var likes: Int
    let timestamp: Timestamp
    var user: User?
    var isLiked: Bool? = false
    var canComment: Bool? = false
}
