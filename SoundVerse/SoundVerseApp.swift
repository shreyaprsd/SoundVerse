//
//  SoundVerseApp.swift
//  SoundVerse
//
//  Created by Shreya Prasad on 07/05/26.
//

import SwiftUI

@main
struct SoundVerseApp: App {
    @StateObject private var notificationManager = NotificationManager.shared
    @StateObject private var playerManager = MusicPlayerManager.shared
    @State private var showMenu = false

    var body: some Scene {
        WindowGroup {
            GeometryReader { proxy in
                let menuWidth = proxy.size.width * 0.75

                ZStack {
                    HomeView(showMenu: $showMenu)
                        .environmentObject(notificationManager)
                        .environmentObject(playerManager)
                    SideMenuView(isShowing: $showMenu)
                }
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.startLocation.x < 30, value.translation.width > 80 {
                                withAnimation(.easeInOut(duration: 0.3)) { showMenu = true }
                            }

                            if showMenu,
                               value.startLocation.x <= menuWidth,
                               value.translation.width < -80
                            {
                                withAnimation(.easeInOut(duration: 0.3)) { showMenu = false }
                            }
                        }
                )
            }
        }
    }
}
