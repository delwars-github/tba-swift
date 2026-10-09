import SwiftUI

struct EventStructure2View: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedId: String? = nil
    
    let progress: CGFloat = 0.60
    
    struct Option {
        let id: String
        let title: String
        let icon: String
        let traits: String
    }
    
    let options: [Option] = [
        Option(id: "social", title: "Social Hangout", icon: "person.2.fill", traits: "Casual meet-up to\nconnect and chat"),
        Option(id: "fitness", title: "Fitness Session", icon: "figure.run", traits: "Active workout or sports activity"),
        Option(id: "networking", title: "Networking", icon: "briefcase.fill", traits: "Opportunities and\nconnections"),
        Option(id: "game_night1", title: "Game Night", icon: "gamecontroller.fill", traits: "Fun evening of board\ngame or video game"),
        Option(id: "game_night2", title: "Game Night", icon: "gamecontroller.fill", traits: "Fun evening of board\ngame or video game")
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
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        // Title
                        Text("What kind of event are you planning?")
                            .font(.custom("DMSerifDisplay-Regular", size: 32))
                            .foregroundColor(.white)
                            .lineSpacing(4)
                            .padding(.top, 60)
                            .padding(.bottom, 24)
                        
                        // Options Grid
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)], spacing: 12) {
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
                                                .font(.system(size: 20))
                                        }
                                        .foregroundColor(isSelected ? Color(hex: "1A2230") : .white)
                                        .frame(width: 24, height: 24)
                                        .padding(.bottom, 12)
                                        
                                        Text(option.title)
                                            .font(.custom("DMSerifDisplay-Regular", size: 15))
                                            .foregroundColor(isSelected ? Color(hex: "182633") : .white)
                                            .padding(.bottom, 5)
                                        
                                        Text(option.traits)
                                            .font(.system(size: 11))
                                            .lineSpacing(3)
                                            .foregroundColor(isSelected ? Color(hex: "182633").opacity(0.8) : Color.white.opacity(0.85))
                                            .multilineTextAlignment(.leading)
                                        
                                        Spacer(minLength: 0)
                                    }
                                    .padding(16)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .frame(height: 140)
                                    .background(
                                        Group {
                                            if isSelected {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(Color(hex: "FFAC4F"))
                                            } else {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(Color.clear)
                                                    .glassCard(cornerRadius: 12)
                                            }
                                        }
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 140)
                }
            }
            
            // Bottom Gradient Overlay & Continue Button
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
                    .padding(.bottom, 16)
                    .disabled(selectedId == nil)
                    .opacity(selectedId == nil ? 0.6 : 1.0)
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationBarHidden(true)
    }
}

