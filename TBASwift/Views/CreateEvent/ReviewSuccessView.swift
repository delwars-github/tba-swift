import SwiftUI

struct ReviewSuccessView: View {
    @Environment(\.dismiss) var dismiss
    
    // Hardcoded for preview
    let title = "Summer Rooftop Mixer"
    let date = "Sat, June 15, 2024"
    let time = "7:00 PM - 11:00 PM"
    let location = "74C Aaliyah River, Bayerhaven"
    let minEarn = 45
    let maxEarn = 90
    
    let progress: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            Color(hex: "1A2534")
                .ignoresSafeArea()
            
            // Abstract Blur Backgrounds
            Image("blur1")
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea()
                .opacity(0.6)
            
            Image("blur2")
                .resizable()
                .scaledToFill()
                .frame(height: 550)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
                .opacity(0.6)
            
            VStack(spacing: 0) {
                // Header Row
                HStack(spacing: 12) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .glassCard(cornerRadius: 18)
                    }
                    .buttonStyle(GlassButtonStyle())
                    
                    // Progress Bar
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.clear)
                            .glassCard(cornerRadius: 14)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "215A8A"))
                            .frame(width: max(0, (UIScreen.main.bounds.width - 40 - 44 - 12) * progress))
                            .padding(4)
                    }
                    .frame(height: 24)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 10)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Title
                        Text("Reward Preview")
                            .font(.custom("DMSerifDisplay-Regular", size: 32))
                            .foregroundColor(.white)
                            .padding(.top, 20)
                            .padding(.bottom, 4)
                        
                        // Event Details Card
                        HStack(spacing: 16) {
                            // Event Image
                            ZStack {
                                LinearGradient(colors: [Color(hex: "8B231B"), Color(hex: "E56D25"), Color(hex: "1B1425")], startPoint: .topLeading, endPoint: .bottomTrailing)
                            }
                            .frame(width: 84, height: 110)
                            .cornerRadius(12)
                            
                            // Details
                            VStack(alignment: .leading, spacing: 6) {
                                Text(title)
                                    .font(.custom("DMSerifDisplay-Regular", size: 14))
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                
                                HStack(spacing: 6) {
                                    Image(systemName: "calendar")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.white.opacity(0.7))
                                    Text(date)
                                        .font(.custom("DMSerifDisplay-Regular", size: 11))
                                        .foregroundColor(Color(hex: "EEE9DF"))
                                }
                                
                                HStack(spacing: 6) {
                                    Image(systemName: "clock")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.white.opacity(0.7))
                                    Text(time)
                                        .font(.custom("DMSerifDisplay-Regular", size: 11))
                                        .foregroundColor(Color(hex: "EEE9DF"))
                                }
                                
                                HStack(spacing: 6) {
                                    Image(systemName: "person.2")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.white.opacity(0.7))
                                    Text("Max 23")
                                        .font(.custom("DMSerifDisplay-Regular", size: 11))
                                        .foregroundColor(Color(hex: "EEE9DF"))
                                }
                                
                                HStack(spacing: 6) {
                                    Image(systemName: "mappin.and.ellipse")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.white.opacity(0.7))
                                    Text(location)
                                        .font(.custom("DMSerifDisplay-Regular", size: 11))
                                        .foregroundColor(Color(hex: "EEE9DF"))
                                        .lineLimit(1)
                                }
                            }
                            Spacer()
                        }
                        .padding(16)
                        .glassCard(cornerRadius: 16)
                        
                        // Earnings Card
                        VStack(spacing: 16) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 48))
                                .foregroundColor(Color(hex: "FFAC4F"))
                                .padding(.top, 8)
                            
                            Text("Your Potential\nEarnings")
                                .font(.custom("DMSerifDisplay-Regular", size: 24))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .lineSpacing(4)
                            
                            Text("Complete this gathering to earn rewards")
                                .font(.custom("DMSerifDisplay-Regular", size: 12))
                                .foregroundColor(Color.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                            
                            // Inner Box
                            VStack(spacing: 12) {
                                Text("You'll earn between")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                
                                HStack(spacing: 8) {
                                    Text("$\(minEarn)")
                                        .font(.custom("DMSerifDisplay-Regular", size: 28))
                                        .foregroundColor(Color(hex: "FFAC4F"))
                                    
                                    Text("to")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.white)
                                    
                                    Text("$\(maxEarn)")
                                        .font(.custom("DMSerifDisplay-Regular", size: 28))
                                        .foregroundColor(Color(hex: "FFAC4F"))
                                }
                                
                                Text("if you complete this gathering.")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical, 24)
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.16))
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
                            )
                        }
                        .padding(16)
                        .glassCard(cornerRadius: 16)
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 180)
                }
            }
            
            // Bottom Gradient Overlay & Create Event Button
            VStack {
                Spacer()
                ZStack(alignment: .bottom) {
                    LinearGradient(
                        stops: [
                            .init(color: Color(hex: "1A2534").opacity(0), location: 0.0),
                            .init(color: Color(hex: "1A2534").opacity(0.8), location: 0.5),
                            .init(color: Color(hex: "1A2534"), location: 1.0)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 120)
                    
                    Button(action: {
                        // TODO: Navigate back to home / reset navigation stack
                        print("Create Event clicked")
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color(hex: "FFAC4F"))
                            
                            Text("Create\nEvent")
                                .font(.custom("DMSerifDisplay-Italic", size: 14))
                                .foregroundColor(Color(hex: "1A2230"))
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 84, height: 84)
                    }
                    .buttonStyle(GlassButtonStyle())
                    .padding(.bottom, 16)
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationBarHidden(true)
    }
}

