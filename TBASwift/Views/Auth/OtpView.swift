import SwiftUI

struct OtpView: View {
    @EnvironmentObject var router: AppRouter
    var phoneNumber: String = "+23********34"
    @State private var otp = ""
    @FocusState private var isFocused: Bool
    
    private let digitCount = 4
    
    var digits: [String] {
        let padded = otp.padding(toLength: digitCount, withPad: " ", startingAt: 0)
        return padded.map { String($0) }
    }
    
    var hasInput: Bool {
        !otp.isEmpty
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
                    VStack(alignment: .leading, spacing: 0) {
                        (Text("Enter the One Time\nPassword sent to ")
                            .font(.custom("DMSerifDisplay-Regular", size: 32))
                            .foregroundColor(Color(hex: "#F9EBE0"))
                        +
                        Text(phoneNumber)
                            .font(.custom("DMSerifDisplay-Regular", size: 18))
                            .foregroundColor(Color.white.opacity(0.5)))
                            .lineSpacing(6)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, UIScreen.main.bounds.height * 0.35 - 100) // approx matching '35%' margin top
                    
                    // OTP Input
                    VStack {
                        HStack(spacing: 16) {
                            ForEach(0..<digitCount, id: \.self) { index in
                                let digit = digits[index]
                                let isFilled = digit != " "
                                
                                Text(isFilled ? digit : "-")
                                    .font(.system(size: 20, weight: .heavy))
                                    .foregroundColor(isFilled ? .white : Color.white.opacity(0.4))
                                    .frame(width: 70, height: 70)
                                    .realGlass(cornerRadius: 35, strokeOpacity: 0.65, lineWidth: 1.2)
                            }
                        }
                        .onTapGesture {
                            isFocused = true
                        }
                        
                        TextField("", text: $otp)
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                            .opacity(0)
                            .frame(width: 0, height: 0)
                            .onChange(of: otp) { newValue in
                                let filtered = newValue.filter { $0.isNumber }
                                if filtered.count > digitCount {
                                    otp = String(filtered.prefix(digitCount))
                                } else if filtered != newValue {
                                    otp = filtered
                                }
                            }
                    }
                    .padding(.top, 40)
                    
                    // Resend Code
                    Button(action: {
                        // Resend action
                    }) {
                        Text("Resend Code")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color.white.opacity(0.8))
                            .underline()
                    }
                    .padding(.top, 30)
                    
                    Spacer(minLength: 40)
                    
                    // Continue Button
                    if otp.count == digitCount {
                        Button(action: {
                            router.isAuthenticated = true
                            router.navigationPath.removeLast(router.navigationPath.count)
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

struct OtpView_Previews: PreviewProvider {
    static var previews: some View {
        OtpView()
    }
}

