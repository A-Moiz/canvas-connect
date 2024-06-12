//
//  ImageFrames.swift
//  CanvasConnect
//
//  Created by Abdul on 17/04/2024.
//

import Foundation

class ImageFrames: ObservableObject {
    
    // Width/Height of posts
    @Published var postWidth: CGFloat = 400
    @Published var postHeight: CGFloat = 400
    
    // Feed
    @Published var postRadius: CGFloat = 5
    
    // Width/Height of banner
    @Published var bannerWidth: CGFloat = 400
    @Published var bannerHeight: CGFloat = 200
    
    // Width/Height of profile picture
    @Published var profileWidth: CGFloat = 40
    @Published var profileHeight: CGFloat = 40
    
    // Width/Height of current users profile picture
    @Published var currentPfpW: CGFloat = 80
    @Published var currentPfpH: CGFloat = 80
    
    // Width/Height of profile picture in upload note view
    @Published var PfpW: CGFloat = 150
    @Published var PfpH: CGFloat = 150
    
    // Feed button
    @Published var feedButtonW: CGFloat = 30
    @Published var feedButtonH: CGFloat = 30
}
