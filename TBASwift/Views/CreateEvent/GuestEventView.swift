import SwiftUI

struct GuestEventView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedId: String? = nil
    
    let progress: CGFloat = 0.30
    
    struct Option {
        let id: String
        let title: String
        let icon: String
        let traits: String
    }
    
    let options: [Option] = [
        Option(id: "on_request", title: "On Request", icon: "person.2.fill", traits: "Guests request to\njoin. You approve\nthem manually."),
        Option(id: "open_rsvp", title: "Open RSVP", icon: "person.crop.circle.fill.badge.plus", traits: "Anyone can join\nuntil the room is\nfull.")
    ]
    
    var body: some View {
        ZStack {
            Color(hex: "1A2534")
                .ignoresSafeArea()
            
            LinearGradient(
                stops: [
                    .init(color: Color(hex: "A35139").opacity(0), location: 0.4),
                    .init(color: Color(hex: "A35139"), location: 1.0)
                ],
                startPoint: .trailing,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            LinearGradient(
                stops: [
                    .init(color: Color(hex: "FFB162"), location: 0.0),
                    .init(color: Color(hex: "FFB162").opacity(0), location: 0.5)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header Row
                HStack(spacing: 16) {
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
                            .frame(width: max(0, (UIScreen.main.bounds.width - 40 - 44 - 16) * progress))
                            .padding(4)
                    }
                    .frame(height: 24)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                // Title
                HStack {
                    Text("How should guests join your event?")
                        .font(.custom("DMSerifDisplay-Regular", size: 32))
                        .foregroundColor(.white)
                        .lineSpacing(4)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 80)
                .padding(.bottom, 40)
                
                // Options List
                HStack(spacing: 12) {
                    ForEach(options, id: \.id) { option in
                        let isSelected = selectedId == option.id
                        
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                selectedId = option.id
                            }
                        }) {
                            VStack(alignment: .leading, spacing: 0) {
                                ZStack {
                                    Image(systemName: option.icon)
                                        .font(.system(size: 24))
                                }
                                .foregroundColor(isSelected ? Color(hex: "1A2230") : Color(hex: "C9C1B1"))
                                .frame(width: 28, height: 28)
                                .padding(.bottom, 18)
                                
                                Text(option.title)
                                    .font(.custom("DMSerifDisplay-Regular", size: 18))
                                    .foregroundColor(isSelected ? Color(hex: "182633") : .white)
                                    .padding(.bottom, 8)
                                
                                Text(option.traits)
                                    .font(.system(size: 13))
                                    .lineSpacing(5)
                                    .foregroundColor(isSelected ? Color(hex: "182633").opacity(0.8) : Color.white.opacity(0.85))
                                    .multilineTextAlignment(.leading)
                                
                                Spacer(minLength: 0)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 170)
                            .background(
                                Group {
                                    if isSelected {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color(hex: "FFAC4F"))
                                    } else {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color.clear)
                                            .glassCard(cornerRadius: 16)
                                    }
                                }
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                // Continue Button
                Button(action: {
                    if selectedId != nil {
                        // Navigate to next screen
                    }
                }) {
                    ZStack {
                        if selectedId != nil {
                            Circle()
                                .fill(Color(hex: "FFAC4F"))
                        } else {
                            Circle()
                                .fill(Color.clear)
                                .glassCard(cornerRadius: 50)
                        }
                        
                        Text("Continue")
                            .font(.custom("DMSerifDisplay-Italic", size: 14))
                            .foregroundColor(selectedId != nil ? Color(hex: "1A2230") : .white)
                    }
                    .frame(width: 84, height: 84)
                }
                .buttonStyle(GlassButtonStyle())
                .padding(.bottom, 4)
                .disabled(selectedId == nil)
                .opacity(selectedId == nil ? 0.6 : 1.0)
            }
        }
        .navigationBarHidden(true)
    }
}

