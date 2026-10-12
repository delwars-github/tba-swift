import SwiftUI

struct DeleteAccountView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var router: AppRouter
    @State private var otp: [String] = ["", "", "", ""]
    @FocusState private var focusedIndex: Int?

    var isFilled: Bool {
        otp.allSatisfy { !$0.isEmpty }
    }

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
                        // Info Banner
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Please Enter OTP Code to delete account")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                            Text("Your feedback means the world to us! If you're thinking about deleting your account, we'd love to hear how we can improve.")
                                .font(.system(size: 12))
                                .foregroundColor(Color.white.opacity(0.7))
                                .lineSpacing(4)
                        }
                        .padding(16)
                        .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)
                        .padding(.top, 10)

                        Text("Enter the One Time OTP sent to +23********34")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color.white.opacity(0.9))

                        // OTP Inputs
                        HStack(spacing: 12) {
                            ForEach(0..<4, id: \.self) { idx in
                                ZStack {
                                    TextField("", text: $otp[idx])
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 22, weight: .bold))
                                        .foregroundColor(.white)
                                        .focused($focusedIndex, equals: idx)
                                        .onChange(of: otp[idx]) { newValue in
                                            if newValue.count > 1 {
                                                otp[idx] = String(newValue.suffix(1))
                                            }
                                            if !newValue.isEmpty && idx < 3 {
                                                focusedIndex = idx + 1
                                            }
                                        }
                                }
                                .frame(width: 68, height: 68)
                                .realGlass(cornerRadius: 34, strokeOpacity: 0.65, lineWidth: 1.2)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)

                        Button(action: {}) {
                            Text("Resend Code")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.white)
                                .underline()
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal, 20)
                }

                Spacer()

                // Confirm button
                Button(action: {
                    router.navigationPath.append("DeleteAccountDetails")
                }) {
                    Text("Confirm")
                        .font(.custom("DMSerifDisplay-Regular", size: 15))
                        .foregroundColor(isFilled ? Color(hex: "#182633") : Color(hex: "#FFAC4F"))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(isFilled ? Color(hex: "#FFB162") : Color.clear)
                        .cornerRadius(32)
                        .overlay(
                            RoundedRectangle(cornerRadius: 32)
                                .stroke(isFilled ? Color.clear : Color.white.opacity(0.1), lineWidth: 1)
                        )
                }
                .disabled(!isFilled)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            focusedIndex = 0
        }
    }
}

