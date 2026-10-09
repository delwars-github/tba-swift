import SwiftUI

struct BailPolicyView: View {
    @Environment(\.presentationMode) var presentationMode
    
    // For Modals - if we implement them as overlays, we use state
    @State private var isAcceptModalVisible = false
    @State private var isPhoneModalVisible = false
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#FFB162"), Color(hex: "#A35139"), Color(hex: "#1B2635"), Color(hex: "#0E131C")],
                startPoint: .topTrailing,
                endPoint: .bottomLeading
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
                            .foregroundColor(Color(hex: "#E6E2DB"))
                            .frame(width: 44, height: 44)
                            .realGlass(cornerRadius: 18, strokeOpacity: 0.65, lineWidth: 1.2)
                    }
                    
                    Spacer()
                    
                    Text("Bail policy")
                        .font(.custom("DMSerifDisplay-Regular", size: 30))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 20)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 32) {
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Rectangle().fill(Color.white.opacity(0.2)).frame(height: 1)
                                .padding(.bottom, 16)
                                .padding(.top, 16)
                            
                            Text("Highlights")
                                .font(.custom("DMSerifDisplay-Regular", size: 20))
                                .foregroundColor(.white)
                            
                            Text("Each gathering includes clear details about what to expect, including the event vibe, date, time, location, host notes, group size, and any additional fees. Some events are open RSVP, while others require approval to ensure the right mix of people. You can cancel for a full refund before the bail deadline shown on the event page.")
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#E6E2DB"))
                                .lineSpacing(6)
                        }
                        
                        ForEach(0..<3, id: \.self) { _ in
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Highlights")
                                    .font(.custom("DMSerifDisplay-Regular", size: 20))
                                    .foregroundColor(.white)
                                
                                Text("Photo corner + group moments\nDrinks & snacks available\nGames and quick activities\nSafe, friendly crowd")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(hex: "#E6E2DB"))
                                    .lineSpacing(7)
                            }
                        }
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 200)
                }
            }
            
            // Bottom fade
            VStack {
                Spacer()
                LinearGradient(
                    colors: [Color.clear, Color(hex: "#0E131C").opacity(0.8), Color(hex: "#0E131C")],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 300)
                .allowsHitTesting(false)
            }
            .ignoresSafeArea()
            
            // Accept Button
            VStack {
                Spacer()
                Button(action: {
                    // Show accept modal
                    // Mocking action for now
                }) {
                    Text("Accept")
                        .font(.custom("DMSerifDisplay-Italic", size: 14))
                        .foregroundColor(Color(hex: "#E6E2DB"))
                        .frame(width: 84, height: 84)
                        .realGlass(cornerRadius: 42, strokeOpacity: 0.65, lineWidth: 1.2)
                }
                .padding(.bottom, 14)
            }
        }
        .navigationBarHidden(true)
    }
}

