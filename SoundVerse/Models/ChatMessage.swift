import Foundation

struct ChatMessage: Identifiable {
    let id: UUID
    let text: String
    let isFromUser: Bool
    let timestamp: String
}

extension ChatMessage {
    static func dummyConversation(with _: String) -> [ChatMessage] {
        [
            ChatMessage(
                id: UUID(),
                text: "Hey! SoundVerse found a track you'd love ",
                isFromUser: false,
                timestamp: "9:41 AM"
            ),
            ChatMessage(
                id: UUID(),
                text: "Oh nice, what is it?",
                isFromUser: true,
                timestamp: "9:42 AM"
            ),
            ChatMessage(
                id: UUID(),
                text: "It's an indie-rock perfect for relaxing sessions.",
                isFromUser: false,
                timestamp: "9:42 AM"
            ),
            ChatMessage(
                id: UUID(),
                text: "That's exactly what I needed!",
                isFromUser: true,
                timestamp: "9:43 AM"
            ),
            ChatMessage(
                id: UUID(),
                text: "Glad to help. Tap the track card on your home screen to start playing.",
                isFromUser: false,
                timestamp: "9:43 AM"
            ),
        ]
    }
}
