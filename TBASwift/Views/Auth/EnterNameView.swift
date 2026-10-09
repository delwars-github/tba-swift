import SwiftUI

struct EnterNameView: View {
    @EnvironmentObject var router: AppRouter
    @State private var name = ""
    @FocusState private var isFocused: Bool
    
    var hasInput: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var body: some View {
        ZStack {
            // Base Gradient
            LinearGradient(
                colors: [Color(hex: "#FFAC4F"), Color(hex: "#A35139"), Color(hex: "#1A2230"), Color(hex: "#1A2230")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Active Gradient
            ZStack {
                LinearGradient(
                    colors: [Color(hex: "#17202D"), Color(hex: "#1A2332"), Color(hex: "#17202D")],
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                LinearGradient(
                    colors: [Color.clear, Color(hex: "#944634").opacity(0.3), Color(hex: "#9E442B"), Color(hex: "#DE6E38"), Color(hex: "#FFAA4E")],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                
                LinearGradient(
                    colors: [Color(hex: "#17202D").opacity(0.92), Color(hex: "#17202D").opacity(0.3), Color.clear, Color(hex: "#17202D").opacity(0.25), Color(hex: "#17202D").opacity(0.92)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
            .opacity(hasInput ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 0.45), value: hasInput)
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Header / Logo
                    HStack {
                        // Back Button
                        Button(action: {
                            if !router.navigationPath.isEmpty {
                                router.navigationPath.removeLast()
                            }
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .realGlass(cornerRadius: 18, strokeOpacity: 0.65, lineWidth: 1.2)
                        }
                        
                        Spacer()
                        
                        Image("main-logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 64, height: 30)
                        
                        Spacer()
                        
                        // Placeholder for symmetry
                        Color.clear.frame(width: 44, height: 44)
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
                    
                    // Title
                    VStack(alignment: .leading) {
                        Text("What's Your Name")
                            .font(.custom("DMSerifDisplay-Regular", size: 32))
                            .foregroundColor(Color(hex: "#F9EBE0"))
                            .lineSpacing(6)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, UIScreen.main.bounds.height * 0.35 - 100) // approx matching '35%' margin top
                    
                    // Name Input
                    VStack {
                        TextField("", text: $name)
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(.white)
                            .focused($isFocused)
                            .padding(.vertical, 8)
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color.white.opacity(0.2)),
                                alignment: .bottom
                            )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 60)
                    
                    Spacer(minLength: 60)
                    
                    // Continue Button
                    if hasInput {
                        Button(action: {
                            router.navigationPath.append("Otp")
                        }) {
                            Text("Continue")
                                .font(.custom("DMSerifDisplay-Regular", size: 14))
                                .foregroundColor(Color(hex: "#1A2230"))
                                .frame(width: 84, height: 84)
                                .background(Color(hex: "#FFAC4F"))
                                .clipShape(Circle())
                        }
                        .padding(.bottom, 60)
                    } else {
                        Button(action: {
                            // Do nothing
                        }) {
                            Text("Continue")
                                .font(.custom("DMSerifDisplay-Regular", size: 14))
                                .foregroundColor(Color(hex: "#C9C1B1"))
                                .frame(width: 84, height: 84)
                                .realGlass(cornerRadius: 42, strokeOpacity: 0.65, lineWidth: 1.2)
                        }
                        .padding(.bottom, 60)
                        .disabled(true)
                    }
                }
                .frame(minHeight: UIScreen.main.bounds.height - 100) // For Spacer to work in ScrollView
            }
        }
        .onAppear {
            isFocused = true
        }
        .navigationBarHidden(true)
    }
}

struct EnterNameView_Previews: PreviewProvider {
    static var previews: some View {
        EnterNameView()
    }
}

