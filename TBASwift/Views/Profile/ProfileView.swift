import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var router: AppRouter
    let hobbies = ["Travel", "Photography", "Art", "Music", "Technology", "Sports"]

    var body: some View {
        ZStack {
            // Gradient Background matching React Native profile.tsx
            LinearGradient(
                colors: [
                    Color(hex: "FFB162"),
                    Color(hex: "A35139"),
                    Color(hex: "1A2534"),
                    Color(hex: "1A2534")
                ],
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    // Header Bar (Below Dynamic Island)
                    HStack {
                        Text("Profile")
                            .font(.system(size: 22, weight: .regular, design: .serif))
                            .foregroundColor(.white)
                            .tracking(0.5)

                        Spacer()

                        // Settings Button
                        GlassButton(
                            systemIcon: "gearshape",
                            iconColor: .white,
                            iconSize: 18,
                            cornerRadius: 16,
                            paddingHorizontal: 12,
                            paddingVertical: 12,
                            action: { router.navigationPath.append("Settings") }
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 56)

                    // Profile Info
                    VStack(spacing: 8) {
                        // Avatar with verified badge
                        ZStack(alignment: .topTrailing) {
                            Image("profile-pic")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 104, height: 104)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white.opacity(0.9), lineWidth: 2))

                            Image("pro-check-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .offset(x: 4, y: 0)
                        }

                        // Name & Age
                        HStack(alignment: .firstTextBaseline, spacing: 6) {
                            Text("M. Yearo")
                                .font(.system(size: 30, weight: .regular, design: .serif))
                                .foregroundColor(.white)
                                .tracking(0.5)

                            Text("26")
                                .font(.system(size: 13, weight: .regular, design: .serif))
                                .foregroundColor(.white.opacity(0.6))
                        }
                        .padding(.top, 4)

                        // Location
                        HStack(spacing: 4) {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.system(size: 12))
                                .foregroundColor(Color(hex: "E6E2DB"))

                            Text("74C Aaliyah River, Bayerhaven")
                                .font(.system(size: 12, design: .serif))
                                .foregroundColor(Color(hex: "E6E2DB"))
                        }

                        // Bio
                        Text("Always looking for the next great\nconversation and spontaneous road trip.✨")
                            .font(.system(size: 13, design: .serif))
                            .foregroundColor(Color(hex: "E6E2DB"))
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                            .padding(.top, 2)
                            .padding(.bottom, 6)

                        // Edit Profile Pill
                        Button(action: { router.navigationPath.append("EditProfile") }) {
                            Text("Edit Profile")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                                .padding(.horizontal, 22)
                                .padding(.vertical, 8)
                                .glassPill(fillOpacity: 0.08, strokeOpacity: 0.3)
                        }
                        .buttonStyle(GlassButtonStyle())
                    }

                    // Hobbies Section (Glass Card with pill tags)
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Hobbies")
                            .font(.system(size: 18, weight: .regular, design: .serif))
                            .foregroundColor(.white)

                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 8)], spacing: 8) {
                            ForEach(hobbies, id: \.self) { hobby in
                                GlassTag(title: hobby)
                            }
                        }
                    }
                    .padding(16)
                    .glassCard(cornerRadius: 20)
                    .padding(.horizontal, 20)

                    // Stats Row (3 Glass Cards)
                    HStack(spacing: 10) {
                        // 1. Creative
                        VStack(spacing: 8) {
                            Image("creative-icon")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                                .foregroundColor(.white)

                            Text("Creative")
                                .font(.system(size: 15, weight: .regular, design: .serif))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .frame(height: 96)
                        .glassCard(cornerRadius: 12.65, lineWidth: 0.10, strokeColor: Color(red: 1, green: 0.67, blue: 0.31))

                        // 2. Answer (Progress Circle)
                        VStack(spacing: 6) {
                            ZStack {
                                Circle()
                                    .stroke(Color(hex: "FFB162").opacity(0.2), lineWidth: 4)
                                    .frame(width: 42, height: 42)

                                Circle()
                                    .trim(from: 0, to: 0.786)
                                    .stroke(Color(hex: "FFB162"), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                                    .frame(width: 42, height: 42)
                                    .rotationEffect(.degrees(-90))

                                Text("78.6%")
                                    .font(.system(size: 9, weight: .bold))
                                    .foregroundColor(.white)
                            }

                            Text("Answer")
                                .font(.system(size: 15, weight: .regular, design: .serif))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .frame(height: 96)
                        .glassCard(cornerRadius: 12.65, lineWidth: 0.10, strokeColor: Color(red: 1, green: 0.67, blue: 0.31))

                        // 3. Earn
                                                VStack(spacing: 8) {
                                                        ZStack {
                                Image("earn-icon")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                                        }
                                                        .frame(width: 32, height: 32)
                                                        Text("Earn")
                                                                .font(.system(size: 15, weight: .regular, design: .serif))
                                                                .foregroundColor(.white)
                        }
                                                .frame(maxWidth: .infinity)
                                                .padding(.vertical, 14)
                                                .frame(height: 96)
                                                .glassCard(cornerRadius: 12.65, lineWidth: 0.10, strokeColor: Color(red: 1, green: 0.67, blue: 0.31))
                    }
                    .padding(.horizontal, 20)

                    // "Your Vibes" Terracotta Card
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your Vibes")
                            .font(.system(size: 13, weight: .regular, design: .serif))
                            .foregroundColor(.white.opacity(0.85))

                        HStack(alignment: .top, spacing: 12) {
                            Image("soul-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48, height: 48)

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Creative Soul")
                                    .font(.system(size: 16, weight: .regular, design: .serif))
                                    .foregroundColor(.white)

                                Text("You see beauty in the everyday and express yourself through creative pursuits. Your imagination knows no bounds.")
                                    .font(.system(size: 10))
                                    .lineSpacing(3)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                        }
                    }
                    .padding(16)
                    .background(Color(hex: "AE4B30"))
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(Color.white.opacity(0.18), lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
                    .padding(.horizontal, 20)

                    // Action Items: Achievements & Question Progress
                    VStack(spacing: 8) {
                        Button(action: { router.navigationPath.append("Achievements") }) {
                            HStack {
                                Text("Achievements")
                                    .font(.system(size: 14, weight: .regular, design: .serif))
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.white.opacity(0.6))
                            }
                            .padding(16)
                            .glassCard(cornerRadius: 16)
                        }

                        Button(action: {}) {
                            HStack {
                                Text("Question Progress")
                                    .font(.system(size: 14, weight: .regular, design: .serif))
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.white.opacity(0.6))
                            }
                            .padding(16)
                            .glassCard(cornerRadius: 16, fillOpacity: 0.05, strokeOpacity: 0.2)
                        }
                    }
                    .padding(.horizontal, 20)

                    // Bottom spacing for floating tab bar
                    Spacer().frame(height: 120)
                }
            }
            .ignoresSafeArea()
        }
    }
}
