//
//  Tab.swift
//  CanvasConnect
//
//  Created by Abdul on 29/04/2024.
//

import Foundation

enum Tab: String, CaseIterable {
    case post = "Posts"
    case notes = "Notes"
    
    var systemImage: String {
        switch self {
        case.post:
            return "photo.stack"
        case .notes:
            return "text.bubble"
        }
    }
}
