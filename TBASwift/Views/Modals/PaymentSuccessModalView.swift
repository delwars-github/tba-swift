import SwiftUI

struct PaymentSuccessModalView: View {
    @Binding var isPresented: Bool
    var onDone: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation { isPresented = false }
                }

            VStack(spacing: 0) {
                // Checkmark Circle Icon
                ZStack {
                    Circle()
                        .fill(Color(hex: "#FFB162"))
                        .frame(width: 80, height: 80)
                        .shadow(color: Color(hex: "#FFB162").opacity(0.4), radius: 16)
                    Image(systemName: "checkmark")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(Color(hex: "#182633"))
                }
                .padding(.top, 36)
                .padding(.bottom, 20)

                // Title
                Text("Payment Successful!")
                    .font(.custom("DMSerifDisplay-Regular", size: 26))
                    .foregroundColor(.white)
                    .padding(.bottom, 10)

                // Subtitle
                Text("You're officially confirmed for this gathering.\nCheck your email and notifications for details.")
                    .font(.system(size: 13))
                    .foregroundColor(Color.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 28)

                // Amount breakdown badge
                HStack {
                    Text("Total Paid")
                        .font(.system(size: 14))
                        .foregroundColor(Color.white.opacity(0.7))
                    Spacer()
                    Text("$30.00")
                        .font(.custom("DMSerifDisplay-Regular", size: 18))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)
                .padding(.horizontal, 24)
                .padding(.bottom, 32)

                // Done Button
                Button {
                    withAnimation {
                        isPresented = false
                        onDone()
                    }
                } label: {
                    Text("Done")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color(hex: "#182633"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color(hex: "#FFB162"))
                        .cornerRadius(26)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 28)
            }
            .frame(width: UIScreen.main.bounds.width * 0.88)
            .background(
                LinearGradient(
                    colors: [
                        Color(hex: "#A35139"),
                        Color(hex: "#1A2534"),
                        Color(hex: "#1A2534"),
                        Color(hex: "#A35139")
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

