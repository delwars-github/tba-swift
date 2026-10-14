import SwiftUI

enum TabItemType: Int, CaseIterable {
    case myEvent = 0
    case home = 1
    case profile = 2

    var title: String {
        switch self {
        case .myEvent: return "My Event"
        case .home: return "Home"
        case .profile: return "Profile"
        }
    }

    var inactiveIconName: String {
        switch self {
        case .myEvent: return "event-icon"
        case .home: return "home-icon"
        case .profile: return "user-icon"
        }
    }

    var activeIconName: String {
        switch self {
        case .myEvent: return "event-active-icon"
        case .home: return "home-active-icon"
        case .profile: return "user-active-icon"
        }
    }
}

struct MainTabView: View {
    @State var selectedTab: TabItemType = .home
    @Namespace private var animationNamespace

    var body: some View {
        GlassEffectContainer {
            ZStack(alignment: .bottom) {
                // Screen Content with smooth fade & scale transition
                ZStack {
                    switch selectedTab {
                    case .home:
                        HomeView()
                            .transition(.opacity.combined(with: .scale(scale: 0.985)))
                    case .myEvent:
                        MyEventsView()
                            .transition(.opacity.combined(with: .scale(scale: 0.985)))
                    case .profile:
                        ProfileView()
                            .transition(.opacity.combined(with: .scale(scale: 0.985)))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()

                // Smooth fading dark gradient background at the bottom to mask scrolling cards
                VStack {
                    Spacer()
                    LinearGradient(
                        colors: [
                            Color.clear,
                            Color(red: 10/255, green: 13/255, blue: 20/255).opacity(0.7),
                            Color(red: 10/255, green: 13/255, blue: 20/255).opacity(0.95),
                            Color(red: 10/255, green: 13/255, blue: 20/255)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 140)
                    .allowsHitTesting(false)
                }
                .ignoresSafeArea()

                // Wide Floating Glass Tab Bar — Award Level Fluid Motion
                HStack(spacing: 0) {
                    ForEach(TabItemType.allCases, id: \.self) { tab in
                        let isSelected = selectedTab == tab

                        Button(action: {
                            withAnimation(.spring(response: 0.38, dampingFraction: 0.70)) {
                                selectedTab = tab
                            }
                        }) {
                            HStack(spacing: 8) {
                                Image(isSelected ? tab.activeIconName : tab.inactiveIconName)
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(isSelected ? Color(red: 1, green: 0.97, blue: 0.93) : Color.white.opacity(0.85))
                                    .scaleEffect(isSelected ? 1.08 : 0.96)
                                    .animation(.spring(response: 0.32, dampingFraction: 0.65), value: isSelected)

                                if isSelected {
                                    Text(tab.title)
                                        .font(.custom("BricolageGrotesque-Medium", size: 16))
                                        .foregroundColor(Color(red: 1, green: 0.97, blue: 0.93))
                                        .lineLimit(1)
                                        .fixedSize(horizontal: true, vertical: false)
                                        .transition(.asymmetric(
                                            insertion: .opacity.combined(with: .scale(scale: 0.88)),
                                            removal: .opacity
                                        ))
                                }
                            }
                            .padding(EdgeInsets(top: 12, leading: isSelected ? 16 : 0, bottom: 12, trailing: isSelected ? 16 : 0))
                            .background(
                                ZStack {
                                    if isSelected {
                                        RoundedRectangle(cornerRadius: 32)
                                            .fill(
                                                LinearGradient(
                                                    colors: [
                                                        Color(red: 0.72, green: 0.36, blue: 0.24),
                                                        Color(red: 0.60, green: 0.28, blue: 0.18)
                                                    ],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                            )
                                            .matchedGeometryEffect(id: "ACTIVE_TAB_PILL", in: animationNamespace)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 32)
                                                    .inset(by: 0.50)
                                                    .stroke(Color.white.opacity(0.22), lineWidth: 0.75)
                                            )
                                            .shadow(
                                                color: Color(red: 0.68, green: 0.28, blue: 0.19).opacity(0.40),
                                                radius: 18, y: 8
                                            )
                                    }
                                }
                            )
                        }
                        .buttonStyle(GlassInteractiveButtonStyle(scaleAmount: 0.92))
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                .frame(width: 300)
                .background(Color.white.opacity(0.01))
                .realGlass(
                    cornerRadius: 32,
                    hasShadow: false,
                    lineWidth: 0.0
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .inset(by: 0.50)
                        .stroke(Color.white.opacity(0.12), lineWidth: 0.75)
                )
                .shadow(
                    color: Color.black.opacity(0.35), radius: 34.80, y: 23
                )
                .glassShimmer(duration: 4.5, delay: 2.0)
                .glassBorderGlow(cornerRadius: 32, duration: 5)
                .padding(.bottom, 24)
            }
            .ignoresSafeArea()
        }
    }
}
