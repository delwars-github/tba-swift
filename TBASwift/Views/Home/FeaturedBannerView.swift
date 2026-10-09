import SwiftUI

struct FeaturedBannerView: View {
    var banners: [BannerItem] = MockData.banners

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(banners) { banner in
                    BannerCard(banner: banner)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

private struct BannerCard: View {
    let banner: BannerItem

    var body: some View {
        ZStack {
            // Background image with heavy blur & warm glass tint
            Image(banner.imageName)
                .resizable()
                .scaledToFill()
                .blur(radius: 10)
                .overlay(Color(hex: "231D0C").opacity(0.50))
                .overlay(Color.black.opacity(0.20))

            // Card content
            HStack(alignment: .center) {
                Text(banner.title)
                    .font(.system(size: 22, weight: .regular, design: .serif))
                    .foregroundColor(.white)
                    .lineLimit(1)

                Spacer()

                HStack(spacing: 7) {
                    Image("calendar-love-icon")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 17, height: 17)
                        .foregroundColor(.white.opacity(0.85))

                    VStack(alignment: .leading, spacing: 1) {
                        let parts = banner.date.components(separatedBy: ", ")
                        Text(parts.prefix(2).joined(separator: ", ") + ",")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.white.opacity(0.85))
                        if parts.count >= 3 {
                            Text(parts[2])
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(.white.opacity(0.85))
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 22)
        }
        .frame(width: 320, height: 86)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(
                    LinearGradient(
                        stops: [
                            .init(color: Color.white.opacity(0.35), location: 0.0),
                            .init(color: Color.white.opacity(0.10), location: 0.35),
                            .init(color: Color.white.opacity(0.04), location: 0.65),
                            .init(color: Color.white.opacity(0.25), location: 1.0)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1.2
                )
        )
        .shadow(color: .black.opacity(0.35), radius: 10, x: 0, y: 5)
    }
}
