import SwiftUI

struct DeleteAccountDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var router: AppRouter
    @State private var selectedReason: String? = nil
    @State private var feedback: String = ""
    @State private var showConfirmDialog = false

    let reasons = [
        "I don't use this app anymore",
        "The events aren't relevant to me",
        "Found a better alternative",
        "Privacy or security concerns",
        "Too many notifications/spam",
        "Other"
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

                    Text("Delete Account")
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
                        // Info Card
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Why are you deleting the account?")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                            Text("Please tell us why you want to delete your account. It's really important to us to know the reasons!")
                                .font(.system(size: 12))
                                .foregroundColor(Color.white.opacity(0.7))
                                .lineSpacing(4)
                        }
                        .padding(16)
                        .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)

                        // Reasons List
                        VStack(spacing: 0) {
                            ForEach(Array(reasons.enumerated()), id: \.element) { index, reason in
                                Button(action: {
                                    selectedReason = reason
                                }) {
                                    HStack {
                                        Text(reason)
                                            .font(.system(size: 13, weight: .medium))
                                            .foregroundColor(.white)
                                        Spacer()
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(selectedReason == reason ? Color(hex: "#FFAC4F") : Color.white.opacity(0.2), lineWidth: 1.5)
                                                .frame(width: 22, height: 22)
                                                .background(selectedReason == reason ? Color(hex: "#FFAC4F") : Color.clear)
                                                .cornerRadius(6)
                                            if selectedReason == reason {
                                                Image(systemName: "checkmark")
                                                    .font(.system(size: 11, weight: .bold))
                                                    .foregroundColor(.white)
                                            }
                                        }
                                    }
                                    .padding(.vertical, 16)
                                    .padding(.horizontal, 16)
                                }

                                if index < reasons.count - 1 {
                                    Divider().background(Color.white.opacity(0.08))
                                }
                            }
                        }
                        .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)

                        // Additional Feedback
                        Text("Additional Feedback")
                            .font(.custom("DMSerifDisplay-Regular", size: 14))
                            .foregroundColor(.white)
                            .padding(.top, 4)

                        ZStack(alignment: .topLeading) {
                            if feedback.isEmpty {
                                Text("Start reflecting...")
                                    .foregroundColor(Color.white.opacity(0.5))
                                    .font(.system(size: 13))
                                    .padding(16)
                            }
                            TextEditor(text: $feedback)
                                .font(.system(size: 13))
                                .foregroundColor(.white)
                                .scrollContentBackground(.hidden)
                                .padding(12)
                        }
                        .frame(height: 120)
                        .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }

                Spacer()

                // Bottom Delete Button
                Button(action: {
                    showConfirmDialog = true
                }) {
                    Text("Delete Account")
                        .font(.custom("DMSerifDisplay-Regular", size: 15))
                        .foregroundColor(selectedReason != nil ? Color(hex: "#182633") : Color(hex: "#FFAC4F"))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(selectedReason != nil ? Color(hex: "#FFB162") : Color.clear)
                        .cornerRadius(32)
                        .overlay(
                            RoundedRectangle(cornerRadius: 32)
                                .stroke(selectedReason != nil ? Color.clear : Color.white.opacity(0.1), lineWidth: 1)
                        )
                }
                .disabled(selectedReason == nil)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .navigationBarHidden(true)
        .alert(isPresented: $showConfirmDialog) {
            Alert(
                title: Text("Delete Account"),
                message: Text("Are you sure you want to permanently delete your account? This action cannot be undone."),
                primaryButton: .destructive(Text("Delete")) {
                    router.isAuthenticated = false
                    router.navigationPath.removeLast(router.navigationPath.count)
                },
                secondaryButton: .cancel()
            )
        }
    }
}

