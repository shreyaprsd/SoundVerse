import SwiftUI

struct ChatView: View {
    let notification: NotificationItem
    @State private var messages: [ChatMessage]
    private let bgColor = Color.soundVerseBackground
    private let purple = Color.soundVersePurple
    private let incomingBubble = Color.soundVerseCard

    init(notification: NotificationItem) {
        self.notification = notification
        _messages = State(initialValue: ChatMessage.dummyConversation(with: notification.username))
    }

    var body: some View {
        ZStack {
            bgColor.ignoresSafeArea()

            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(messages) { message in
                            ChatBubble(
                                message: message,
                                outgoingColor: purple,
                                incomingColor: incomingBubble
                            )
                            .id(message.id)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
                .onAppear {
                    if let last = messages.last {
                        proxy.scrollTo(last.id, anchor: .bottom)
                    }
                }
            }
        }
        .navigationTitle(notification.username)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

struct ChatBubble: View {
    let message: ChatMessage
    let outgoingColor: Color
    let incomingColor: Color

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            if message.isFromUser { Spacer(minLength: 60) }

            VStack(alignment: message.isFromUser ? .trailing : .leading, spacing: 3) {
                Text(message.text)
                    .font(.system(size: 15))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(message.isFromUser ? outgoingColor : incomingColor)
                    )

                Text(message.timestamp)
                    .font(.system(size: 11))
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 4)
            }

            if !message.isFromUser { Spacer(minLength: 60) }
        }
    }
}

#Preview {
    NavigationStack {
        ChatView(notification: NotificationItem.dummyData[0])
            .environmentObject(NotificationManager.shared)
    }
}
