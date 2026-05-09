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

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(notificationManager)
                .task {
                    notificationManager.requestPermission()
                }
        }
    }
}
