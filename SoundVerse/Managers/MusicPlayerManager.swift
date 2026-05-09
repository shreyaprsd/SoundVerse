import AVFoundation
import Combine

class MusicPlayerManager: ObservableObject {
    static let shared = MusicPlayerManager()

    @Published var isPlaying = false
    @Published var progress: Double = 0
    @Published var elapsedTime: String = "0:00"
    @Published var durationText: String = "0:00"

    private var player: AVAudioPlayer?
    private var timer: AnyCancellable?

    private init() {}

    func load(fileName: String) {
        guard player == nil else { return }
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            print("MusicPlayerManager: file not found — \(fileName)")
            return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            durationText = format(player?.duration ?? 0)
        } catch {
            print("MusicPlayerManager: failed to load player — \(error.localizedDescription)")
        }
    }

    func toggle() {
        guard let player else { return }
        if isPlaying {
            player.pause()
            stopTimer()
        } else {
            if player.currentTime >= player.duration {
                resetPlayback()
            }
            player.play()
            startTimer()
        }
        isPlaying.toggle()
    }

    private func startTimer() {
        stopTimer()
        timer = Timer.publish(every: 0.5, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }

    private func stopTimer() {
        timer?.cancel()
        timer = nil
    }

    private func tick() {
        guard let player else { return }
        let duration = player.duration
        guard duration > 0 else { return }
        progress = player.currentTime / duration
        elapsedTime = format(player.currentTime)

        if player.currentTime >= duration {
            resetPlayback()
            return
        }

        if !player.isPlaying {
            isPlaying = false
            stopTimer()
        }
    }

    private func resetPlayback() {
        player?.stop()
        player?.currentTime = 0
        progress = 0
        elapsedTime = "0:00"
        isPlaying = false
        stopTimer()
    }

    private func format(_ seconds: TimeInterval) -> String {
        let s = Int(seconds)
        return String(format: "%d:%02d", s / 60, s % 60)
    }
}
