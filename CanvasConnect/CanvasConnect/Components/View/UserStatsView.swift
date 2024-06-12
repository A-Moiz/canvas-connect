//
//  UserStatsView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import SwiftUI

struct UserStatView: View {
    let value: Int
    let title: String
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(title)
                .font(.footnote)
        }
        .frame(width: 76)
    }
}

//#Preview {
//    UserStatsView()
//}
