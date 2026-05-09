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
    @State private var showMenu = false

    var body: some Scene {
        WindowGroup {
            ZStack {
                HomeView(showMenu: $showMenu)
                    .environmentObject(notificationManager)
                SideMenuView(isShowing: $showMenu)
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.startLocation.x < 30, value.translation.width > 80 {
                            withAnimation(.easeInOut(duration: 0.3)) { showMenu = true }
                        }
                        if value.translation.width < -80 {
                            withAnimation(.easeInOut(duration: 0.3)) { showMenu = false }
                        }
                    }
            )
        }
    }
}
