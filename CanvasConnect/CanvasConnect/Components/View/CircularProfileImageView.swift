//
//  CircularProfileImageView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import SwiftUI
import Kingfisher

struct CircularProfileImageView: View {
    
    let user: User
    
    var body: some View {
        
        if let imageUrl = user.profileImageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .clipShape(Circle())
                .foregroundColor(Color(.systemGray4))
        }
    }
}

//#Preview {
//    CircularProfileImageView()
//}
