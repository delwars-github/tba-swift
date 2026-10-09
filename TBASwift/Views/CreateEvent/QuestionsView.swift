import SwiftUI

struct QuestionsView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var questions: [String] = [
        "Why do you want to join this event?",
        "Have you attended something like this before?",
        "Anything the host should know?"
    ]
    @State private var customQuestion: String = ""
    
    let progress: CGFloat = 0.90
    
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
                    VStack(alignment: .leading, spacing: 24) {
                        // Title
                        Text("Create Questions")
                            .font(.custom("DMSerifDisplay-Regular", size: 32))
                            .foregroundColor(.white)
                            .padding(.top, 20)
                            .padding(.bottom, 4)
                        
                        // Example Questions
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Example Questions")
                                .font(.custom("DMSerifDisplay-Regular", size: 15))
                                .foregroundColor(.white)
                            
                            VStack(spacing: 4) {
                                ForEach(questions, id: \.self) { q in
                                    HStack {
                                        Text(q)
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 14)
                                    .glassCard(cornerRadius: 16)
                                }
                            }
                        }
                        
                        // Custom Question
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Custom Question")
                                .font(.custom("DMSerifDisplay-Regular", size: 15))
                                .foregroundColor(.white)
                            
                            VStack(spacing: 16) {
                                HStack {
                                    TextField("Type your Question...", text: $customQuestion)
                                        .font(.system(size: 14))
                                        .foregroundColor(.white)
                                        .accentColor(.white)
                                }
                                .padding(.horizontal, 16)
                                .frame(height: 48)
                                .glassCard(cornerRadius: 16)
                                
                                Button(action: {
                                    if !customQuestion.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                        withAnimation {
                                            questions.append(customQuestion.trimmingCharacters(in: .whitespacesAndNewlines))
                                            customQuestion = ""
                                        }
                                    }
                                }) {
                                    HStack {
                                        Spacer()
                                        Text("+ Add Custom Question")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(Color(hex: "FFAC4F"))
                                        Spacer()
                                    }
                                    .frame(height: 48)
                                    .glassCard(cornerRadius: 26)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 180)
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
                    
                    NavigationLink(destination: EventImageView()) {
                        ZStack {
                            Circle()
                                .fill(Color(hex: "FFAC4F"))
                            
                            Text("Continue")
                                .font(.custom("DMSerifDisplay-Italic", size: 14))
                                .foregroundColor(Color(hex: "1A2230"))
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

