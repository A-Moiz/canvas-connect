//
//  BackgroundSelectView.swift
//  CanvasConnect
//
//  Created by Abdul on 25/04/2024.
//

import SwiftUI

struct BackgroundSelectView: View {
    @EnvironmentObject var viewModel: BackgroundSelectionViewModel
    @State private var bgUpdated: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $viewModel.appBG) {
                    ForEach(0..<viewModel.backgroundImages.count, id: \.self) { index in
                        Image(viewModel.backgroundImages[index])
                            .resizable()
                            .scaledToFill()
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 600)
                
//                Button("Set Background") {
//                    viewModel.setBackgroundIndex(viewModel.appBG)
//                    bgUpdated.toggle()
//                }
//                .padding()
            }
            .navigationTitle("Select Background")
            .alert(isPresented: $bgUpdated) {
                Alert(
                    title: Text("Background Updated"),
                    message: Text("Background has been updated. Please restart the application to view this change on all the pages."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

#Preview {
    BackgroundSelectView()
}
