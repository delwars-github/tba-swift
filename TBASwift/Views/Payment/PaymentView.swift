import SwiftUI

struct PaymentOption: View {
    var icon: String
    var title: String
    var subtitle: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            content
                .background(
                    ZStack {
                        if isSelected {
                            LinearGradient(
                                colors: [Color(hex: "C64B34"), Color(hex: "BA4127")],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .cornerRadius(16)
                        } else {
                            Color.clear
                                .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)
                        }
                    }
                )
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.bottom, 12)
    }
    
    var content: some View {
        HStack(spacing: 16) {
            ZStack {
                Color(isSelected ? .white : .clear)
                if !isSelected {
                    Color.white.opacity(0.1)
                }
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? Color(hex: "BA4127") : Color(hex: "E6E2DB"))
            }
            .frame(width: 48, height: 48)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(isSelected ? 0 : 0.2), lineWidth: 1)
            )
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.custom("DMSerifDisplay-Regular", size: 16))
                    .foregroundColor(.white)
                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(Color.white.opacity(0.7))
            }
            
            Spacer()
        }
        .padding(16)
    }
}

struct PaymentView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedMethod: String = ""
    @State private var isSuccessModalVisible: Bool = false
    
    var body: some View {
        
            ZStack {
                // Background Gradient
                LinearGradient(
                    colors: [Color(hex: "FFB162"), Color(hex: "1A2534"), Color(hex: "1A2534"), Color(hex: "A35139")],
                    startPoint: UnitPoint(x: 0.1, y: 0),
                    endPoint: UnitPoint(x: 0.8, y: 1)
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
                        
                        Text("Payment")
                            .font(.custom("DMSerifDisplay-Regular", size: 20))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Color.clear.frame(width: 44, height: 44)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            PaymentOption(
                                icon: "creditcard",
                                title: "Credit / Debit Card",
                                subtitle: "Visa, Mastercard, Amex",
                                isSelected: selectedMethod == "card",
                                action: { selectedMethod = "card" }
                            )
                            
                            PaymentOption(
                                icon: "iphone",
                                title: "Apple Pay / Google Pay",
                                subtitle: "Quick digital payment",
                                isSelected: selectedMethod == "digital",
                                action: { selectedMethod = "digital" }
                            )
                            
                            PaymentOption(
                                icon: "wallet.pass",
                                title: "Wallet Balance",
                                subtitle: "Available: $125.00",
                                isSelected: selectedMethod == "wallet",
                                action: { selectedMethod = "wallet" }
                            )
                            
                            // Total Payable Box
                            HStack {
                                Text("Total Payable")
                                    .font(.custom("DMSerifDisplay-Regular", size: 14))
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Text("$30")
                                    .font(.custom("DMSerifDisplay-Regular", size: 20))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 18)
                            .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)
                            .padding(.top, 16)
                            .padding(.bottom, 32)
                        }
                        .padding(.horizontal, 16)
                    }
                    
                    Spacer()
                    
                    // Bottom Button
                    if !selectedMethod.isEmpty {
                        Button(action: {
                            isSuccessModalVisible = true
                        }) {
                            Text("Pay $30")
                                .font(.custom("DMSerifDisplay-Italic", size: 14))
                                .foregroundColor(Color(hex: "1A2534"))
                                .frame(width: 84, height: 84)
                                .background(Color(hex: "FFB162"))
                                .clipShape(Circle())
                        }
                        .padding(.bottom, 14)
                    } else {
                        Button(action: {}) {
                            Text("Pay $30")
                                .font(.custom("DMSerifDisplay-Italic", size: 14))
                                .foregroundColor(.white)
                                .frame(width: 84, height: 84)
                                .realGlass(cornerRadius: 42, strokeOpacity: 0.65, lineWidth: 1.2)
                        }
                        .padding(.bottom, 14)
                        .disabled(true)
                    }
                }
            }
            .navigationBarHidden(true)
    }
}
