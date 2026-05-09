import Combine
import UserNotifications

class NotificationManager: NSObject, ObservableObject {
    static let shared = NotificationManager()
    @Published var pendingAlert: NotificationAlert?
    @Published var isAuthorized = false
    @Published var notifications: [NotificationItem] = NotificationItem.dummyData
    private var lastScheduledID: String?

    override private init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    // completion: (granted, errorMessage)
    // errorMessage is non-nil when permission is denied or a system error occurred
    func checkAndRequest(completion: @escaping (Bool, String?) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized, .provisional, .ephemeral:
                DispatchQueue.main.async {
                    self.isAuthorized = true
                    completion(true, nil)
                }
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    DispatchQueue.main.async {
                        self.isAuthorized = granted
                        if let error {
                            completion(false, error.localizedDescription)
                        } else {
                            completion(granted, granted ? nil : "Notifications were denied.")
                        }
                    }
                }
            case .denied:
                DispatchQueue.main.async {
                    self.isAuthorized = false
                    completion(false, "Notifications are disabled. Please enable them in Settings → SoundVerse → Notifications.")
                }
            @unknown default:
                DispatchQueue.main.async { completion(false, "Unable to determine notification permission status.") }
            }
        }
    }

    private let dummyPayloads: [(title: String, body: String)] = [
        ("SoundVerse", "New track added to your indie-rock playlist"),
        ("SoundVerse", "Your weekly listening report is ready."),
        ("SoundVerse", "Someone liked your playlist 'SoundVerse Latest Hits'."),
        ("SoundVerse", "A new AI-generated track matches your mood."),
        ("SoundVerse", "Your listening streak is now 6 days in a row!"),
    ]

    func markAsRead(id: UUID) {
        notifications = notifications.map { item in
            guard item.id == id else { return item }
            return NotificationItem(
                id: item.id,
                username: item.username,
                avatarSymbol: item.avatarSymbol,
                message: item.message,
                time: item.time,
                isUnread: false
            )
        }
    }

    func scheduleDelayedNotification() {
        let payload = dummyPayloads.randomElement()!
        let content = UNMutableNotificationContent()
        content.title = payload.title
        content.body = payload.body
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [lastScheduledID ?? ""])
        lastScheduledID = request.identifier

        UNUserNotificationCenter.current().add(request) { error in
            if let error {
                print("Failed to schedule notification: \(error.localizedDescription)")
            }
        }
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        DispatchQueue.main.async {
            self.pendingAlert = NotificationAlert(
                title: notification.request.content.title,
                body: notification.request.content.body
            )
            self.notifications.insert(
                NotificationItem(
                    id: UUID(),
                    username: notification.request.content.title,
                    avatarSymbol: "bell.fill",
                    message: notification.request.content.body,
                    time: "Just now",
                    isUnread: true
                ),
                at: 0
            )
        }
        completionHandler([.badge, .sound, .banner])
    }
}

struct NotificationAlert: Identifiable {
    let id = UUID()
    let title: String
    let body: String
}
