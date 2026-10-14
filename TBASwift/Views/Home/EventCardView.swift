import SwiftUI

struct EventCardView: View {
    @EnvironmentObject var router: AppRouter
    let event: EventItem

    @State private var isLiked: Bool
    @State private var heartScale: CGFloat = 1.0
    @State private var showCelebration: Bool = false
    @State private var arrowOffset: CGSize = .zero

    init(event: EventItem, isInitiallyLiked: Bool = false) {
        self.event = event
        self._isLiked = State(initialValue: isInitiallyLiked)
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

            // Top action buttons (Circular Real Glass with Animations)
            VStack {
                HStack {
                    // 1. Heart Button with Lottie "Like" & 5 Likers Avatars Bounce Burst
                    ZStack {
                        CircularGlassButton(
                            systemIcon: "heart.fill",
                            iconColor: isLiked ? Color(red: 1.0, green: 0.192, blue: 0.267) : .white,
                            iconSize: 18,
                            iconScale: heartScale,
                            size: 46,
                            action: {
                                let generator = UINotificationFeedbackGenerator()
                                generator.notificationOccurred(.success)

                                if !isLiked {
                                    // Lottie Like sequence:
                                    // Frame 0..2: Anticipation shrink to 0.60
                                    withAnimation(.easeIn(duration: 0.08)) {
                                        heartScale = 0.60
                                    }
                                    // Frame 2..7: Trigger explosion ring + 8 dots & 5 likers avatars pop
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
                                        isLiked = true
                                        showCelebration = true
                                        withAnimation(.spring(response: 0.22, dampingFraction: 0.52)) {
                                            heartScale = 1.30
                                        }
                                    }
                                    // Frame 7..14..19: Elastic settle
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) {
                                        withAnimation(.spring(response: 0.26, dampingFraction: 0.65)) {
                                            heartScale = 1.0
                                        }
                                    }
                                } else {
                                    // Unlike: Smooth spring bounce back to white
                                    withAnimation(.spring(response: 0.22, dampingFraction: 0.65)) {
                                        isLiked = false
                                        heartScale = 0.82
                                    }
                                    withAnimation(.spring(response: 0.28, dampingFraction: 0.70).delay(0.10)) {
                                        heartScale = 1.0
                                    }
                                }
                            }
                        )

                        // Lottie celebration burst
                        HeartCelebrationBurstView(isTriggered: $showCelebration)

                        // Last 5 likers user avatars bouncing out around the heart
                        HeartLikersBurstView(isTriggered: $showCelebration)
                    }

                    Spacer()

                    // 2. Arrow Button with Press Animation & Details Navigation (Exact Original Glass Effect)
                    CircularGlassButton(
                        assetIcon: "arrow-ul-icon",
                        iconSize: 18,
                        size: 46,
                        action: {
                            let generator = UIImpactFeedbackGenerator(style: .light)
                            generator.impactOccurred()

                            withAnimation(.spring(response: 0.20, dampingFraction: 0.55)) {
                                arrowOffset = CGSize(width: 3.0, height: -3.0)
                            }

                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.16) {
                                withAnimation(.spring(response: 0.28, dampingFraction: 0.65)) {
                                    arrowOffset = .zero
                                }
                                router.selectedEvent = event
                                withAnimation(.spring(response: 0.38, dampingFraction: 0.78)) {
                                    router.navigationPath.append("EventDetails")
                                }
                            }
                        }
                    )
                    .offset(arrowOffset)
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
                .contentShape(Rectangle())
                .onTapGesture {
                    router.selectedEvent = event
                    withAnimation(.spring(response: 0.38, dampingFraction: 0.78)) {
                        router.navigationPath.append("EventDetails")
                    }
                }
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

// MARK: - Last 5 Likers Avatars Bounce Burst
private struct HeartLikersBurstView: View {
    @Binding var isTriggered: Bool
    @State private var isVisible: Bool = false
    @State private var animProgress: CGFloat = 0.0

    // 5 dummy liker avatar images from assets
    private let likerImages = ["j1", "j2", "j3", "j4", "j5"]

    // Full 360-degree radial coverage around the heart button:
    // Staggered distances: ekta ektu kache, ekta ektu dure (alternating radius ~34pt vs ~52pt)
    // Angles distributed across top-right, right/bottom-right, bottom/bottom-left, left, and top-left.
    private let avatarConfig: [(x: CGFloat, y: CGFloat, size: CGFloat, delay: Double)] = [
        // 1. Top-Right (closer ~35pt radius): x: 20, y: -29
        (x: 20,  y: -36, size: 25, delay: 0.00),
        // 2. Right (further ~52pt radius): x: 50, y: 12
        (x: 50,  y: 12,  size: 24, delay: 0.03),
        // 3. Bottom-Left / Bottom (closer ~36pt radius): x: -4, y: 36
        (x: -4,  y: 36,  size: 24, delay: 0.06),
        // 4. Far Left (further ~46pt radius): x: -35, y: 8
        (x: -35, y: 8,   size: 27, delay: 0.02),
        // 5. Top-Left (closer ~32pt radius): x: -18, y: -26
        (x: -18, y: -26, size: 24, delay: 0.05)
    ]

    var body: some View {
        ZStack {
            if isVisible {
                ForEach(0..<5, id: \.self) { index in
                    let config = avatarConfig[index]
                    let targetX = config.x * animProgress
                    let targetY = config.y * animProgress

                    Image(likerImages[index])
                        .resizable()
                        .scaledToFill()
                        .frame(width: config.size, height: config.size)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 1.5)
                        )
                        .shadow(color: Color.black.opacity(0.45), radius: 4, x: 0, y: 2)
                        .scaleEffect(animProgress < 0.85 ? (animProgress * 1.18) : 1.0)
                        .offset(x: targetX, y: targetY)
                        .opacity(Double(min(1.0, animProgress * 1.5)))
                }
            }
        }
        .allowsHitTesting(false)
        .onChange(of: isTriggered) { newValue in
            if newValue {
                isVisible = true
                animProgress = 0.0

                // 1. Elastic bounce eruption out from the heart covering all 360 degrees
                withAnimation(.spring(response: 0.40, dampingFraction: 0.56)) {
                    animProgress = 1.0
                }

                // 2. Keep visible for users to admire, then smoothly collapse/fade out
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                    withAnimation(.easeOut(duration: 0.35)) {
                        animProgress = 0.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.36) {
                        isVisible = false
                    }
                }
            }
        }
    }
}
