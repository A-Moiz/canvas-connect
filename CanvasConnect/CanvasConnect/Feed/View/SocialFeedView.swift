//
//  SocialFeedView.swift
//  CanvasConnect
//
//  Created by Abdul on 03/04/2024.
//

//import SwiftUI
//
//struct SocialFeedView: View {
//    @StateObject var viewModel = FeedViewModel()
//    @State private var showOpenAppMenu = false
//    @State private var isUploadArtSelected = false
//    @EnvironmentObject var background: BackgroundSelectionViewModel
//    @StateObject var frame = ImageFrames()
//
//    // Art Apps:
//    @State private var openingApp = false
//    @State private var openingAppTitle = ""
//    @State private var openingAppMessage = ""
//
//    var body: some View {
//        NavigationView {
//            ZStack(alignment: .bottomTrailing) {
//
//                Image(background.backgroundImages[background.appBG])
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .edgesIgnoringSafeArea(.all)
//
//                ScrollView {
//                    LazyVStack(spacing: 32) {
//                        if viewModel.posts.isEmpty {
//                            VStack {
//                                Spacer()
//
//                                Image("home-feed-pic")
//                                    .resizable()
//                                    .frame(width: frame.postWidth, height: frame.postHeight)
//
//                                Text("No posts to display right now.\nAs soon as someone posts you'll see it here.")
//
//                                Spacer()
//                            }
//                            .padding()
//                        } else {
//                            ForEach(viewModel.posts) { post in
//                                FeedCell(post: post)
//                            }
//                        }
//                    }
//                    .padding(.top, 8)
//
//                }
//                .navigationTitle("For You")
//
//                VStack {
//                    Menu {
//                        Button("Upload Art") {
//                            isUploadArtSelected = true
//                        }
//
//                        Button("Create Art") {
//                            showOpenAppMenu.toggle()
//                        }
//                    } label: {
//                        //Image(systemName: "plus.diamond.fill")
//                        Image(systemName: "paintbrush.pointed.fill")
//                            .resizable()
//                            .frame(width: frame.feedButtonW, height: frame.feedButtonH)
//                            .padding()
//                            .foregroundColor(.orange)
//                    }
//                }
//                .actionSheet(isPresented: $showOpenAppMenu) {
//                    ActionSheet(
//                        title: Text("Choose an Application from the list below"),
//                        buttons: [
//                            .default(Text("Open Pages")) {
//                                openPages()
//                            },
//                            .default(Text("Open Procreate Pocket")) {
//                                openProcreatePocket()
//                            },
//                            .default(Text("Open Sketchbook")) {
//                                openSketchbook()
//                            },
//                            .default(Text("Open Adobe")) {
//                                openAdobe()
//                            },
//                            .default(Text("Open Linea Sketch")) {
//                                openLineaSketch()
//                            },
//                            .default(Text("Open Ibis Paint X")) {
//                                openIbisPaint()
//                            },
//                            .default(Text("Open iArtbook")) {
//                                openIArtBook()
//                            },
//                            .default(Text("Open Artstudio Pro")) {
//                                openArtstudio()
//                            },
//                            .default(Text("Open Tayasui Sketches")) {
//                                openTayasuiSketches()
//                            },
//                            .default(Text("Open Paper by WeTransfer")) {
//                                openPaper()
//                            },
//                            .cancel()
//                        ]
//                    )
//                }
//            }
//            .background(
//                NavigationLink(
//                    destination: UploadPostView(),
//                    isActive: $isUploadArtSelected
//                ) {
//                    EmptyView()
//                }
//                    .hidden()
//            )
//        }
//        .alert(isPresented: $openingApp) {
//            Alert(
//                title: Text("\(openingAppTitle)"),
//                message: Text("\(openingAppMessage)"),
//                dismissButton: .default(Text("OK"))
//            )
//        }
//    }
//
//    // Opening Art Apps:
//    func openPages() {
//        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id361309726") else { return }
//
//        UIApplication.shared.open(appStoreURL, options: [:]) { success in
//            if success {
//                openingApp = true
//                openingAppTitle = "Success"
//                openingAppMessage = "Opened Pages successfully"
//            } else {
//                openingApp = true
//                openingAppTitle = "Error"
//                openingAppMessage = "Failed to open Pages"
//            }
//        }
//    }
//
//    func openProcreatePocket() {
//        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id916366645") else { return }
//
//        UIApplication.shared.open(appStoreURL, options: [:]) { success in
//            if success {
//                openingApp = true
//                openingAppTitle = "Success"
//                openingAppMessage = "Opened Procreate Pocket successfully"
//            } else {
//                openingApp = true
//                openingAppTitle = "Error"
//                openingAppMessage = "Failed to open Procreate Pocket"
//            }
//        }
//    }
//
//    func openSketchbook() {
//        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id883738213") else { return }
//
//        UIApplication.shared.open(appStoreURL, options: [:]) { success in
//            if success {
//                openingApp = true
//                openingAppTitle = "Success"
//                openingAppMessage = "Opened Sketchbook successfully"
//            } else {
//                openingApp = true
//                openingAppTitle = "Error"
//                openingAppMessage = "Failed to open Sketchbook"
//            }
//        }
//    }
//
//    func openAdobe() {
//        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id1458660369") else { return }
//
//        UIApplication.shared.open(appStoreURL, options: [:]) { success in
//            if success {
//                openingApp = true
//                openingAppTitle = "Success"
//                openingAppMessage = "Opened Adobe successfully"
//            } else {
//                openingApp = true
//                openingAppTitle = "Error"
//                openingAppMessage = "Failed to open Adobe"
//            }
//        }
//    }
//
//    func openLineaSketch() {
//        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id1094770251") else { return }
//
//        UIApplication.shared.open(appStoreURL, options: [:]) { success in
//            if success {
//                openingApp = true
//                openingAppTitle = "Success"
//                openingAppMessage = "Opened Linea Sketch successfully"
//            } else {
//                openingApp = true
//                openingAppTitle = "Error"
//                openingAppMessage = "Failed to open Linea Sketch"
//            }
//        }
//    }
//
//    func openIbisPaint() {
//        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id450722833") else { return }
//
//        UIApplication.shared.open(appStoreURL, options: [:]) { success in
//            if success {
//                openingApp = true
//                openingAppTitle = "Success"
//                openingAppMessage = "Opened Ibis Paint X successfully"
//            } else {
//                openingApp = true
//                openingAppTitle = "Error"
//                openingAppMessage = "Failed to open Ibis Paint X"
//            }
//        }
//    }
//
//    func openIArtBook() {
//        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id1451457615") else { return }
//
//        UIApplication.shared.open(appStoreURL, options: [:]) { success in
//            if success {
//                openingApp = true
//                openingAppTitle = "Success"
//                openingAppMessage = "Opened iArtbook successfully"
//            } else {
//                openingApp = true
//                openingAppTitle = "Error"
//                openingAppMessage = "Failed to open iArtbook"
//            }
//        }
//    }
//
//    func openArtstudio() {
//        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id1244142051") else { return }
//
//        UIApplication.shared.open(appStoreURL, options: [:]) { success in
//            if success {
//                openingApp = true
//                openingAppTitle = "Success"
//                openingAppMessage = "Opened Artstudio Pro successfully"
//            } else {
//                openingApp = true
//                openingAppTitle = "Error"
//                openingAppMessage = "Failed to open Artstudio Pro"
//            }
//        }
//    }
//
//    func openTayasuiSketches() {
//        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id641900855") else { return }
//
//        UIApplication.shared.open(appStoreURL, options: [:]) { success in
//            if success {
//                openingApp = true
//                openingAppTitle = "Success"
//                openingAppMessage = "Opened Tayasui Sketches successfully"
//            } else {
//                openingApp = true
//                openingAppTitle = "Error"
//                openingAppMessage = "Failed to open Tayasui Sketches"
//            }
//        }
//    }
//
//    func openPaper() {
//        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id506003812") else { return }
//
//        UIApplication.shared.open(appStoreURL, options: [:]) { success in
//            if success {
//                openingApp = true
//                openingAppTitle = "Success"
//                openingAppMessage = "Opened Paper by WeTransfer successfully"
//            } else {
//                openingApp = true
//                openingAppTitle = "Error"
//                openingAppMessage = "Failed to open Paper by WeTransfer"
//            }
//        }
//    }
//}

// TESTING HORIZONTAL SLIDER (WORKS):
import SwiftUI

struct SocialFeedView: View {
    @StateObject var viewModel = FeedViewModel()
    @StateObject var frame = ImageFrames()
    @StateObject var background = BackgroundSelectionViewModel()
    let user: User

    // Menu options:
    @State private var showOpenAppMenu = false
    @State private var isUploadArtSelected = false
    @State private var isUploadNoteSelected = false

    // Art Apps:
    @State private var openingApp = false
    @State private var openingAppTitle = ""
    @State private var openingAppMessage = ""

    // Slider properties
    @State private var selectedTab: Tab?
    @Environment(\.colorScheme) private var scheme
    @State private var tabProgress: CGFloat = 0

    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                
                TabBar()
                
                GeometryReader {
                    let size = $0.size
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 0) {
                            PostsView()
                                .id(Tab.post)
                                .containerRelativeFrame(.horizontal)

                            NotesView()
                                .id(Tab.notes)
                                .containerRelativeFrame(.horizontal)
                        }
                        .scrollTargetLayout()
                        .offsetX { value in
                            let progress = -value / (size.width * CGFloat(Tab.allCases.count - 1))
                            tabProgress = max(min(progress, 1), 0)
                            print(tabProgress)
                        }
                    }
                    .scrollPosition(id: $selectedTab)
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.paging)
                }

                ZStack {
                    VStack {
                        Menu {
                            Button("Upload Art") {
                                isUploadArtSelected = true
                            }

                            Button("Upload Note") {
                                isUploadNoteSelected = true
                            }

                            Button("Create Art") {
                                showOpenAppMenu.toggle()
                            }
                        } label: {
                            //Image(systemName: "plus.diamond.fill")
                            Image(systemName: "paintbrush.pointed.fill")
                                .resizable()
                                .frame(width: frame.feedButtonW, height: frame.feedButtonH)
                                .padding()
                                .foregroundColor(.orange)
                        }
                    }
                    .actionSheet(isPresented: $showOpenAppMenu) {
                        ActionSheet(
                            title: Text("Choose an Application from the list below"),
                            buttons: [
                                .default(Text("Open Pages")) {
                                    openPages()
                                },
                                .default(Text("Open Procreate Pocket")) {
                                    openProcreatePocket()
                                },
                                .default(Text("Open Sketchbook")) {
                                    openSketchbook()
                                },
                                .default(Text("Open Adobe")) {
                                    openAdobe()
                                },
                                .default(Text("Open Linea Sketch")) {
                                    openLineaSketch()
                                },
                                .default(Text("Open Ibis Paint X")) {
                                    openIbisPaint()
                                },
                                .default(Text("Open iArtbook")) {
                                    openIArtBook()
                                },
                                .default(Text("Open Artstudio Pro")) {
                                    openArtstudio()
                                },
                                .default(Text("Open Tayasui Sketches")) {
                                    openTayasuiSketches()
                                },
                                .default(Text("Open Paper by WeTransfer")) {
                                    openPaper()
                                },
                                .cancel()
                            ]
                        )
                    }
                }
                .background(
                    NavigationLink(
                        destination: UploadPostView(),
                        isActive: $isUploadArtSelected
                    ) {
                        EmptyView()
                    }
                        .hidden()
                )
                .background(
                    NavigationLink(
                        destination: UploadNoteView(user: user),
                        isActive: $isUploadNoteSelected
                    ) {
                        EmptyView()
                    }
                        .hidden()
                )
            }
            .background(Image(background.backgroundImages[background.appBG])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(.gray.opacity(0.1))
        }
        .alert(isPresented: $openingApp) {
            Alert(
                title: Text("\(openingAppTitle)"),
                message: Text("\(openingAppMessage)"),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    // Opening Art Apps:
    func openPages() {
        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id361309726") else { return }

        UIApplication.shared.open(appStoreURL, options: [:]) { success in
            if success {
                openingApp = true
                openingAppTitle = "Success"
                openingAppMessage = "Opened Pages successfully"
            } else {
                openingApp = true
                openingAppTitle = "Error"
                openingAppMessage = "Failed to open Pages"
            }
        }
    }

    func openProcreatePocket() {
        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id916366645") else { return }

        UIApplication.shared.open(appStoreURL, options: [:]) { success in
            if success {
                openingApp = true
                openingAppTitle = "Success"
                openingAppMessage = "Opened Procreate Pocket successfully"
            } else {
                openingApp = true
                openingAppTitle = "Error"
                openingAppMessage = "Failed to open Procreate Pocket"
            }
        }
    }

    func openSketchbook() {
        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id883738213") else { return }

        UIApplication.shared.open(appStoreURL, options: [:]) { success in
            if success {
                openingApp = true
                openingAppTitle = "Success"
                openingAppMessage = "Opened Sketchbook successfully"
            } else {
                openingApp = true
                openingAppTitle = "Error"
                openingAppMessage = "Failed to open Sketchbook"
            }
        }
    }

    func openAdobe() {
        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id1458660369") else { return }

        UIApplication.shared.open(appStoreURL, options: [:]) { success in
            if success {
                openingApp = true
                openingAppTitle = "Success"
                openingAppMessage = "Opened Adobe successfully"
            } else {
                openingApp = true
                openingAppTitle = "Error"
                openingAppMessage = "Failed to open Adobe"
            }
        }
    }

    func openLineaSketch() {
        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id1094770251") else { return }

        UIApplication.shared.open(appStoreURL, options: [:]) { success in
            if success {
                openingApp = true
                openingAppTitle = "Success"
                openingAppMessage = "Opened Linea Sketch successfully"
            } else {
                openingApp = true
                openingAppTitle = "Error"
                openingAppMessage = "Failed to open Linea Sketch"
            }
        }
    }

    func openIbisPaint() {
        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id450722833") else { return }

        UIApplication.shared.open(appStoreURL, options: [:]) { success in
            if success {
                openingApp = true
                openingAppTitle = "Success"
                openingAppMessage = "Opened Ibis Paint X successfully"
            } else {
                openingApp = true
                openingAppTitle = "Error"
                openingAppMessage = "Failed to open Ibis Paint X"
            }
        }
    }

    func openIArtBook() {
        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id1451457615") else { return }

        UIApplication.shared.open(appStoreURL, options: [:]) { success in
            if success {
                openingApp = true
                openingAppTitle = "Success"
                openingAppMessage = "Opened iArtbook successfully"
            } else {
                openingApp = true
                openingAppTitle = "Error"
                openingAppMessage = "Failed to open iArtbook"
            }
        }
    }

    func openArtstudio() {
        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id1244142051") else { return }

        UIApplication.shared.open(appStoreURL, options: [:]) { success in
            if success {
                openingApp = true
                openingAppTitle = "Success"
                openingAppMessage = "Opened Artstudio Pro successfully"
            } else {
                openingApp = true
                openingAppTitle = "Error"
                openingAppMessage = "Failed to open Artstudio Pro"
            }
        }
    }

    func openTayasuiSketches() {
        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id641900855") else { return }

        UIApplication.shared.open(appStoreURL, options: [:]) { success in
            if success {
                openingApp = true
                openingAppTitle = "Success"
                openingAppMessage = "Opened Tayasui Sketches successfully"
            } else {
                openingApp = true
                openingAppTitle = "Error"
                openingAppMessage = "Failed to open Tayasui Sketches"
            }
        }
    }

    func openPaper() {
        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id506003812") else { return }

        UIApplication.shared.open(appStoreURL, options: [:]) { success in
            if success {
                openingApp = true
                openingAppTitle = "Success"
                openingAppMessage = "Opened Paper by WeTransfer successfully"
            } else {
                openingApp = true
                openingAppTitle = "Error"
                openingAppMessage = "Failed to open Paper by WeTransfer"
            }
        }
    }

    // Tab Bar
    @ViewBuilder
    func TabBar() -> some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                HStack(spacing: 10) {
                    Image(systemName: tab.systemImage)

                    Text(tab.rawValue)
                        .font(.callout)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .contentShape(.capsule)
                .onTapGesture {
                    withAnimation(.snappy) {
                        selectedTab = tab
                    }
                }
            }
        }
        .background {
            GeometryReader {
                let size = $0.size
                let capsuleWidth = size.width / CGFloat(Tab.allCases.count)

                Capsule()
                    .fill(scheme == .dark ? .black : .white)
                    .frame(width: capsuleWidth)
                    .offset(x: tabProgress * (size.width - capsuleWidth))
            }
        }
        .background(.gray.opacity(0.1), in: .capsule)
        .padding(.horizontal, 15)
    }

    // Posts view
    @ViewBuilder
    func PostsView() -> some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                if viewModel.posts.isEmpty {
                    VStack {
                        Spacer()

                        Image("home-feed-pic")
                            .resizable()
                            .frame(width: frame.postWidth, height: frame.postHeight)
                            .scaledToFit()

                        Text("No posts to display right now.\nAs soon as someone posts you'll see it here.")

                        Spacer()
                    }
                    .padding()
                } else {
                    ForEach(viewModel.posts) { post in
                        FeedCell(post: post)
                    }
                }
            }
            .padding(.top, 8)

        }
        .navigationTitle("For You")
    }

    // Notes view
    @ViewBuilder
    func NotesView() -> some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                if viewModel.notes.isEmpty {
                    VStack {
                        Spacer()

                        Image("home-feed-pic")
                            .resizable()
                            .frame(width: frame.postWidth, height: frame.postHeight)
                            .scaledToFit()

                        Text("No notes to display right now.\nAs soon as someone writes a note you'll see it here.")

                        Spacer()
                    }
                    .padding()
                } else {
                    ForEach(viewModel.notes) { note in
                        NoteCell(note: note)
                        Divider()
                    }
                }
            }
            .padding(.top, 8)

        }
        .navigationTitle("For You")
    }
}


#Preview {
    SocialFeedView(user: User.MOCK_USERS[0])
}
