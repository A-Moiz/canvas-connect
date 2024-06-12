//
//  EmailVerificationPendingView.swift
//  CanvasConnect
//
//  Created by Abdul on 01/04/2024.
//

import SwiftUI

struct EmailVerificationPendingView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Email Verification Pending")
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical)
            Text("Please verify your email address to access the app features.")
                .padding()
            Spacer()
        }
    }
}

#Preview {
    EmailVerificationPendingView()
}
