import SwiftUI

struct UltraRealisticGlassModifier: ViewModifier {
    var cornerRadius: CGFloat
    var hasShadow: Bool
    var shadowRadius: CGFloat
    var shadowY: CGFloat
    var lineWidth: CGFloat
    var strokeColor: Color

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(Color.white.opacity(0.03))
                    .background(.ultraThinMaterial)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(
                        LinearGradient(
                            stops: [
                                .init(color: .white.opacity(0.6), location: 0),
                                .init(color: .white.opacity(0.1), location: 0.2),
                                .init(color: .white.opacity(0.0), location: 0.5),
                                .init(color: .black.opacity(0.2), location: 0.8),
                                .init(color: .black.opacity(0.5), location: 1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: lineWidth
                    )
            )
            // inner glow
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(Color.white.opacity(0.2), lineWidth: 0.5)
                    .blendMode(.overlay)
            )
            .shadow(
                color: Color.black.opacity(hasShadow ? 0.15 : 0.0),
                radius: hasShadow ? shadowRadius : 0,
                x: 0,
                y: hasShadow ? shadowY : 0
            )
    }
}
