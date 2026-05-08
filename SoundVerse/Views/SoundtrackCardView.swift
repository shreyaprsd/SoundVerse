import SwiftUI

struct SoundtrackCardView: View {
    let track: Track
    @Binding var isPlaying: Bool
    var progress: Double = 0.18

    private let cardColor = Color(red: 0.11, green: 0.09, blue: 0.20)
    private let artColor = Color(red: 0.11, green: 0.09, blue: 0.20)
    private let purple = Color(red: 0.42, green: 0.27, blue: 0.87)

    var body: some View {
        VStack(spacing: 16) {
            albumArt
                .padding(.bottom, 10)
            trackInfo
            progressRow
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 16).fill(cardColor))
    }

    private var albumArt: some View {
        ZStack {
            if track.coverImageName.isEmpty {
                Circle()
                    .fill(purple.opacity(0.45))
                    .frame(width: 150, height: 150)
                    .blur(radius: 55)

                Image(systemName: "music.note")
                    .font(.system(size: 52, weight: .light))
                    .foregroundColor(.white)
                    .offset(y: -16)
            } else {
                Image(track.coverImageName)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            }
        }
        .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
        .background(RoundedRectangle(cornerRadius: 24).fill(artColor))
    }

    private var trackInfo: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(track.title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                Text(track.artist)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            Spacer()
            Button { isPlaying.toggle() } label: {
                Circle()
                    .fill(purple)
                    .frame(width: 52, height: 52)
                    .overlay(
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                    )
            }
            .accessibilityLabel(isPlaying ? "Pause" : "Play")
        }
    }

    private var progressRow: some View {
        VStack(spacing: 6) {
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.white.opacity(0.15))
                        .frame(height: 3)
                    Capsule()
                        .fill(purple)
                        .frame(width: geo.size.width * progress, height: 3)
                }
            }
            .frame(height: 3)

            HStack {
                Text("0:24")
                Spacer()
                Text(track.duration)
            }
            .font(.system(size: 11))
            .foregroundColor(.gray)
        }
        .padding(.horizontal, 12)
    }
}

#Preview {
    SoundtrackCardView(
        track: Track(title: "Dinner & Diatribes", artist: "Hozier", duration: "3:43"),
        isPlaying: .constant(false)
    )
}
