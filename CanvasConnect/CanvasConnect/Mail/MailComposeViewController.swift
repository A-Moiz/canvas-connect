//
//  MailView.swift
//  CanvasConnect
//
//  Created by Abdul on 03/04/2024.
//

import Foundation
import MessageUI
import SwiftUI

struct MailComposeViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = MFMailComposeViewController

    @Binding var recipient: String
    @Binding var subject: String

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.setToRecipients([recipient])
        vc.setSubject(subject)
        vc.mailComposeDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {}
}
