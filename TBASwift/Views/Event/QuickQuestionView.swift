import SwiftUI

struct QuickQuestionView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var router: AppRouter
    @State private var answer: String = ""
    
    var hasAnswer: Bool {
        !answer.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
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
                    
                    Text("A quick question")
                        .font(.custom("DMSerifDisplay-Regular", size: 18))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 20)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Why would you like to join this gathering?")
                            .font(.custom("DMSerifDisplay-Regular", size: 32))
                            .foregroundColor(.white)
                            .lineSpacing(4)
                        
                        Text("The host would like to get to know you a bit better before confirming your spot.")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#E6E2DB"))
                            .lineSpacing(6)
                            .padding(.bottom, 32)
                        
                        // Input
                        VStack(spacing: 8) {
                            TextField("Type your response here...", text: $answer, axis: .vertical)
                                .font(.custom("DMSerifDisplay-Regular", size: 16))
                                .foregroundColor(.white)
                                .tint(Color.white.opacity(0.7))
                                .lineLimit(1...5)
                            
                            Rectangle().fill(Color.white.opacity(0.4)).frame(height: 1)
                        }
                        
                    }
                    .padding(.horizontal, 20)
                }
                
                Spacer()
                
                // Bottom Actions
                VStack(spacing: 24) {
                    if hasAnswer {
                        Button(action: {
                            router.navigationPath.append("FeeBreakdown")
                        }) {
                            Text("Continue")
                                .font(.custom("DMSerifDisplay-Italic", size: 14))
                                .foregroundColor(Color(hex: "#1A2534"))
                                .frame(width: 84, height: 84)
                                .background(Color(hex: "#FFB162"))
                                .clipShape(Circle())
                        }
                    } else {
                        Button(action: {}) {
                            Text("Submit")
                                .font(.custom("DMSerifDisplay-Italic", size: 14))
                                .foregroundColor(Color(hex: "#E6E2DB"))
                                .frame(width: 84, height: 84)
                                .realGlass(cornerRadius: 42, strokeOpacity: 0.65, lineWidth: 1.2)
                        }
                        .disabled(true)
                    }
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Go Back")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#E6E2DB"))
                    }
                }
                .padding(.bottom, 32)
            }
        }
        .navigationBarHidden(true)
    }
}

