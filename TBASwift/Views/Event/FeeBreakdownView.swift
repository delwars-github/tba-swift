import SwiftUI

struct FeeBreakdownView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#FFB162"), Color(hex: "#1A2534"), Color(hex: "#1A2534"), Color(hex: "#A35139")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
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
                    
                    Text("Fee Breakdown")
                        .font(.custom("DMSerifDisplay-Regular", size: 20))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        // Event Title & Date
                        VStack(spacing: 8) {
                            Text("Summer Rooftop Mixer")
                                .font(.custom("DMSerifDisplay-Regular", size: 26))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            
                            Text("Sat, June 15, 2024 • 7:00 PM - 11:00 PM")
                                .font(.system(size: 13))
                                .foregroundColor(Color(hex: "#E6E2DB"))
                        }
                        .padding(.top, 32)
                        
                        // Glass Breakdown Box
                        VStack(spacing: 16) {
                            // Event Entry Fee
                            HStack {
                                Text("Event Entry Fee")
                                    .font(.custom("DMSerifDisplay-Regular", size: 16))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("$15")
                                    .font(.custom("DMSerifDisplay-Regular", size: 16))
                                    .foregroundColor(.white)
                            }
                            
                            // Guest Fee
                            HStack {
                                Text("Guest Fee")
                                    .font(.custom("DMSerifDisplay-Regular", size: 16))
                                    .foregroundColor(.white)
                                + Text(" (1 guest)")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("$10")
                                    .font(.custom("DMSerifDisplay-Regular", size: 16))
                                    .foregroundColor(.white)
                            }
                            
                            Rectangle().fill(Color.white.opacity(0.2)).frame(height: 1)
                            
                            // Curation Fee
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text("Curation Fee")
                                        .font(.custom("DMSerifDisplay-Regular", size: 16))
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text("$5")
                                        .font(.custom("DMSerifDisplay-Regular", size: 16))
                                        .foregroundColor(.white)
                                }
                                Text("(Applies per attendee. 2x if you bring 1 guest)")
                                    .font(.system(size: 12))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            
                            Rectangle().fill(Color.white.opacity(0.2)).frame(height: 1)
                            
                            // Event Equipment Fee
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Event Equipment Fee Paid at the gathering")
                                    .font(.custom("DMSerifDisplay-Regular", size: 16))
                                    .foregroundColor(.white)
                                Text("(Per attendee, collected on arrival)")
                                    .font(.system(size: 12))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Rectangle().fill(Color.white.opacity(0.2)).frame(height: 1)
                            
                            // Total Payable
                            HStack {
                                Text("Total Payable")
                                    .font(.custom("DMSerifDisplay-Regular", size: 14))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("$30")
                                    .font(.custom("DMSerifDisplay-Regular", size: 20))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 24)
                        .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)
                        .padding(.horizontal, 16)
                        
                        // Info Text
                        Text("Reserve your spot for a chance to join this gathering. If you're not selected by **3 PM on Tuesday**, you'll receive a full refund — no stress, no surprises")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#E6E2DB").opacity(0.9))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                            .lineSpacing(4)
                    }
                    .padding(.bottom, 24)
                }
                
                Spacer()
                
                // Bottom Button
                Button(action: {
                    // Navigate to Payment
                }) {
                    Text("Reserve\nMy Spot")
                        .font(.custom("DMSerifDisplay-Italic", size: 14))
                        .foregroundColor(Color(hex: "#1A2534"))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .frame(width: 84, height: 84)
                        .background(Color(hex: "#FFB162"))
                        .clipShape(Circle())
                }
                .padding(.bottom, 14)
            }
        }
        .navigationBarHidden(true)
    }
}

