import SwiftUI

struct HomeView: View {
    @EnvironmentObject var notificationManager: NotificationManager
    @State private var isPlaying = false
    @State private var showMenu = false
    @State private var showNotifications = false

    private let bgColor = Color(red: 0.06, green: 0.05, blue: 0.12)
    private let purple = Color(red: 0.42, green: 0.27, blue: 0.87)

    private let track = Track(
        title: "Dinner & Diatribes",
        artist: "Hozier",
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
                        SoundtrackCardView(track: track, isPlaying: $isPlaying)
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
                        Button { showNotifications = true } label: {
                            Image(systemName: "bell.fill")
                                .font(.system(size: 16))
                        }
                        .accessibilityLabel("Open notifications")
                    }
                }
            }
            .background(bgColor.ignoresSafeArea())
        }
        .alert(item: $notificationManager.pendingAlert) { alert in
            Alert(
                title: Text(alert.title),
                message: Text(alert.body),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(NotificationManager.shared)
}
