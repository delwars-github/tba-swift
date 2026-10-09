import SwiftUI

struct SelectCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var router: AppRouter
    @State private var selectedCardId: String? = nil
    
    let cards = [
        ("1", "Mastercard", "•••• 4242"),
        ("2", "Visa", "•••• 1234"),
        ("3", "Amex", "•••• 5678")
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#FFB162"), Color(hex: "#1A2534"), Color(hex: "#1A2534"), Color(hex: "#A35139")],
                startPoint: UnitPoint(x: 0.2, y: 0),
                endPoint: UnitPoint(x: 0.8, y: 1)
            )
            .ignoresSafeArea()
            
            VStack {
                // Header
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color(hex: "#E6E2DB"))
                            .frame(width: 44, height: 44)
                            .realGlass(cornerRadius: 18, strokeOpacity: 0.65, lineWidth: 1.2)
                    }
                    
                    Spacer()
                    
                    Text("Select card")
                        .font(.custom("DMSerifDisplay-Regular", size: 20))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .padding(.bottom, 24)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 8) {
                        ForEach(cards, id: \.0) { card in
                            let isSelected = selectedCardId == card.0
                            
                            Button(action: {
                                selectedCardId = card.0
                            }) {
                                HStack(spacing: 16) {
                                    ZStack {
                                        if isSelected {
                                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                                .fill(Color.white)
                                        } else {
                                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                                .fill(Color.white.opacity(0.1))
                                        }
                                        
                                        Image(systemName: "creditcard.fill")
                                            .foregroundColor(isSelected ? Color(hex: "#BA4127") : Color(hex: "#E6E2DB"))
                                    }
                                    .frame(width: 44, height: 44)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .stroke(Color.white.opacity(isSelected ? 0 : 0.2), lineWidth: 1)
                                    )
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(card.1)
                                            .font(.custom("DMSerifDisplay-Regular", size: 16))
                                            .foregroundColor(.white)
                                        
                                        Text(card.2)
                                            .font(.custom("DMSerifDisplay-Regular", size: 14))
                                            .foregroundColor(Color.white.opacity(0.9))
                                            .tracking(2)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(12)
                                .background(
                                    ZStack {
                                        if isSelected {
                                            LinearGradient(
                                                colors: [Color(hex: "#BA4127"), Color(hex: "#AC3920")],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
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
                    }
                    .padding(.horizontal, 16)
                }
                
                Spacer()
                
                // Bottom Pay Button
                if selectedCardId != nil {
                    Button(action: {
                        // success modal logic
                    }) {
                        Text("Pay $30")
                            .font(.custom("DMSerifDisplay-Italic", size: 14))
                            .foregroundColor(Color(hex: "#1A2534"))
                            .frame(width: 84, height: 84)
                            .background(Color(hex: "#FFB162"))
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

