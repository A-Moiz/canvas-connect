//
//  Comment.swift
//  CanvasConnect
//
//  Created by Abdul on 15/04/2024.
//

import Foundation
import Firebase

struct Comment: Identifiable, Hashable, Codable {
    let id: String
    let comment: String
    let timestamp: Timestamp
    let userId: String
    let postId: String
}
