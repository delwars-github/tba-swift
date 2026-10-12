import SwiftUI

struct PaymentInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var router: AppRouter

    struct SavedCard: Identifiable {
        let id: String
        let last4: String
        let expiry: String
    }

    @State private var cards: [SavedCard] = [
        SavedCard(id: "1", last4: "3456", expiry: "08/26"),
        SavedCard(id: "2", last4: "1289", expiry: "11/25")
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

                    Text("Payment Info")
                        .font(.custom("DMSerifDisplay-Regular", size: 20))
                        .foregroundColor(.white)

                    Spacer()

                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 8)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        // Cards list
                        ForEach(cards) { card in
                            cardView(card: card)
                        }

                        // Add new card button
                        Button(action: {
                            router.navigationPath.append("AddPaymentMethod")
                        }) {
                            HStack(spacing: 8) {
                                Image(systemName: "plus")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("Add New Card")
                                    .font(.system(size: 14, weight: .medium))
                            }
                            .foregroundColor(Color(hex: "#FFB162"))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)
                        }

                        // Security notice
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "lock.fill")
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#FFCC00"))
                            Text("Your payment information is encrypted and secure. We never store your full card details.")
                                .font(.system(size: 12))
                                .foregroundColor(Color.white.opacity(0.8))
                                .lineSpacing(4)
                        }
                        .padding(16)
                        .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func cardView(card: SavedCard) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("VISA")
                    .font(.system(size: 22, weight: .bold))
                    .italic()
                    .foregroundColor(.white)
                Spacer()
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("**** **** **** \(card.last4)")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .tracking(2)
                    Spacer()
                    Text(card.expiry)
                        .font(.system(size: 12))
                        .foregroundColor(Color.white.opacity(0.8))
                }

                HStack(spacing: 12) {
                    Button(action: {}) {
                        Text("Save as Default")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(Color.white.opacity(0.12))
                            .cornerRadius(20)
                    }

                    Button(action: {
                        cards.removeAll { $0.id == card.id }
                    }) {
                        Text("Delete")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color.white.opacity(0.9))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(Color.white.opacity(0.06))
                            .cornerRadius(20)
                    }
                }
            }
        }
        .padding(20)
        .background(
            LinearGradient(
                colors: [Color(hex: "#2C3B4D").opacity(0.9), Color(hex: "#1A2534").opacity(0.95)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.15), lineWidth: 1)
        )
    }
}

