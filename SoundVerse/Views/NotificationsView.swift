import SwiftUI

struct NotificationsView: View {
    @EnvironmentObject var notificationManager: NotificationManager

    private let bgColor = Color(red: 0.06, green: 0.05, blue: 0.12)
    private let cardColor = Color(red: 0.11, green: 0.09, blue: 0.20)
    private let purple = Color(red: 0.42, green: 0.27, blue: 0.87)

    var body: some View {
        ZStack {
            bgColor.ignoresSafeArea()

            List(notificationManager.notifications) { item in
                NavigationLink {
                    ChatView(notification: item)
                        .onAppear {
                            notificationManager.markAsRead(id: item.id)
                            notificationManager.scheduleDelayedNotification()
                        }
                } label: {
                    NotificationRow(item: item)
                }
                .listRowBackground(
                    cardColor.overlay(
                        item.isUnread
                            ? RoundedRectangle(cornerRadius: 0).fill(purple.opacity(0.08))
                            : nil
                    )
                )
                .listRowSeparatorTint(Color.white.opacity(0.07))
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

struct NotificationRow: View {
    let item: NotificationItem
    private let purple = Color(red: 0.42, green: 0.27, blue: 0.87)

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(purple.opacity(0.2))
                    .frame(width: 46, height: 46)
                Image(systemName: item.avatarSymbol)
                    .foregroundColor(purple)
                    .font(.system(size: 20))
            }

            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 6) {
                    Text(item.username)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                    if item.isUnread {
                        Circle()
                            .fill(purple)
                            .frame(width: 6, height: 6)
                    }
                }
                Text(item.message)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .lineLimit(2)
                Text(item.time)
                    .font(.system(size: 11))
                    .foregroundColor(Color.gray.opacity(0.6))
            }

            Spacer()
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    NavigationStack {
        NotificationsView()
            .environmentObject(NotificationManager.shared)
    }
}
