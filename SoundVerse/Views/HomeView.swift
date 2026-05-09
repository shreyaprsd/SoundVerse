import SwiftUI

struct HomeView: View {
    @EnvironmentObject var notificationManager: NotificationManager
    @EnvironmentObject var playerManager: MusicPlayerManager
    @Binding var showMenu: Bool
    @State private var showNotifications = false
    @State private var notificationPermissionError: String?

    private let bgColor = Color(red: 0.06, green: 0.05, blue: 0.12)
    private let purple = Color(red: 0.42, green: 0.27, blue: 0.87)

    private let track = Track(
        title: "Piano",
        artist: "Pixabay",
        duration: "2:10",
        audioFileName: "audiotrack.mp3",
        coverImageName: "coverImage"
    )

    var body: some View {
        ZStack {
            NavigationStack {
                ZStack {
                    bgColor.ignoresSafeArea()

                    VStack {
                        Spacer()
                        SoundtrackCardView(track: track, playerManager: playerManager)
                            .padding(.horizontal, 20)
                        Spacer()
                    }
                }
                .navigationTitle("SoundVerse")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .navigationDestination(isPresented: $showNotifications) {
                    NotificationsView()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button { showMenu = true } label: {
                            Image(systemName: "person.fill")
                                .font(.system(size: 16))
                        }
                        .accessibilityLabel("Open profile menu")
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            notificationManager.checkAndRequest { granted, errorMessage in
                                if granted {
                                    showNotifications = true
                                } else {
                                    notificationPermissionError = errorMessage
                                }
                            }
                        } label: {
                            Image(systemName: "bell.fill")
                                .font(.system(size: 16))
                        }
                        .accessibilityLabel("Open notifications")
                    }
                }
            }
            .background(bgColor.ignoresSafeArea())
        }
        .onAppear {
            playerManager.load(fileName: track.audioFileName)
        }
        .alert(item: $notificationManager.pendingAlert) { alert in
            Alert(
                title: Text(alert.title),
                message: Text(alert.body),
                dismissButton: .default(Text("OK"))
            )
        }
        .alert(
            "Notifications Unavailable",
            isPresented: Binding(
                get: { notificationPermissionError != nil },
                set: { if !$0 { notificationPermissionError = nil } }
            )
        ) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(notificationPermissionError ?? "")
        }
    }
}

#Preview {
    HomeView(showMenu: .constant(false))
        .environmentObject(NotificationManager.shared)
        .environmentObject(MusicPlayerManager.shared)
}
