import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: AppRouter
    @State private var phoneNumber = ""
    @State private var isTextFieldFocused = false
    @FocusState private var isFocused: Bool
    
    private let digitCount = 11
    
    var digits: [String] {
        let padded = phoneNumber.padding(toLength: digitCount, withPad: " ", startingAt: 0)
        return padded.map { String($0) }
    }
    
    var hasInput: Bool {
        !phoneNumber.isEmpty
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
                        Spacer()
                        // Replace with actual logo image name from assets if needed.
                        Image("main-logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 64, height: 30)
                        Spacer()
                    }
                    .padding(.top, 24)
                    .padding(.horizontal, 20)
                    
                    // Title
                    VStack(alignment: .leading) {
                        Text("Enter Your\nPhone Number")
                            .font(.custom("DMSerifDisplay-Regular", size: 32))
                            .foregroundColor(Color(hex: "#F9EBE0"))
                            .lineSpacing(6)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.top, 120)
                    
                    // Phone Number Input
                    VStack {
                        HStack(spacing: 2) {
                            ForEach(0..<digitCount, id: \.self) { index in
                                let digit = digits[index]
                                let isFilled = digit != " "
                                
                                Text(isFilled ? digit : "-")
                                    .font(.system(size: 12, weight: .heavy))
                                    .foregroundColor(isFilled ? .white : Color.white.opacity(0.4))
                                    .frame(width: 28, height: 28)
                                    .realGlass(cornerRadius: 39, strokeOpacity: 0.65, lineWidth: 1.2)
                            }
                        }
                        .onTapGesture {
                            isFocused = true
                        }
                        
                        TextField("", text: $phoneNumber)
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                            .opacity(0)
                            .frame(width: 0, height: 0)
                            .onChange(of: phoneNumber) { newValue in
                                let filtered = newValue.filter { $0.isNumber }
                                if filtered.count > digitCount {
                                    phoneNumber = String(filtered.prefix(digitCount))
                                } else if filtered != newValue {
                                    phoneNumber = filtered
                                }
                            }
                    }
                    .padding(.top, 55)
                    
                    Spacer(minLength: 60)
                    
                    // Continue Button
                    if phoneNumber.count == digitCount {
                        Button(action: {
                            router.navigationPath.append("EnterName")
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
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

