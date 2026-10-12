import SwiftUI

struct LogoutModalView: View {
    @Binding var isPresented: Bool
    var onConfirm: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.65)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation { isPresented = false }
                }

            VStack(spacing: 0) {
                // Close button
                HStack {
                    Spacer()
                    Button {
                        withAnimation { isPresented = false }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Color.white.opacity(0.12))
                            .clipShape(Circle())
                    }
                }
                .padding(.top, 18)
                .padding(.trailing, 18)

                // Logout Icon
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.system(size: 52))
                    .foregroundColor(Color(hex: "#FFB162"))
                    .padding(.top, 10)
                    .padding(.bottom, 20)

                // Title
                Text("Logout")
                    .font(.custom("DMSerifDisplay-Regular", size: 28))
                    .foregroundColor(.white)
                    .padding(.bottom, 10)

                // Subtitle
                Text("Are you sure you want to logout?")
                    .font(.system(size: 14))
                    .foregroundColor(Color.white.opacity(0.8))
                    .padding(.bottom, 32)

                // Action Buttons
                HStack(spacing: 12) {
                    Button {
                        withAnimation { isPresented = false }
                    } label: {
                        Text("Cancel")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .realGlass(cornerRadius: 26, strokeOpacity: 0.65, lineWidth: 1.2)
                    }

                    Button {
                        withAnimation {
                            isPresented = false
                            onConfirm()
                        }
                    } label: {
                        Text("Confirm")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(Color(hex: "#182633"))
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(Color(hex: "#FFB162"))
                            .cornerRadius(26)
                    }
                }
                .padding(.horizontal, 22)
                .padding(.bottom, 26)
            }
            .frame(width: UIScreen.main.bounds.width * 0.88)
            .background(
                LinearGradient(
                    colors: [
                        Color(hex: "#A35139"),
                        Color(hex: "#1A2534"),
                        Color(hex: "#1A2534")
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 32, style: .continuous)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.5), radius: 24)
        }
    }
}

