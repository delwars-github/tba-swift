import SwiftUI

// MARK: - 1. Glass Interactive Button Style (Fluid Compression & Spring Feedback)
public struct GlassInteractiveButtonStyle: ButtonStyle {
    public var scaleAmount: CGFloat = 0.94
    public var bounceBack: Bool = true

    public init(scaleAmount: CGFloat = 0.94, bounceBack: Bool = true) {
        self.scaleAmount = scaleAmount
        self.bounceBack = bounceBack
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
            .brightness(configuration.isPressed ? 0.08 : 0.0)
            .animation(.spring(response: 0.28, dampingFraction: 0.65), value: configuration.isPressed)
    }
}

public extension ButtonStyle where Self == GlassInteractiveButtonStyle {
    static var glassInteractive: GlassInteractiveButtonStyle { GlassInteractiveButtonStyle() }
    static func glassInteractive(scale: CGFloat) -> GlassInteractiveButtonStyle {
        GlassInteractiveButtonStyle(scaleAmount: scale)
    }
}

// MARK: - 2. Specular Shimmer / Glass Light Reflection Modifier
public struct GlassShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = -1.2
    var duration: Double
    var delay: Double

    public init(duration: Double = 3.2, delay: Double = 1.0) {
        self.duration = duration
        self.delay = delay
    }

    public func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geo in
                    let width = geo.size.width
                    let height = geo.size.height

                    LinearGradient(
                        stops: [
                            .init(color: .clear, location: 0.0),
                            .init(color: Color.white.opacity(0.0), location: 0.35),
                            .init(color: Color.white.opacity(0.20), location: 0.50),
                            .init(color: Color.white.opacity(0.35), location: 0.52),
                            .init(color: Color.white.opacity(0.0), location: 0.65),
                            .init(color: .clear, location: 1.0)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .rotationEffect(.degrees(25))
                    .offset(x: phase * (width + 120))
                    .mask(content)
                    .allowsHitTesting(false)
                }
            )
            .onAppear {
                withAnimation(
                    .easeInOut(duration: duration)
                    .repeatForever(autoreverses: false)
                    .delay(delay)
                ) {
                    phase = 1.6
                }
            }
    }
}

public struct GlassBorderGlowModifier: ViewModifier {
    @State private var rotation: Double = 0
    var cornerRadius: CGFloat
    var duration: Double

    public init(cornerRadius: CGFloat = 32, duration: Double = 5) {
        self.cornerRadius = cornerRadius
        self.duration = duration
    }

    public func body(content: Content) -> some View {
        content
            .overlay {
                let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                shape.stroke(
                    AngularGradient(
                        stops: [
                            .init(color: .clear, location: 0.0),
                            .init(color: .clear, location: 0.07),
                            .init(color: Color.white.opacity(0.2), location: 0.11),
                            .init(color: Color.white.opacity(0.95), location: 0.14),
                            .init(color: Color.white.opacity(0.45), location: 0.18),
                            .init(color: .clear, location: 0.24),
                            .init(color: .clear, location: 1.0)
                        ],
                        center: .center,
                        startAngle: .degrees(rotation),
                        endAngle: .degrees(rotation + 360)
                    ),
                    lineWidth: 1.5
                )
                .allowsHitTesting(false)
            }
            .onAppear {
                withAnimation(.linear(duration: duration).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }
    }
}

// MARK: - 3. Staggered On-Appear Entrance Modifier
public struct GlassStaggerEntranceModifier: ViewModifier {
    var index: Int
    var delayOffset: Double
    @State private var isVisible = false

    public init(index: Int = 0, delayOffset: Double = 0.06) {
        self.index = index
        self.delayOffset = delayOffset
    }

    public func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0)
            .offset(y: isVisible ? 0 : 20)
            .scaleEffect(isVisible ? 1.0 : 0.95)
            .onAppear {
                withAnimation(.spring(response: 0.45, dampingFraction: 0.78).delay(Double(index) * delayOffset)) {
                    isVisible = true
                }
            }
    }
}

// MARK: - 4. Lottie "Like" (Vijp6qJVb8) Celebration Animation
public struct HeartCelebrationBurstView: View {
    @Binding var isTriggered: Bool
    @State private var animProgress: CGFloat = 0.0

    // Exact color from Lottie specification (#FF3144)
    private let lottieRed = Color(red: 1.0, green: 0.192, blue: 0.267)

    public init(isTriggered: Binding<Bool>) {
        self._isTriggered = isTriggered
    }

    public var body: some View {
        ZStack {
            // Layer 1: Lottie Shockwave Explosion Ring (Radius 0 -> 44, Stroke 10 -> 0)
            if animProgress > 0 && animProgress < 0.75 {
                let ringProgress = min(1.0, animProgress / 0.65)
                Circle()
                    .stroke(
                        lottieRed,
                        lineWidth: max(0.5, (1.0 - ringProgress) * 7.0)
                    )
                    .frame(width: 8 + ringProgress * 42, height: 8 + ringProgress * 42)
                    .opacity(Double(1.0 - ringProgress * 0.7))
            }

            // Layer 2: 8 Radial Sparkle Dots from Lottie Repeater (45-degree intervals)
            if animProgress > 0 && animProgress < 0.90 {
                let dotProgress = min(1.0, animProgress / 0.78)
                let distance = 6.0 + dotProgress * 23.0
                let dotScale: CGFloat = dotProgress < 0.35 ? (dotProgress / 0.35) : max(0.0, (1.0 - dotProgress) / 0.65)

                ForEach(0..<8, id: \.self) { index in
                    let angle = Double(index) * (Double.pi / 4.0)
                    let x = cos(angle) * distance
                    let y = sin(angle) * distance

                    Circle()
                        .fill(lottieRed)
                        .frame(width: 4.2, height: 4.2)
                        .scaleEffect(dotScale)
                        .offset(x: x, y: y)
                }
            }
        }
        .allowsHitTesting(false)
        .onChange(of: isTriggered) { newValue in
            if newValue {
                animProgress = 0.0
                // Lottie 22 frames @ 25fps = 0.88s duration (main burst active in first 0.5s)
                withAnimation(.easeOut(duration: 0.56)) {
                    animProgress = 1.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.60) {
                    animProgress = 0.0
                    isTriggered = false
                }
            }
        }
    }
}

// MARK: - View Extension Shortcuts
public extension View {
    func glassShimmer(duration: Double = 3.5, delay: Double = 1.2) -> some View {
        self.modifier(GlassShimmerModifier(duration: duration, delay: delay))
    }

    func glassBorderGlow(cornerRadius: CGFloat = 32, duration: Double = 5) -> some View {
        self.modifier(GlassBorderGlowModifier(cornerRadius: cornerRadius, duration: duration))
    }

    func glassStagger(index: Int, delayOffset: Double = 0.06) -> some View {
        self.modifier(GlassStaggerEntranceModifier(index: index, delayOffset: delayOffset))
    }
}

