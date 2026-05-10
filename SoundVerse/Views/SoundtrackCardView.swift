import SwiftUI

struct SoundtrackCardView: View {
    let track: Track
    @ObservedObject var playerManager: MusicPlayerManager

    private let cardColor = Color.soundVerseCard
    private let purple = Color.soundVersePurple

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
                    .foregroundStyle(.white)
                    .offset(y: -16)
            } else {
                Image(track.coverImageName)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            }
        }
        .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
        .background(RoundedRectangle(cornerRadius: 24).fill(cardColor))
    }

    private var trackInfo: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(track.title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.white)
                Text(track.artist)
                    .font(.system(size: 13))
                    .foregroundStyle(.gray)
            }
            Spacer()
            Button { playerManager.toggle() } label: {
                Circle()
                    .fill(purple)
                    .frame(width: 52, height: 52)
                    .overlay(
                        Image(systemName: playerManager.isPlaying ? "pause.fill" : "play.fill")
                            .foregroundStyle(.white)
                            .font(.system(size: 20))
                    )
            }
            .accessibilityLabel(playerManager.isPlaying ? "Pause" : "Play")
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
                        .frame(width: geo.size.width * playerManager.progress, height: 3)
                }
            }
            .frame(height: 3)

            HStack {
                Text(playerManager.elapsedTime)
                Spacer()
                Text(playerManager.durationText)
            }
            .font(.system(size: 11))
            .foregroundStyle(.gray)
        }
        .padding(.horizontal, 12)
    }
}

#Preview {
    SoundtrackCardView(
        track: Track(title: "Piano", artist: "Pixabay"),
        playerManager: MusicPlayerManager.shared
    )
}
