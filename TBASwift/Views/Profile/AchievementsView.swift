import SwiftUI

struct Achievement: Identifiable {
    let id: String
    let title: String
    let description: String
    let date: String?
    let iconName: String
    var progress: Int?
    var total: Int?
}

struct AchievementsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let unlocked = [
        Achievement(id: "1", title: "First Steps", description: "Complete your first question", date: "Unlocked on 15, 2025", iconName: "figure.walk"),
        Achievement(id: "2", title: "Early Bird", description: "Answer 25 questions", date: "Unlocked on 15, 2025", iconName: "bird"),
        Achievement(id: "3", title: "Mastermind", description: "Maintain a 5-day streak record", date: "Unlocked on 15, 2025", iconName: "brain.head.profile"),
        Achievement(id: "4", title: "Deep Thinker", description: "Complete 10 questions in 3 categories", date: "Unlocked on 15, 2025", iconName: "lightbulb"),
        Achievement(id: "5", title: "Social Butterfly", description: "Get 50 profile views", date: "Unlocked on 15, 2025", iconName: "person.3"),
        Achievement(id: "6", title: "Night Owl", description: "Complete activities after midnight", date: "Unlocked on 15, 2025", iconName: "moon.stars")
    ]
    
    let locked = [
        Achievement(id: "7", title: "Explorer", description: "Complete your first question", date: nil, iconName: "brain.head.profile", progress: 5, total: 6),
        Achievement(id: "8", title: "Insight Hunter", description: "Answer 50 questions", date: nil, iconName: "person.3", progress: 12, total: 30),
        Achievement(id: "9", title: "Community Builder", description: "Answer 10 questions", date: nil, iconName: "moon.stars", progress: 12, total: 30)
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#FFB162"), Color(hex: "#A35139"), Color(hex: "#2C3B4D"), Color(hex: "#1B2632")],
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
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
                    
                    Text("Achievements")
                        .font(.custom("DMSerifDisplay-Regular", size: 20))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 16)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        // Circular Progress Indicator Here
                        HStack {
                            Spacer()
                            ZStack {
                                Circle()
                                    .trim(from: 0, to: 260/360)
                                    .stroke(Color.white.opacity(0.2), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                                    .rotationEffect(.degrees(140))
                                    .frame(width: 110, height: 110)
                                
                                Circle()
                                    .trim(from: 0, to: (260/360) * 0.6)
                                    .stroke(Color.white, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                                    .rotationEffect(.degrees(140))
                                    .frame(width: 110, height: 110)
                                
                                VStack(spacing: -4) {
                                    Text("6")
                                        .font(.custom("DMSerifDisplay-Regular", size: 36))
                                        .foregroundColor(.white)
                                    Text("Unlocked")
                                        .font(.system(size: 11))
                                        .foregroundColor(.white.opacity(0.8))
                                }
                            }
                            Spacer()
                        }
                        .padding(.vertical, 20)
                        
                        Text("Unlocked")
                            .font(.custom("DMSerifDisplay-Regular", size: 16))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                        
                        ForEach(unlocked) { item in
                            HStack(spacing: 12) {
                                Image(systemName: item.iconName)
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                    .frame(width: 80, height: 80)
                                    .background(Color.black.opacity(0.1))
                                    .cornerRadius(22)
                                    .realGlass(cornerRadius: 22, strokeOpacity: 0.5)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.title)
                                        .font(.system(size: 15, weight: .medium))
                                        .foregroundColor(.white)
                                    Text(item.description)
                                        .font(.system(size: 11))
                                        .foregroundColor(Color.white.opacity(0.7))
                                        .lineLimit(2)
                                    if let d = item.date {
                                        Text(d)
                                            .font(.system(size: 10))
                                            .foregroundColor(Color.white.opacity(0.4))
                                    }
                                }
                                Spacer()
                            }
                            .padding(4)
                            .realGlass(cornerRadius: 24, strokeOpacity: 0.65, lineWidth: 1.2)
                            .padding(.horizontal, 20)
                        }
                        
                        Text("Locked")
                            .font(.custom("DMSerifDisplay-Regular", size: 16))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.top, 16)
                        
                        ForEach(locked) { item in
                            HStack(spacing: 12) {
                                ZStack {
                                    Image(systemName: item.iconName)
                                        .font(.system(size: 24))
                                        .foregroundColor(.white.opacity(0.6))
                                        .frame(width: 80, height: 80)
                                        .background(Color.black.opacity(0.3))
                                        .cornerRadius(22)
                                    
                                    Color.white.opacity(0.4).cornerRadius(22)
                                    Color.black.opacity(0.8).cornerRadius(22)
                                    
                                    Image(systemName: "lock.fill")
                                        .foregroundColor(.white)
                                }
                                .frame(width: 80, height: 80)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.title)
                                        .font(.system(size: 15, weight: .medium))
                                        .foregroundColor(.white)
                                    Text(item.description)
                                        .font(.system(size: 12))
                                        .foregroundColor(.white)
                                    
                                    if let p = item.progress, let t = item.total {
                                        HStack {
                                            Text("Progress")
                                                .font(.system(size: 11))
                                                .foregroundColor(Color.white.opacity(0.64))
                                            
                                            GeometryReader { geo in
                                                ZStack(alignment: .leading) {
                                                    Capsule().fill(Color.white.opacity(0.16))
                                                    Capsule()
                                                        .fill(Color.white.opacity(0.5))
                                                        .frame(width: geo.size.width * CGFloat(p) / CGFloat(t))
                                                }
                                            }
                                            .frame(height: 4)
                                            
                                            Text(String(format: "%02d/%02d", p, t))
                                                .font(.system(size: 11))
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding(4)
                            .padding(.trailing, 16)
                            .realGlass(cornerRadius: 24, strokeOpacity: 0.65, lineWidth: 1.2)
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationBarHidden(true)
    }
}
