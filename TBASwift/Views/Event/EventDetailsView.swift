import SwiftUI

struct EventDetailsView: View {
    @EnvironmentObject var router: AppRouter
    @Environment(\.presentationMode) var presentationMode
    
    // Mock Data mimicking FALLBACK_EVENT_DATA
    let title = "Friday Night Bright"
    let hostName = "Celiarn"
    let date = "Aug 24, 8:00 PM"
    let location = "New York"
    let joined = "15 / 30"
    let tags = ["Gathering", "Social", "Night Out"]
    let description = "A cozy night with good music, fun people, and zero pressure. Notice the vibes, meet new friends, and enjoy a bright Friday-style hangout in the city."
    let highlights = [
        "Photo corner + group moments",
        "Drinks & snacks available",
        "Games and quick activities",
        "Safe, friendly crowd"
    ]
    
    @State private var isFromInvite = false
    @State private var showToast = false
    @State private var isStashModalVisible = false
    
    var body: some View {
        ZStack {
            Color(hex: "#0A0D14").ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Top Image Section
                    ZStack(alignment: .top) {
                        Image("home-1") // Example fallback image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.55)
                            .clipped()
                        
                        // Gradient Overlay for bottom transition
                        LinearGradient(
                            colors: [Color(hex: "#0A0D14").opacity(0), Color(hex: "#0A0D14").opacity(0.8), Color(hex: "#0A0D14")],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 200)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        
                        // Top Bar with Back & Share
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "arrow.left")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(width: 44, height: 44)
                                    .realGlass(cornerRadius: 18, strokeOpacity: 0.65, lineWidth: 1.2)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                // share action
                            }) {
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                                    .frame(width: 44, height: 44)
                                    .realGlass(cornerRadius: 18, strokeOpacity: 0.65, lineWidth: 1.2)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 40) // approx safe area top
                    }
                    
                    // Info Section (overlapping image bottom)
                    VStack(spacing: 0) {
                        // People Joined -> Navigate to GuestView
                        Button(action: { router.navigationPath.append("Guest") }) {
                            VStack(spacing: 0) {
                                Text("\(joined) People Joined")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                                    .padding(.bottom, 6)
                                
                                HStack(spacing: -12) {
                                    Circle().fill(Color.gray).frame(width: 32, height: 32)
                                    Circle().fill(Color.gray).frame(width: 40, height: 40)
                                    Circle().fill(Color.gray).frame(width: 48, height: 48).zIndex(1)
                                    Circle().fill(Color.gray).frame(width: 40, height: 40)
                                    Circle().fill(Color.gray).frame(width: 32, height: 32)
                                }
                                .padding(.bottom, 16)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Text(title)
                            .font(.custom("DMSerifDisplay-Regular", size: 28))
                            .foregroundColor(.white)
                            .tracking(1)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 8)
                        
                        // Date & Location
                        HStack(spacing: 20) {
                            HStack(spacing: 4) {
                                Image("calendar-love-icon")
                                    .resizable().scaledToFit().frame(width: 14, height: 14)
                                Text(date)
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(Color(hex: "#E6E2DB"))
                            }
                            HStack(spacing: 4) {
                                Image(systemName: "mappin.and.ellipse")
                                    .resizable().scaledToFit().frame(width: 14, height: 14)
                                Text(location)
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(Color(hex: "#E6E2DB"))
                            }
                        }
                        .padding(.bottom, 20)
                        
                        // Tags
                        // Implementing a simple wrap layout placeholder using HStack
                        HStack(spacing: 8) {
                            ForEach(tags, id: \.self) { tag in
                                Text(tag)
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.white)
                                    .tracking(0.5)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .realGlass(cornerRadius: 18, strokeOpacity: 0.65, lineWidth: 1.2)
                            }
                        }
                        .padding(.bottom, 24)
                        
                        // About Section
                        Text("About This Event")
                            .font(.custom("DMSerifDisplay-Regular", size: 20))
                            .foregroundColor(.white)
                            .tracking(1)
                            .padding(.bottom, 12)
                        
                        Text(description)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Color(hex: "#E6E2DB"))
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                            .padding(.bottom, 24)
                        
                        // Hosted By
                        HStack {
                            Image("profile-pic")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 48, height: 48)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Hosted By")
                                    .font(.system(size: 13))
                                    .foregroundColor(Color.white.opacity(0.7))
                                Text(hostName)
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                // Message Host
                            }) {
                                Text("Message Host")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 24)
                        
                        // Highlights
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Highlights")
                                .font(.custom("DMSerifDisplay-Regular", size: 20))
                                .foregroundColor(.white)
                                .tracking(1)
                            
                            ForEach(highlights, id: \.self) { highlight in
                                Text(highlight)
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(Color(hex: "#E6E2DB"))
                                    .lineSpacing(4)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 24)
                        
                        // Mock Map placeholder
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 220)
                            .cornerRadius(16)
                            .padding(.horizontal, 16)
                        
                    }
                    .padding(.top, -128)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 120) // For sticky bottom bar
                }
            }
            
            // Sticky Bottom Action Bar
            VStack {
                Spacer()
                
                HStack(spacing: 16) {
                    Button(action: {
                        // Stash
                    }) {
                        Text(isFromInvite ? "Can't Make It" : "Stash")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .tracking(0.5)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .realGlass(cornerRadius: 28, strokeOpacity: 0.65, lineWidth: 1.2)
                    }
                    
                    Button(action: {
                        router.navigationPath.append("Payment")
                    }) {
                        Text(isFromInvite ? "I Will Go" : "I'm In")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black)
                            .tracking(0.5)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color(hex: "#FFB162"))
                            .cornerRadius(28)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 24) // approx safe area bottom
                .background(Color(hex: "#0A0D14"))
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.white.opacity(0.08)),
                    alignment: .top
                )
            }
        }
        .navigationBarHidden(true)
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailsView()
    }
}

