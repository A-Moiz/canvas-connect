//
//  BackgroundSelectionViewModel.swift
//  CanvasConnect
//
//  Created by Abdul on 02/04/2024.
//

import Foundation

class BackgroundSelectionViewModel: ObservableObject {
    
    //    Wallpapers:
    //    - alive: 0
    //    - blue-lagoo: 1
    //    - blue-raspberry: 2
    //    - blush: 3
    //    - burning-orange: 4
    //    - celestial: 5
    //    - firewatch: 6
    //    - flare: 7
    //    - flickr: 8
    //    - frost: 9
    //    - hydrogen: 10
    //    - influenza: 11
    //    - lawrencium: 12
    //    - orange-coral: 13
    //    - royal: 14
    //    - shifter: 15
    //    - sin-city-red: 16
    //    - slight-ocean-view: 17
    //    - vanusa: 18
    //    - very-blue: 19
    //    - visions-of-grandeur: 20
    //    - witching-hour: 21
    //    - app-background: 22
    //    - app-background2: 23
    //    - app-background3: 24
    //    - app-background4: 25
    //    - app-background5: 26
    //    - app-background6: 27
    //    - app-background7: 28
    //    - app-background8: 29
    //    - app-background9: 30
    //    - app-background10: 31
    //    - app-background11: 32
    //    - background-one: 33
    //    - background-two: 34
    //    - background-three: 35
    //    - background-four: 36
    
    let backgroundImages = ["alive", "blue-lagoo", "blue-raspberry", "blush", "burning-orange", "celestial", "firewatch", "flare", "flickr", "frost", "hydrogen", "Influenza", "lawrencium", "orange-coral", "royal", "shifter", "sin-city-red", "slight-ocean-view", "vanusa", "very-blue", "visions-of-grandeur", "witching-hour", "app-background", "app-background2", "app-background3", "app-background4", "app-background5", "app-background6", "app-background7", "app-background8", "app-background8", "app-background9", "app-background10", "app-background11", "background-one", "background-two", "background-three", "background-four"]
    
    @Published var isDataUpdated = false
    @Published var authenticationBG: Int = 9
    @Published var postBG: Int = 13
    
//    @Published var appBG: Int = 19
//    @Published var appBG: Int = 11
    @Published var appBG: Int = 3
    
//    @Published var appBG: Int {
//        didSet {
//            UserDefaults.standard.set(appBG, forKey: "appBG")
//        }
//    }
    
//    init() {
//        self.appBG = UserDefaults.standard.integer(forKey: "appBG")
//    }
    
    @Published var commentBG: Int = 23
    
//    func setBackgroundIndex(_ index: Int) {
//        appBG = index
//        isDataUpdated = true
//        print(appBG)
//    }
}
