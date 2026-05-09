import Foundation

struct NotificationItem: Identifiable, Hashable {
    let id: UUID
    let username: String
    let avatarSymbol: String
    let message: String
    let time: String
    let isUnread: Bool
}

extension NotificationItem {
    static let dummyData: [NotificationItem] = [
        NotificationItem(
            id: UUID(),
            username: "SoundVerse",
            avatarSymbol: "music.note.house.fill",
            message: "Your playlist 'Late Night Vibes' was updated with 3 new tracks.",
            time: "2m ago",
            isUnread: true
        ),
        NotificationItem(
            id: UUID(),
            username: "Alex_Creates",
            avatarSymbol: "person.fill",
            message: "liked your track \"Indie-Rock\".",
            time: "14m ago",
            isUnread: true
        ),
        NotificationItem(
            id: UUID(),
            username: "SoundVerse",
            avatarSymbol: "music.note.house.fill",
            message: "A new AI-generated track matches your listening profile.",
            time: "1h ago",
            isUnread: false
        ),
        NotificationItem(
            id: UUID(),
            username: "Jamie_Beats",
            avatarSymbol: "person.crop.circle.fill",
            message: "started following you.",
            time: "3h ago",
            isUnread: false
        ),
        NotificationItem(
            id: UUID(),
            username: "SoundVerse",
            avatarSymbol: "music.note.house.fill",
            message: "Listening streak: 5 days in a row. Keep it going!",
            time: "1d ago",
            isUnread: false
        ),
    ]
}
