//
//  ContactView.swift
//  CanvasConnect
//
//  Created by Abdul on 03/05/2024.
//

import SwiftUI

struct ContactView: View {
    let user: User
    @StateObject var background = BackgroundSelectionViewModel()
    @StateObject var frame = ImageFrames()
    @State private var comment = ""
    @State private var error = false
    @ObservedObject var viewModel: EditProfileViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                // Info
                Text("Please use this page to request a feature or submit any issues you have with the application")
                    .padding()
                    .multilineTextAlignment(.center)
                
                // Divider
                Divider()
                
                // Image
                CircularProfileImageView(user: viewModel.user)
                    .frame(width: frame.PfpW, height: frame.PfpH)
                    .padding()
                
                // Textfield
                HStack {
                    Text("Message:")
                        .padding(.leading, 8)
                        .frame(width: 100, alignment: .leading)
                    
                    VStack {
                        TextEditor(text: $comment)
                            .frame(height: 150)
                    }
                    .padding(.top, 100)
                }
                .font(.subheadline)
                .frame(height: 36)
                .padding()
                
                VStack(spacing: 20) {
                    Divider()
                    
                    // Send button
                    Button(action: {
                        if comment.isEmpty {
                            error = true
                        } else {
                            sendEmail()
                        }
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 64, height: 64)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                }
                .padding(.top, 150)
            }
            .navigationTitle("Contact us")
            .background(Image(background.backgroundImages[background.appBG])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            )
            .alert(isPresented: $error) {
                Alert(
                    title: Text("Error sending email"),
                    message: Text("Please write something in the message box before sending the email."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    func sendEmail() {
        let recipientEmail = "w1820886@my.westminster.ac.uk"
        let subject = "Feedback"
        let body = comment
        
        if let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: "mailto:\(recipientEmail)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&body=\(bodyEncoded)") {
            UIApplication.shared.open(url)
        }
    }
}

//#Preview {
//    ContactView(user: User.MOCK_USERS[0])
//}
