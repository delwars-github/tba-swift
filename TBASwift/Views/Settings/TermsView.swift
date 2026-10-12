import SwiftUI

struct TermsView: View {
    @Environment(\.presentationMode) var presentationMode

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

                    Text("Terms of Service")
                        .font(.custom("DMSerifDisplay-Regular", size: 20))
                        .foregroundColor(.white)

                    Spacer()

                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 16)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        section(number: "1", title: "Acceptance of Terms", bodyText: "By accessing and using this application, you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to these terms, please do not use this service.")

                        section(number: "2", title: "Use License", bodyText: "Permission is granted to temporarily access the materials on this application for personal, non-commercial use only. This is the grant of a license, not a transfer of title, and under this license you may not:")
                        bulletPoint("Modify or copy the materials")
                        bulletPoint("Use the materials for any commercial purpose")
                        bulletPoint("Attempt to decompile or reverse engineer any software")
                        bulletPoint("Remove any copyright or proprietary notations")

                        section(number: "3", title: "User Accounts", bodyText: "You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account.")

                        section(number: "4", title: "Content Standards", bodyText: "Users must not post content that is illegal, harmful, threatening, abusive, harassing, defamatory, vulgar, obscene, or otherwise objectionable. We reserve the right to remove any content that violates these standards.")

                        section(number: "5", title: "Termination", bodyText: "We may terminate or suspend your account immediately, without prior notice or liability, for any reason, including without limitation if you breach the Terms.")

                        section(number: "6", title: "Changes to Terms", bodyText: "We reserve the right to modify these terms at any time. We will notify users of any material changes via email or through the application.")
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func section(number: String, title: String, bodyText: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("\(number). \(title)")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 8)
            Text(bodyText)
                .font(.system(size: 13))
                .foregroundColor(Color.white.opacity(0.8))
                .lineSpacing(4)
        }
    }

    private func bulletPoint(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .foregroundColor(Color.white.opacity(0.8))
            Text(text)
                .font(.system(size: 13))
                .foregroundColor(Color.white.opacity(0.8))
                .lineSpacing(4)
        }
        .padding(.leading, 8)
    }
}

