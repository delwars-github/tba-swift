import SwiftUI

// MARK: - GlassButton

struct GlassButton: View {
    var title: String?
    var systemIcon: String?
    var assetIcon: String?
    var iconColor: Color = .white
    var iconSize: CGFloat = 18
    var cornerRadius: CGFloat = 18
    var paddingHorizontal: CGFloat = 14
    var paddingVertical: CGFloat = 10
    var strokeOpacity: Double = 0.65
    var hasBadge: Bool = false
    var badgeColor: Color = Color(red: 1, green: 0.69, blue: 0.38)
    var action: () -> Void

    init(
        title: String? = nil,
        systemIcon: String? = nil,
        assetIcon: String? = nil,
        iconColor: Color = .white,
        iconSize: CGFloat = 18,
        cornerRadius: CGFloat = 18,
        paddingHorizontal: CGFloat = 14,
        paddingVertical: CGFloat = 10,
        strokeOpacity: Double = 0.65,
        hasBadge: Bool = false,
        badgeColor: Color = Color(red: 1, green: 0.69, blue: 0.38),
        action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.systemIcon = systemIcon
        self.assetIcon = assetIcon
        self.iconColor = iconColor
        self.iconSize = iconSize
        self.cornerRadius = cornerRadius
        self.paddingHorizontal = paddingHorizontal
        self.paddingVertical = paddingVertical
        self.strokeOpacity = strokeOpacity
        self.hasBadge = hasBadge
        self.badgeColor = badgeColor
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let assetIcon = assetIcon {
                    Image(assetIcon)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: iconSize, height: iconSize)
                        .foregroundColor(iconColor)
                } else if let systemIcon = systemIcon {
                    Image(systemName: systemIcon)
                        .font(.system(size: iconSize, weight: .semibold))
                        .foregroundColor(iconColor)
                }

                if let title = title {
                    Text(title)
                        .font(.system(size: 13, weight: .medium, design: .serif))
                        .foregroundColor(.white)
                        .tracking(0.3)
                }
            }
            .padding(.horizontal, paddingHorizontal)
            .padding(.vertical, paddingVertical)
            .realGlass(
                cornerRadius: cornerRadius,
                strokeOpacity: 0.05,
                lineWidth: 0.5
            )
        }
        .buttonStyle(GlassButtonStyle())
        .overlay(alignment: .topTrailing) {
            if hasBadge {
                Circle()
                    .fill(badgeColor)
                    .frame(width: 8, height: 8)
                    .padding(5)
                    .allowsHitTesting(false)
            }
        }
    }
}

// MARK: - CircularGlassButton

struct CircularGlassButton: View {
    var systemIcon: String?
    var assetIcon: String?
    var iconColor: Color = .white
    var iconSize: CGFloat = 16
    var iconScale: CGFloat = 1.0
    var size: CGFloat = 44
    var strokeOpacity: Double = 0.65
    var action: () -> Void = {}

    init(
        systemIcon: String? = nil,
        assetIcon: String? = nil,
        iconColor: Color = .white,
        iconSize: CGFloat = 16,
        iconScale: CGFloat = 1.0,
        size: CGFloat = 44,
        strokeOpacity: Double = 0.65,
        action: @escaping () -> Void = {}
    ) {
        self.systemIcon = systemIcon
        self.assetIcon = assetIcon
        self.iconColor = iconColor
        self.iconSize = iconSize
        self.iconScale = iconScale
        self.size = size
        self.strokeOpacity = strokeOpacity
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Group {
                if let assetIcon = assetIcon {
                    Image(assetIcon)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: iconSize, height: iconSize)
                        .foregroundColor(iconColor)
                        .scaleEffect(iconScale)
                } else if let systemIcon = systemIcon {
                    Image(systemName: systemIcon)
                        .font(.system(size: iconSize, weight: .semibold))
                        .foregroundColor(iconColor)
                        .scaleEffect(iconScale)
                }
            }
            .frame(width: size, height: size)
            .realGlass(
                cornerRadius: size / 2,
                strokeOpacity: 0.05,
                lineWidth: 0.5
            )
        }
        .buttonStyle(GlassButtonStyle())
    }
}

// MARK: - GlassTag

struct GlassTag: View {
    var title: String
    var strokeOpacity: Double = 0.65
    var action: (() -> Void)? = nil

    var body: some View {
        if let action = action {
            Button(action: action) {
                content
            }
            .buttonStyle(GlassButtonStyle())
        } else {
            content
        }
    }

    @ViewBuilder
    private var content: some View {
        Text(title)
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(.white)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .glassPill(
                fillOpacity: 0.03,
                strokeOpacity: 0.05,
                hasShadow: false,
                lineWidth: 0.5
            )
    }
}

// MARK: - MinusButton

struct MinusButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("-")
                .font(Font.custom("DMSerifDisplay-Regular", size: 31))
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 0, leading: 12, bottom: 4, trailing: 12))
                .background(Color.white.opacity(0.1))
                .cornerRadius(16)
        }
    }
}

