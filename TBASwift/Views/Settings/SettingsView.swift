import SwiftUI

struct SettingsItem: View {
    var iconName: String
    var title: String
    var subtitle: String?
    var isLast: Bool = false
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 0) {
                HStack(spacing: 16) {
                    // Icon inside a glass button style
                    Image(systemName: iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .realGlass(cornerRadius: 20, strokeOpacity: 0.65, lineWidth: 1.2)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                        if let subtitle = subtitle {
                            Text(subtitle)
                                .font(.system(size: 11))
                                .foregroundColor(Color.white.opacity(0.6))
                        }
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20))
                        .foregroundColor(Color.white.opacity(0.4))
                }
                .padding(.vertical, 16)
                
                if !isLast {
                    Divider()
                        .background(Color.white.opacity(0.1))
                        .padding(.leading, 56) // 40 (icon) + 16 (spacing)
                }
            }
        }
    }
}

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var router: AppRouter
    @State private var isLogoutModalVisible = false
    
    var body: some View {
        ZStack {
            // Background Gradient
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
                    
                    Text("Settings")
                        .font(.custom("DMSerifDisplay-Regular", size: 20))
                        .foregroundColor(.white)
                        .tracking(0.5)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 16)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        // Account Section
                        Text("Account")
                            .font(.custom("DMSerifDisplay-Regular", size: 16))
                            .foregroundColor(.white)
                            .tracking(0.5)
                            .padding(.bottom, 12)
                            .padding(.top, 16)
                        
                        VStack(spacing: 0) {
                            SettingsItem(
                                iconName: "person.circle",
                                title: "Account Settings",
                                subtitle: "Personal info, account status",
                                action: { router.navigationPath.append("EditProfile") }
                            )
                            SettingsItem(
                                iconName: "creditcard",
                                title: "Payment Info",
                                subtitle: "Manage payment methods",
                                action: { router.navigationPath.append("Payment") }
                            )
                            SettingsItem(
                                iconName: "link",
                                title: "Linked Accounts",
                                subtitle: "Connected social account",
                                isLast: true,
                                action: {}
                            )
                        }
                        .padding(.horizontal, 16)
                        .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)
                        .padding(.bottom, 24)
                        
                        // Privacy & Legal Section
                        Text("Privacy & Legal")
                            .font(.custom("DMSerifDisplay-Regular", size: 16))
                            .foregroundColor(.white)
                            .tracking(0.5)
                            .padding(.bottom, 12)
                        
                        VStack(spacing: 0) {
                            SettingsItem(
                                iconName: "lock.shield",
                                title: "Privacy",
                                subtitle: "Profile visibility, data usage",
                                action: {}
                            )
                            SettingsItem(
                                iconName: "doc.text",
                                title: "Terms & Policy",
                                subtitle: "Privacy policy, terms of service",
                                action: {}
                            )
                            SettingsItem(
                                iconName: "trash",
                                title: "Delete Account",
                                subtitle: "Permanently remove your account",
                                isLast: true,
                                action: {}
                            )
                        }
                        .padding(.horizontal, 16)
                        .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)
                        .padding(.bottom, 32)
                        
                        // Log Out Button
                        Button(action: {
                            isLogoutModalVisible = true
                        }) {
                            HStack(spacing: 8) {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                Text("Log Out")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(Color(hex: "#FFB162"))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)
                        }
                        .padding(.bottom, 40)
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
        .navigationBarHidden(true)
        .overlay(
            // Logout Modal placeholder
            Group {
                if isLogoutModalVisible {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            isLogoutModalVisible = false
                        }
                    
                    // Simple Modal UI
                    VStack(spacing: 24) {
                        Text("Are you sure you want to log out?")
                            .font(.custom("DMSerifDisplay-Regular", size: 18))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                        
                        HStack(spacing: 16) {
                            Button("Cancel") {
                                isLogoutModalVisible = false
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            
                            Button("Log Out") {
                                isLogoutModalVisible = false
                                router.isAuthenticated = false
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color(hex: "#FF7B7B"))
                            .cornerRadius(12)
                            .foregroundColor(.white)
                        }
                    }
                    .padding(24)
                    .realGlass(cornerRadius: 24, strokeOpacity: 0.65, lineWidth: 1.2)
                    .padding(.horizontal, 40)
                }
            }
        )
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

