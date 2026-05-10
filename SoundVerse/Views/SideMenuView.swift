import SwiftUI

struct SideMenuView: View {
    @Binding var isShowing: Bool

    private let bgColor = Color.soundVerseMenuBackground
    private let purple = Color.soundVersePurple

    private let menuItems: [(icon: String, label: String)] = [
        ("questionmark.circle.fill", "Help"),
        ("music.note.list", "Library"),
        ("gearshape.fill", "Settings"),
    ]

    var body: some View {
        GeometryReader { proxy in
            let menuWidth = proxy.size.width * 0.75

            ZStack(alignment: .leading) {
                if isShowing {
                    Color.black.opacity(0.45)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) { isShowing = false }
                        }
                }

                HStack(spacing: 0) {
                    menuContent
                        .frame(width: menuWidth)
                        .background(bgColor.ignoresSafeArea())
                        .offset(x: isShowing ? 0 : -menuWidth)
                        .animation(.easeInOut(duration: 0.3), value: isShowing)

                    Spacer()
                }
            }
        }
    }

    private var menuContent: some View {
        VStack(alignment: .leading, spacing: 0) {
            profileHeader
                .padding(.top, 60)
                .padding(.horizontal, 20)
                .padding(.bottom, 28)

            Divider()
                .background(Color.white.opacity(0.08))

            VStack(spacing: 4) {
                ForEach(menuItems, id: \.label) { item in
                    menuRow(icon: item.icon, label: item.label)
                }
            }
            .padding(.top, 12)
            .padding(.horizontal, 12)

            Spacer()

            HStack(spacing: 10) {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.system(size: 16))
                    .foregroundStyle(.gray)
                Text("Sign Out")
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
    }

    private var profileHeader: some View {
        HStack(spacing: 14) {
            Circle()
                .fill(purple.opacity(0.3))
                .frame(width: 54, height: 54)
                .overlay(
                    Image(systemName: "person.fill")
                        .foregroundStyle(purple)
                        .font(.system(size: 22))
                )

            VStack(alignment: .leading, spacing: 3) {
                Text("Shreya")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                Text("@indie_blue")
                    .font(.system(size: 13))
                    .foregroundStyle(.gray)
            }
        }
    }

    private func menuRow(icon: String, label: String) -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.3)) { isShowing = false }
        } label: {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundStyle(purple)
                    .frame(width: 24)
                Text(label)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 14)
        }
    }
}

#Preview {
    ZStack {
        Color.soundVerseBackground.ignoresSafeArea()
        SideMenuView(isShowing: .constant(true))
    }
}
