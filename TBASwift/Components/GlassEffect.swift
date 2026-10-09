import SwiftUI

// MARK: - Native iOS 26 Liquid Glass Modifiers
public extension View {
    @ViewBuilder
    func realGlass(
        cornerRadius: CGFloat = 32,
        fillOpacity: Double = 0.03, 
        strokeOpacity: Double = 0.05, 
        hasShadow: Bool = true,
        shadowRadius: CGFloat = 34.8,
        shadowY: CGFloat = 23,
        lineWidth: CGFloat = 0.50,
        strokeColor: Color = Color.white.opacity(0.05)
    ) -> some View {
        if #available(iOS 26.0, *) {
            self.glassEffect(
                .clear,
                in: RoundedRectangle(cornerRadius: cornerRadius)
            )
        } else {
            self
                .background(Color.white.opacity(fillOpacity * 0.35))
                .background(.ultraThinMaterial.opacity(0.025))
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .shadow(
                    color: Color.black.opacity(hasShadow ? 0.13 : 0.0),
                    radius: hasShadow ? shadowRadius : 0,
                    x: 0,
                    y: hasShadow ? shadowY : 0
                )
        }
    }

    func glassCard(
        cornerRadius: CGFloat = 32,
        fillOpacity: Double = 0.03,
        strokeOpacity: Double = 0.05,
        hasShadow: Bool = true,
        lineWidth: CGFloat = 0.50,
        strokeColor: Color = Color.white.opacity(0.05)
    ) -> some View {
        self.realGlass(
            cornerRadius: cornerRadius,
            fillOpacity: fillOpacity,
            strokeOpacity: strokeOpacity,
            hasShadow: hasShadow,
            shadowRadius: 34.8,
            shadowY: 23,
            lineWidth: lineWidth,
            strokeColor: strokeColor
        )
    }

    @ViewBuilder
    func glassPill(
        fillOpacity: Double = 0.03,
        strokeOpacity: Double = 0.05,
        hasShadow: Bool = false,
        lineWidth: CGFloat = 0.50
    ) -> some View {
        if #available(iOS 26.0, *) {
            self.glassEffect(.clear, in: Capsule())
        } else {
            self
                .background(Color.white.opacity(fillOpacity * 0.35))
                .background(.ultraThinMaterial.opacity(0.025))
                .clipShape(Capsule())
                .shadow(
                    color: Color.black.opacity(hasShadow ? 0.13 : 0.0),
                    radius: hasShadow ? 24 : 0,
                    x: 0,
                    y: hasShadow ? 12 : 0
                )
        }
    }
}

// MARK: - GlassButtonStyle
public struct GlassButtonStyle: ButtonStyle {
    public var scaleAmount: CGFloat = 0.96

    public init(scaleAmount: CGFloat = 0.96) {
        self.scaleAmount = scaleAmount
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
            .opacity(configuration.isPressed ? 0.88 : 1.0)
            .animation(.spring(response: 0.28, dampingFraction: 0.72), value: configuration.isPressed)
    }
}
