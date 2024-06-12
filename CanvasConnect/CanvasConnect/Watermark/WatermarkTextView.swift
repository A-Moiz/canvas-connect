//
//  WatermarkTextView.swift
//  CanvasConnect
//
//  Created by Abdul on 31/03/2024.
//

import SwiftUI

struct WatermarkTextView: View {
    let user: User
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("@\(user.username)")
                    .font(.title3)
                    .padding(6)
                    .foregroundColor(.white)
                    .background(Color(.black).opacity(0.9).cornerRadius(10))
            }
            .padding()
        }
        .cornerRadius(10)
        .padding()
    }
}

#Preview {
    WatermarkTextView(user: User.MOCK_USERS[0])
}
