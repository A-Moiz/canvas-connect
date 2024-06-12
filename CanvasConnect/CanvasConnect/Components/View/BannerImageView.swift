//
//  BannerImageView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import SwiftUI
import Kingfisher

struct BannerImageView: View {
    
    let user: User
    @StateObject var frame = ImageFrames()
    
    var body: some View {
        if let imageUrl = user.bannerImageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: frame.bannerWidth, height: frame.bannerHeight)
                .clipShape(Rectangle())
        } else {
            Image(systemName: "photo.on.rectangle")
                .resizable()
                .scaledToFit()
                .frame(width: frame.bannerWidth, height: frame.bannerHeight)
                .clipShape(Rectangle())
                .foregroundColor(Color(.systemGray4))
        }
    }
}

//#Preview {
//    BannerImageView()
//}
