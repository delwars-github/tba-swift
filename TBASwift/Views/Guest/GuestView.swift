import SwiftUI

struct GuestView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var router: AppRouter

    @State private var selectedCard: String? = nil
    @State private var isGuestConfirmVisible = false

    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                colors: [
                    Color(hex: "#1B2635"),
                    Color(hex: "#1F2A38"),
                    Color(hex: "#1F2A38"),
                    Color(hex: "#A35139"),
                    Color(hex: "#A35139")
                ],
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                // Back Button
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .realGlass(cornerRadius: 18, strokeOpacity: 0.65, lineWidth: 1.2)
                }
                .padding(.top, 10)
                .padding(.bottom, 60)
                .padding(.horizontal, 20)

                // Titles
                Text("Your friend isn't on\nBoring yet")
                    .font(.custom("DMSerifDisplay-Regular", size: 32))
                    .foregroundColor(.white)
                    .tracking(1)
                    .lineSpacing(10)
                    .padding(.bottom, 16)
                    .padding(.horizontal, 20)

                Text("Choose how you'd like to bring them")
                    .font(.system(size: 15))
                    .foregroundColor(Color(hex: "#E6E2DB"))
                    .tracking(0.5)
                    .padding(.horizontal, 20)

                // Action Cards Row
                HStack(spacing: 16) {
                    // Card 1: Join the app & event -> navigates to Share
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedCard = "join"
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            router.navigationPath.append("Share")
                            selectedCard = nil
                        }
                    }) {
                        VStack(alignment: .leading, spacing: 20) {
                            Image(systemName: "person.badge.plus")
                                .font(.system(size: 30))
                                .foregroundColor(selectedCard == "join" ? Color(hex: "#1B2635") : .white)

                            Text("Join the app &\nevent")
                                .font(.custom("DMSerifDisplay-Regular", size: 18))
                                .foregroundColor(selectedCard == "join" ? Color(hex: "#1B2635") : .white)
                                .tracking(0.5)
                                .lineSpacing(4)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(20)
                        .frame(height: 150)
                        .background(
                            ZStack {
                                if selectedCard == "join" {
                                    Color(hex: "#FFB162")
                                        .cornerRadius(20)
                                } else {
                                    Color.clear
                                        .realGlass(cornerRadius: 20, strokeOpacity: 0.65, lineWidth: 1.2)
                                }
                            }
                        )
                    }
                    .buttonStyle(PlainButtonStyle())

                    // Card 2: Bring as a guest -> opens GuestConfirmModal
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedCard = "guest"
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            isGuestConfirmVisible = true
                            selectedCard = nil
                        }
                    }) {
                        VStack(alignment: .leading, spacing: 20) {
                            Image(systemName: "person.2")
                                .font(.system(size: 30))
                                .foregroundColor(selectedCard == "guest" ? Color(hex: "#1B2635") : .white)

                            Text("Bring as a\nguest")
                                .font(.custom("DMSerifDisplay-Regular", size: 18))
                                .foregroundColor(selectedCard == "guest" ? Color(hex: "#1B2635") : .white)
                                .tracking(0.5)
                                .lineSpacing(4)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(20)
                        .frame(height: 150)
                        .background(
                            ZStack {
                                if selectedCard == "guest" {
                                    Color(hex: "#FFB162")
                                        .cornerRadius(20)
                                } else {
                                    Color.clear
                                        .realGlass(cornerRadius: 20, strokeOpacity: 0.65, lineWidth: 1.2)
                                }
                            }
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 20)
                .padding(.top, 40)

                Spacer()
            }

            // Guest Confirmation Modal
            if isGuestConfirmVisible {
                GuestConfirmModalView(isPresented: $isGuestConfirmVisible) { names in
                    // Navigate to QuickQuestion, matching TBA Native
                    router.navigationPath.append("QuickQuestion")
                }
                .transition(.opacity)
            }
        }
        .navigationBarHidden(true)
    }
}
