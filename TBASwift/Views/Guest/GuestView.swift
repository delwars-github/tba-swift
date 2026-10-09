import SwiftUI

struct GuestView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isJoinActive = false
    
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                colors: [Color(hex: "#1B2635"), Color(hex: "#1F2A38"), Color(hex: "#1F2A38"), Color(hex: "#A35139"), Color(hex: "#A35139")],
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                // Back Button
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .realGlass(cornerRadius: 18, strokeOpacity: 0.65, lineWidth: 1.2)
                }
                .padding(.top, 10)
                .padding(.bottom, 120)
                .padding(.horizontal, 20)
                
                // Titles
                Text("Your friend isn't on\nBoring yet")
                    .font(.custom("DMSerifDisplay-Regular", size: 32))
                    .foregroundColor(.white)
                    .tracking(1)
                    .lineSpacing(10)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                
                Text("Choose how you'd like to bring them")
                    .font(.system(size: 15))
                    .foregroundColor(Color(hex: "#E6E2DB"))
                    .tracking(0.5)
                    .padding(.horizontal, 20)
                
                // Action Cards
                HStack(spacing: 16) {
                    // Card 1
                    Button(action: {
                        isJoinActive = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            isJoinActive = false
                            // Route to share
                        }
                    }) {
                        VStack(alignment: .leading, spacing: 24) {
                            Image(systemName: "person.badge.plus") // mock join icon
                                .font(.system(size: 32))
                                .foregroundColor(isJoinActive ? Color(hex: "#1B2635") : .white)
                            
                            Text("Join the app &\nevent")
                                .font(.custom("DMSerifDisplay-Regular", size: 18))
                                .foregroundColor(isJoinActive ? Color(hex: "#1B2635") : .white)
                                .tracking(0.5)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(20)
                        .frame(height: 150)
                        .background(isJoinActive ? Color(hex: "#FFB162") : Color.clear)
                        .cornerRadius(isJoinActive ? 20 : 0)
                        .background(
                            ZStack {
                                if !isJoinActive {
                                    Color.clear.realGlass(cornerRadius: 20, strokeOpacity: 0.65, lineWidth: 1.2)
                                }
                            }
                        )
                    }
                    
                    // Card 2
                    Button(action: {
                        // Open Guest Confirm Modal
                    }) {
                        VStack(alignment: .leading, spacing: 24) {
                            Image(systemName: "person.2") // mock guest icon
                                .font(.system(size: 32))
                                .foregroundColor(.white)
                            
                            Text("Bring as a\nguest")
                                .font(.custom("DMSerifDisplay-Regular", size: 18))
                                .foregroundColor(.white)
                                .tracking(0.5)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(20)
                        .frame(height: 150)
                        .realGlass(cornerRadius: 20, strokeOpacity: 0.65, lineWidth: 1.2)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 56)
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

struct GuestView_Previews: PreviewProvider {
    static var previews: some View {
        GuestView()
    }
}

