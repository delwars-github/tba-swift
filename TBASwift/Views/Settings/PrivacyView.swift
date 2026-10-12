import SwiftUI

struct PrivacyView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var visibility = "public"
    @State private var showOnlineStatus = true
    @State private var showLocation = false
    @State private var messaging = "everyone"
    @State private var personalizedExp = true
    @State private var analytics = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#FFB162"), Color(hex: "#A35139"), Color(hex: "#1A2534"), Color(hex: "#1A2534")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .realGlass(cornerRadius: 18, strokeOpacity: 0.65, lineWidth: 1.2)
                    }

                    Spacer()

                    Text("Privacy Settings")
                        .font(.custom("DMSerifDisplay-Regular", size: 20))
                        .foregroundColor(.white)

                    Spacer()

                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 16)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Profile Visibility
                        sectionHeader("Profile Visibility")
                        VStack(spacing: 0) {
                            radioItem(title: "Public", subtitle: "Anyone can see your profile", isSelected: visibility == "public") {
                                visibility = "public"
                            }
                            Divider().background(Color.white.opacity(0.1))
                            radioItem(title: "Members Only", subtitle: "Only registered members can view", isSelected: visibility == "members") {
                                visibility = "members"
                            }
                            Divider().background(Color.white.opacity(0.1))
                            radioItem(title: "Private", subtitle: "Only people you approve can see", isSelected: visibility == "private") {
                                visibility = "private"
                            }
                        }
                        .padding(.horizontal, 16)
                        .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)

                        // Activity & Presence
                        sectionHeader("Activity & Presence")
                        VStack(spacing: 0) {
                            toggleItem(title: "Show Online Status", subtitle: "Let others see when you're active", isOn: $showOnlineStatus)
                            Divider().background(Color.white.opacity(0.1))
                            toggleItem(title: "Show Location", subtitle: "Display your city on your profile", isOn: $showLocation)
                        }
                        .padding(.horizontal, 16)
                        .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)

                        // Who Can Message You
                        sectionHeader("Who Can Message You")
                        VStack(spacing: 0) {
                            radioItem(title: "Everyone", subtitle: "Any member can send you message", isSelected: messaging == "everyone") {
                                messaging = "everyone"
                            }
                            Divider().background(Color.white.opacity(0.1))
                            radioItem(title: "Connections Only", subtitle: "Only your connections can message", isSelected: messaging == "connections") {
                                messaging = "connections"
                            }
                            Divider().background(Color.white.opacity(0.1))
                            radioItem(title: "No One", subtitle: "Disable all incoming messages", isSelected: messaging == "none") {
                                messaging = "none"
                            }
                        }
                        .padding(.horizontal, 16)
                        .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)

                        // Data & Privacy
                        sectionHeader("Data & Privacy")
                        VStack(spacing: 0) {
                            toggleItem(title: "Personalized Experience", subtitle: "Use my data to improve recommendations", isOn: $personalizedExp)
                            Divider().background(Color.white.opacity(0.1))
                            toggleItem(title: "Analytics & Performance", subtitle: "Help us improve with usage data", isOn: $analytics)
                        }
                        .padding(.horizontal, 16)
                        .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)

                        // Download Data Button
                        Button(action: {}) {
                            Text("Download My Data")
                                .font(.custom("DMSerifDisplay-Regular", size: 15))
                                .foregroundColor(Color(hex: "#FFB162"))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .realGlass(cornerRadius: 28, strokeOpacity: 0.65, lineWidth: 1.2)
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 30)
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.custom("DMSerifDisplay-Regular", size: 15))
            .foregroundColor(Color(hex: "#FFB162"))
            .padding(.leading, 4)
    }

    private func radioItem(title: String, subtitle: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(Color.white.opacity(0.6))
                }
                Spacer()
                ZStack {
                    Circle()
                        .stroke(isSelected ? Color(hex: "#FFAC4F") : Color.white.opacity(0.3), lineWidth: 2)
                        .frame(width: 20, height: 20)
                    if isSelected {
                        Circle()
                            .fill(Color(hex: "#FFAC4F"))
                            .frame(width: 10, height: 10)
                    }
                }
            }
            .padding(.vertical, 14)
        }
    }

    private func toggleItem(title: String, subtitle: String, isOn: Binding<Bool>) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(Color.white.opacity(0.6))
            }
            Spacer()
            Toggle("", isOn: isOn)
                .labelsHidden()
                .tint(Color(hex: "#FFAC4F"))
        }
        .padding(.vertical, 14)
    }
}

