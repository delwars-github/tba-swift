import SwiftUI

struct GuestConfirmModalView: View {
    @Binding var isPresented: Bool
    var onContinue: ([String]) -> Void

    @State private var guestNames: [String] = [""]

    var hasValidName: Bool {
        guestNames.contains { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }

    var body: some View {
        ZStack {
            // Dimmed backdrop
            Color.black.opacity(0.65)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation { isPresented = false }
                }

            VStack(spacing: 0) {
                // Top decorative image
                Image("group")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .clipped()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Title
                        Text("Guest Confirmation")
                            .font(.custom("DMSerifDisplay-Regular", size: 28))
                            .foregroundColor(.white)
                            .tracking(0.5)
                            .padding(.top, 20)
                            .padding(.bottom, 6)

                        Text("Enter guest details and confirm payment")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#E6E2DB"))
                            .padding(.bottom, 28)

                        // Input fields
                        VStack(spacing: 18) {
                            ForEach(0..<guestNames.count, id: \.self) { index in
                                VStack(spacing: 4) {
                                    TextField("Enter Guest Name", text: $guestNames[index])
                                        .font(.custom("DMSerifDisplay-Regular", size: 18))
                                        .foregroundColor(.white)
                                        .padding(.bottom, 8)
                                    Rectangle()
                                        .fill(Color.white.opacity(0.3))
                                        .frame(height: 1)
                                }
                            }

                            // Add another button
                            if let last = guestNames.last, !last.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                Button {
                                    guestNames.append("")
                                } label: {
                                    HStack(spacing: 6) {
                                        Image(systemName: "plus")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(.white)
                                        Text("Add Another")
                                            .font(.custom("DMSerifDisplay-Regular", size: 14))
                                            .foregroundColor(.white)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 4)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 36)

                        // Continue Round Button
                        Button {
                            let valid = guestNames.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
                            withAnimation {
                                isPresented = false
                                onContinue(valid.isEmpty ? ["Guest 1"] : valid)
                            }
                        } label: {
                            Text("Continue")
                                .font(.custom("DMSerifDisplay-Italic", size: 14))
                                .foregroundColor(hasValidName ? Color(hex: "#1A2534") : Color(hex: "#E6E2DB"))
                                .frame(width: 84, height: 84)
                                .background(hasValidName ? Color(hex: "#FFB162") : Color.clear)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.white.opacity(hasValidName ? 0 : 0.25), lineWidth: 1.2)
                                )
                        }
                        .padding(.bottom, 16)

                        // Go Back Button
                        Button {
                            withAnimation { isPresented = false }
                        } label: {
                            Text("Go Back")
                                .font(.system(size: 15))
                                .foregroundColor(Color(hex: "#E6E2DB"))
                        }
                        .padding(.bottom, 24)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.92, height: UIScreen.main.bounds.height * 0.82)
            .background(
                LinearGradient(
                    colors: [
                        Color(hex: "#C86A39"),
                        Color(hex: "#1A2534"),
                        Color(hex: "#1A2534"),
                        Color(hex: "#A35139")
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 36, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 36, style: .continuous)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.5), radius: 24)
        }
    }
}

