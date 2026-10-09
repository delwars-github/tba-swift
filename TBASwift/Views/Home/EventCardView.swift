import SwiftUI

struct EventCardView: View {
    let event: EventItem

    init(event: EventItem) {
        self.event = event
    }

    var body: some View {
        ZStack {
            // Background event image
            Image(event.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 420)
                .clipped()

            // Dark warm gradient overlay matching the photo
            LinearGradient(
                stops: [
                    .init(color: .clear, location: 0.20),
                    .init(color: Color(red: 35/255, green: 29/255, blue: 12/255).opacity(0.55), location: 0.50),
                    .init(color: Color(red: 48/255, green: 38/255, blue: 15/255).opacity(0.85), location: 0.72),
                    .init(color: Color(red: 87/255, green: 56/255, blue: 20/255), location: 1.0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            // Top action buttons (Circular Real Glass)
            VStack {
                HStack {
                    CircularGlassButton(
                        systemIcon: "heart.fill",
                        iconSize: 18,
                        size: 46
                    )

                    Spacer()

                    CircularGlassButton(
                        assetIcon: "arrow-ul-icon",
                        iconSize: 18,
                        size: 46
                    )
                }
                .padding(.horizontal, 18)
                .padding(.top, 18)

                Spacer()

                // Bottom event details & facepile
                VStack(spacing: 8) {
                    // Joined count & Facepile
                    VStack(spacing: 6) {
                        Text("+\(event.joined) Joined")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                            .tracking(0.3)

                        AvatarFacepileView()
                    }
                    .padding(.bottom, 4)

                    // Event Title
                    Text(event.title)
                        .font(.system(size: 28, weight: .regular, design: .serif))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .tracking(0.5)

                    // Date & Time
                    HStack(spacing: 6) {
                        Image("calendar-love-icon")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color.white.opacity(0.85))

                        Text(event.date)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color.white.opacity(0.9))
                    }

                    // Location
                    HStack(spacing: 6) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 13))
                            .foregroundColor(Color.white.opacity(0.85))

                        Text(event.location)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color.white.opacity(0.9))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }
        }
        .frame(width: 300, height: 420)
        .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .stroke(
                    LinearGradient(
                        stops: [
                            .init(color: Color.white.opacity(0.40), location: 0.0),
                            .init(color: Color.white.opacity(0.10), location: 0.4),
                            .init(color: Color.white.opacity(0.05), location: 0.7),
                            .init(color: Color.white.opacity(0.25), location: 1.0)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1.2
                )
        )
        .shadow(color: .black.opacity(0.4), radius: 18, x: 0, y: 10)
    }
}

/// Overlapping photo avatars matching user's photo exactly
private struct AvatarFacepileView: View {
    let images = ["j1", "j2", "j3", "j4", "j5"]

    private func size(for index: Int) -> CGFloat {
        switch index {
        case 2: return 36 // Center avatar is largest
        case 1, 3: return 30
        default: return 24
        }
    }

    var body: some View {
        HStack(spacing: -10) {
            ForEach(0..<5, id: \.self) { i in
                let s = size(for: i)
                Image(images[i])
                    .resizable()
                    .scaledToFill()
                    .frame(width: s, height: s)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 1.5)
                    )
                    .zIndex(Double(3 - abs(i - 2)))
            }
        }
    }
}
