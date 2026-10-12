import SwiftUI

struct LinkedAccountsView: View {
    @Environment(\.presentationMode) var presentationMode

    struct SocialAccount: Identifiable {
        let id = UUID()
        let name: String
        let email: String
        let icon: String
    }

    let accounts = [
        SocialAccount(name: "Google", email: "sarah.68@gmail.com", icon: "envelope.fill"),
        SocialAccount(name: "Facebook", email: "sarah.mitchell", icon: "person.2.fill"),
        SocialAccount(name: "Instagram", email: "sarah.instagram", icon: "camera.fill")
    ]

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

                    Text("Linked Accounts")
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
                        // Info banner
                        HStack(alignment: .top, spacing: 10) {
                            Text("💡")
                                .font(.system(size: 16))
                            Text("Connect your social accounts for easier sign-in and to enhance your profile.")
                                .font(.system(size: 13))
                                .foregroundColor(Color.white.opacity(0.9))
                                .lineSpacing(4)
                        }
                        .padding(16)
                        .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)

                        Text("Connected Accounts")
                            .font(.custom("DMSerifDisplay-Regular", size: 16))
                            .foregroundColor(.white)
                            .padding(.leading, 4)

                        // Accounts list
                        VStack(spacing: 0) {
                            ForEach(Array(accounts.enumerated()), id: \.element.id) { index, item in
                                HStack {
                                    Image(systemName: item.icon)
                                        .font(.system(size: 18))
                                        .foregroundColor(.white)
                                        .frame(width: 40, height: 40)
                                        .realGlass(cornerRadius: 20, strokeOpacity: 0.65, lineWidth: 1.2)

                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(item.name)
                                            .font(.system(size: 15, weight: .medium))
                                            .foregroundColor(.white)
                                        Text(item.email)
                                            .font(.system(size: 13))
                                            .foregroundColor(Color.white.opacity(0.7))
                                    }
                                    .padding(.leading, 8)

                                    Spacer()

                                    Button(action: {}) {
                                        Text("Disconnect")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(Color.white.opacity(0.9))
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 7)
                                            .realGlass(cornerRadius: 14, strokeOpacity: 0.65, lineWidth: 1.0)
                                    }
                                }
                                .padding(.vertical, 14)

                                if index < accounts.count - 1 {
                                    Divider().background(Color.white.opacity(0.1))
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)

                        // Link new account button
                        Button(action: {}) {
                            HStack(spacing: 6) {
                                Image(systemName: "plus")
                                    .font(.system(size: 14, weight: .semibold))
                                Text("Link New Account")
                                    .font(.system(size: 14, weight: .medium))
                            }
                            .foregroundColor(Color(hex: "#FFB162"))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

