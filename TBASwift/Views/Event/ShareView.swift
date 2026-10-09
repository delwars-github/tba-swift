import SwiftUI

struct ShareView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let users = [
        ("Marvin...", Color(hex: "#F87171"), "M"),
        ("Darlene...", Color(hex: "#60A5FA"), "D"),
        ("Jerome...", Color(hex: "#FBBF24"), "J"),
        ("Ralph E...", Color(hex: "#A78BFA"), "R"),
        ("Eleanor...", Color(hex: "#34D399"), "E")
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#1B2635"), Color(hex: "#1F2A38"), Color(hex: "#1F2A38"), Color(hex: "#A35139")],
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // Back button
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
                    .padding(.bottom, 100)
                    .padding(.horizontal, 20)
                    
                    // Titles
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Your friend isn't on\nBoring yet")
                            .font(.custom("DMSerifDisplay-Regular", size: 32))
                            .foregroundColor(.white)
                            .lineSpacing(4)
                        
                        Text("Choose how you'd like to bring them")
                            .font(.system(size: 15))
                            .foregroundColor(Color(hex: "#E6E2DB"))
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                    
                    // Link Copy Block
                    Button(action: {
                        UIPasteboard.general.string = "hvsfgg/jsru8423 bbbbbnd12.xgwt"
                    }) {
                        HStack {
                            Text("hvsfgg/jsru8423 bbbbbnd12.xgwt")
                                .font(.system(size: 15))
                                .foregroundColor(Color(hex: "#E6E2DB"))
                            Spacer()
                            Image(systemName: "doc.on.doc")
                                .font(.system(size: 18))
                                .foregroundColor(Color(hex: "#E6E2DB"))
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                        .realGlass(cornerRadius: 22, strokeOpacity: 0.65, lineWidth: 1.2)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 20)
                    
                    // OR divider
                    HStack {
                        Rectangle().fill(Color.white.opacity(0.2)).frame(height: 1)
                        Text("or")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#E6E2DB"))
                            .padding(.horizontal, 16)
                        Rectangle().fill(Color.white.opacity(0.2)).frame(height: 1)
                    }
                    .padding(.vertical, 24)
                    .padding(.horizontal, 20)
                    
                    Text("Share to")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 24)
                    
                    // Users Row
                    VStack(spacing: 24) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(0..<users.count, id: \.self) { idx in
                                    let user = users[idx]
                                    VStack(spacing: 8) {
                                        ZStack {
                                            Circle()
                                                .fill(user.1)
                                                .frame(width: 54, height: 54)
                                            Text(user.2)
                                                .font(.system(size: 20, weight: .bold))
                                                .foregroundColor(.white)
                                        }
                                        Text(user.0)
                                            .font(.system(size: 13))
                                            .foregroundColor(.white)
                                            .lineLimit(1)
                                    }
                                    .frame(width: 70)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.vertical, 24)
                        .realGlass(cornerRadius: 30, strokeOpacity: 0.65, lineWidth: 1.2)
                        
                        // Apps Row
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                // Copy Link
                                ShareAppButton(title: "Copy link", bgColor: .white) {
                                    Image(systemName: "doc.on.doc")
                                        .font(.system(size: 20))
                                        .foregroundColor(.black)
                                }
                                
                                // Facebook
                                ShareAppButton(title: "Facebook", bgColor: Color(hex: "#1877F2")) {
                                    Image("facebook-icon") // Assuming asset exists, fallback to SF if not
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 28, height: 28)
                                        .foregroundColor(.white)
                                }
                                
                                // Instagram
                                ShareAppButton(title: "Instagram", bgGradient: LinearGradient(colors: [Color(hex: "#F56040"), Color(hex: "#FD1D1D"), Color(hex: "#833AB4")], startPoint: .bottomLeading, endPoint: .topTrailing)) {
                                    Image("instagram-icon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 28, height: 28)
                                        .foregroundColor(.white)
                                }
                                
                                // Threads
                                ShareAppButton(title: "Threads", bgColor: .black) {
                                    Text("@")
                                        .font(.custom("DMSerifDisplay-Regular", size: 26))
                                        .foregroundColor(.white)
                                }
                                
                                // Whatsapp
                                ShareAppButton(title: "Whatsapp", bgColor: Color(hex: "#25D366")) {
                                    Image("whatsapp-icon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 28, height: 28)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.vertical, 24)
                        .realGlass(cornerRadius: 30, strokeOpacity: 0.65, lineWidth: 1.2)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                    
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct ShareAppButton<Icon: View>: View {
    var title: String
    var bgColor: Color? = nil
    var bgGradient: LinearGradient? = nil
    @ViewBuilder var icon: () -> Icon
    
    var body: some View {
        Button(action: {}) {
            VStack(spacing: 8) {
                ZStack {
                    if let bgColor = bgColor {
                        Circle().fill(bgColor)
                    } else if let bgGradient = bgGradient {
                        Circle().fill(bgGradient)
                    }
                    icon()
                }
                .frame(width: 44, height: 44)
                
                Text(title)
                    .font(.system(size: 13))
                    .foregroundColor(.white)
                    .lineLimit(1)
            }
            .frame(width: 70)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

