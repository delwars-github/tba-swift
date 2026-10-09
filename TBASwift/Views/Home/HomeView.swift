import SwiftUI

struct HomeView: View {
    @EnvironmentObject var router: AppRouter
    @State private var showCreateModal = false
    @State private var showNotifications = false

    var body: some View {
        ZStack {
            // Background Layer
            ZStack {
                Image("home-bg")
                    .resizable()
                    .scaledToFill()

                LinearGradient(
                    stops: [
                        .init(color: .clear, location: 0.15),
                        .init(color: Color(red: 35/255, green: 29/255, blue: 12/255).opacity(0.15), location: 0.35),
                        .init(color: Color(red: 35/255, green: 29/255, blue: 12/255).opacity(0.70), location: 0.75),
                        .init(color: Color(hex: "1B2632"), location: 1.0)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
            .ignoresSafeArea()

            // Main Content ScrollView
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    // Header Bar (Respecting Status Bar & Dynamic Island)
                    HStack {
                        Image("main-logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90, height: 30)

                        Spacer()

                        // "Curate a Gathering" Glass Button
                        GlassButton(
                            title: "Curate a Gathering",
                            systemIcon: "plus",
                            iconColor: .white,
                            iconSize: 13,
                            cornerRadius: 16,
                            paddingHorizontal: 12,
                            paddingVertical: 9,
                            action: {
                                showCreateModal.toggle()
                            }
                        )

                        // Notification Glass Button
                        GlassButton(
                            assetIcon: "notification-icon",
                            iconColor: .white,
                            iconSize: 18,
                            cornerRadius: 16,
                            paddingHorizontal: 10,
                            paddingVertical: 10,
                            hasBadge: true,
                            badgeColor: Color(hex: "FFB162"),
                            action: {
                                router.navigationPath.append("Notifications")
                            }
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 56)

                    // Featured Mini Banners
                    FeaturedBannerView()
                        .padding(.top, 6)

                    // "Browse Events" Section Header
                    HStack {
                        Text("Browse Events")
                            .font(.system(size: 24, weight: .regular, design: .serif))
                            .foregroundColor(.white)
                            .tracking(0.5)

                        Spacer()

                        Button(action: {}) {
                            Image("filter-icon")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white.opacity(0.85))
                                .padding(8)
                                .glassCard(cornerRadius: 12)
                        }
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 6)

                    // Main Events Carousel
                    EventCarouselView()

                    // Bottom spacing for floating tab pill
                    Spacer().frame(height: 120)
                }
            }
            .ignoresSafeArea()
        }
    }
}
