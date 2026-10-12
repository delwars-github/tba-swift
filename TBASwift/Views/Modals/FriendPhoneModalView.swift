import SwiftUI

struct FriendPhoneModalView: View {
    @Binding var isPresented: Bool
    var onContinue: (String) -> Void
    var onNotOnApp: () -> Void

    @State private var phoneNumber: String = ""
    @FocusState private var isFieldFocused: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.65)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        isPresented = false
                    }
                }

            VStack(spacing: 0) {
                // Image
                Image("group")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120)
                    .clipped()

                VStack(spacing: 16) {
                    Text("Is your\nfriend on Boring?")
                        .font(.custom("DMSerifDisplay-Regular", size: 26))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.top, 16)

                    Text("If your friend is already a member,\nenter their phone number.")
                        .font(.system(size: 13))
                        .foregroundColor(Color(hex: "#E6E2DB"))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)

                    // Phone input
                    TextField("Enter 10-digit number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.vertical, 14)
                        .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)
                        .padding(.horizontal, 24)
                        .padding(.top, 8)

                    // Buttons
                    VStack(spacing: 12) {
                        Button {
                            withAnimation {
                                isPresented = false
                                onContinue(phoneNumber)
                            }
                        } label: {
                            Text("Continue")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                                .background(Color(hex: "#FFB162"))
                                .cornerRadius(26)
                        }

                        Button {
                            withAnimation {
                                isPresented = false
                                onNotOnApp()
                            }
                        } label: {
                            Text("Not on Boring? Add Guest")
                                .font(.system(size: 13, weight: .medium))
                                .underline()
                                .foregroundColor(Color(hex: "#FFD1AA"))
                        }
                        .padding(.top, 4)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                    .padding(.bottom, 24)
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
            .background(
                LinearGradient(
                    colors: [Color(hex: "#A35139"), Color(hex: "#1F2A38")],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.4), radius: 20)
        }
    }
}

