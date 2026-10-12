import SwiftUI

struct AddPaymentMethodView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var router: AppRouter
    @State private var cardNumber = ""
    @State private var expiryDate = ""
    @State private var cvv = ""
    @State private var cardholderName = ""

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

                    Text("Add Payment Method")
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
                        // Card Number
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Card Number")
                                .font(.custom("DMSerifDisplay-Regular", size: 14))
                                .foregroundColor(.white)
                            TextField("enter your card number", text: $cardNumber)
                                .keyboardType(.numberPad)
                                .foregroundColor(.white)
                                .padding(16)
                                .realGlass(cornerRadius: 12, strokeOpacity: 0.65, lineWidth: 1.0)
                        }

                        // Expiry & CVV
                        HStack(spacing: 16) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Expiry Date")
                                    .font(.custom("DMSerifDisplay-Regular", size: 14))
                                    .foregroundColor(.white)
                                TextField("MM/YY", text: $expiryDate)
                                    .keyboardType(.numbersAndPunctuation)
                                    .foregroundColor(.white)
                                    .padding(16)
                                    .realGlass(cornerRadius: 12, strokeOpacity: 0.65, lineWidth: 1.0)
                            }

                            VStack(alignment: .leading, spacing: 8) {
                                Text("CVV")
                                    .font(.custom("DMSerifDisplay-Regular", size: 14))
                                    .foregroundColor(.white)
                                SecureField("123", text: $cvv)
                                    .keyboardType(.numberPad)
                                    .foregroundColor(.white)
                                    .padding(16)
                                    .realGlass(cornerRadius: 12, strokeOpacity: 0.65, lineWidth: 1.0)
                            }
                        }

                        // Cardholder Name
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Cardholder Name")
                                .font(.custom("DMSerifDisplay-Regular", size: 14))
                                .foregroundColor(.white)
                            TextField("Enter your Name", text: $cardholderName)
                                .foregroundColor(.white)
                                .padding(16)
                                .realGlass(cornerRadius: 12, strokeOpacity: 0.65, lineWidth: 1.0)
                        }

                        Spacer().frame(height: 20)

                        // Action buttons
                        HStack(spacing: 12) {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Cancel")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 18)
                                    .realGlass(cornerRadius: 26, strokeOpacity: 0.65, lineWidth: 1.0)
                            }

                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Add Card")
                                    .font(.custom("DMSerifDisplay-Regular", size: 14))
                                    .foregroundColor(Color(hex: "#1A2534"))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 18)
                                    .background(Color(hex: "#FFB162"))
                                    .cornerRadius(26)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

