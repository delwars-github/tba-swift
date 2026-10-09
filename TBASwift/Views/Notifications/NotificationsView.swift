import SwiftUI

struct NotificationItem: Identifiable {
    let id: String
    let type: String
    let title: String
    let desc: String
    let time: String
    let unread: Bool
    let image: String // image name
}

let mockNewNotifications = [
    NotificationItem(id: "1", type: "invite", title: "You're Invited!", desc: "Alex invited you to \"Friday Night Bright\".", time: "2m ago", unread: true, image: "home-1"),
    NotificationItem(id: "2", type: "going", title: "You're Going!", desc: "You accepted the invitation & going to \"Friday Night Bright\".", time: "15m ago", unread: true, image: "home-2"),
    NotificationItem(id: "3", type: "message", title: "New Message", desc: "Celliarn sent you a message about \"Friday Night Bright\".", time: "15m ago", unread: false, image: "home-3"),
    NotificationItem(id: "4", type: "update", title: "Event Update", desc: "\"Morning Fitness\" time has been changed to 7:00 AM.", time: "15m ago", unread: false, image: "home-1")
]

let mockEarlierNotifications = [
    NotificationItem(id: "5", type: "invite", title: "You're Invited!", desc: "Alex invited you to \"Friday Night Bright\".", time: "2d ago", unread: false, image: "home-2"),
    NotificationItem(id: "6", type: "going", title: "You're In!", desc: "You accepted the invitation to \"Friday Night Bright\".", time: "01 July 26", unread: false, image: "home-3")
]

struct BadgeStyle {
    let icon: String
    let color: Color
}

func getBadgeStyle(type: String) -> BadgeStyle {
    switch type {
    case "invite": return BadgeStyle(icon: "calendar", color: Color(hex: "#D9904F"))
    case "going": return BadgeStyle(icon: "checkmark.circle", color: Color(hex: "#63AB5C"))
    case "message": return BadgeStyle(icon: "message", color: Color(hex: "#6B5AAC"))
    case "update": return BadgeStyle(icon: "arrow.triangle.2.circlepath", color: Color(hex: "#4A7EE5"))
    default: return BadgeStyle(icon: "bell", color: Color(hex: "#D9904F"))
    }
}

struct NotificationsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var activeTab = "All"
    
    let tabs = ["All", "Invites", "Updates"]
    
    func renderNotificationCard(item: NotificationItem) -> some View {
        let badge = getBadgeStyle(type: item.type)
        
        return Button(action: {
            // handle action
        }) {
            HStack(spacing: 16) {
                // Avatar & Badge
                ZStack(alignment: .bottomTrailing) {
                    Image(item.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 72, height: 72)
                        .cornerRadius(18)
                        .clipped()
                    
                    // Badge
                    ZStack {
                        badge.color.opacity(0.6)
                        Image(systemName: badge.icon)
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }
                    .frame(width: 24, height: 24)
                    .realGlass(cornerRadius: 8, strokeOpacity: 0.65, lineWidth: 1.2)
                    .offset(x: 4, y: 4)
                }
                
                // Content
                VStack(alignment: .leading, spacing: 10) {
                    Text(item.title)
                        .font(.custom("DMSerifDisplay-Regular", size: 14))
                        .foregroundColor(.white)
                    
                    Text(item.desc)
                        .font(.system(size: 12))
                        .foregroundColor(Color.white.opacity(0.8))
                        .lineLimit(2)
                        .lineSpacing(4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Right Side
                VStack(alignment: .trailing, spacing: 0) {
                    HStack(spacing: 6) {
                        Text(item.time)
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                        
                        Circle()
                            .fill(item.unread ? Color.white : Color.clear)
                            .frame(width: 8, height: 8)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
                .frame(height: 56)
            }
            .padding(4)
            .padding(.trailing, 12)
            .realGlass(cornerRadius: 20, strokeOpacity: 0.65, lineWidth: 1.2)
        }
        .padding(.bottom, 8)
    }
    
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                colors: [Color(hex: "#FFAC4F"), Color(hex: "#A35139"), Color(hex: "#1A2230"), Color(hex: "#1A2230")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
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
                    
                    Text("Notifications")
                        .font(.custom("DMSerifDisplay-Regular", size: 20))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .padding(.bottom, 16)
                
                // Tabs
                HStack(spacing: 0) {
                    ForEach(tabs, id: \.self) { tab in
                        Button(action: {
                            activeTab = tab
                        }) {
                            Text(tab)
                                .font(.system(size: 14, weight: activeTab == tab ? .semibold : .regular))
                                .foregroundColor(activeTab == tab ? Color(hex: "#1A2230") : .white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(activeTab == tab ? Color(hex: "#FFAC4F") : Color.clear)
                                .cornerRadius(12)
                        }
                    }
                }
                .padding(4)
                .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        let filteredNew = filterNotifications(mockNewNotifications)
                        let filteredEarlier = filterNotifications(mockEarlierNotifications)
                        
                        if !filteredNew.isEmpty {
                            Text("New")
                                .font(.custom("DMSerifDisplay-Regular", size: 16))
                                .foregroundColor(.white)
                                .padding(.bottom, 12)
                            
                            ForEach(filteredNew) { item in
                                renderNotificationCard(item: item)
                            }
                        }
                        
                        if !filteredEarlier.isEmpty {
                            Text("Earlier")
                                .font(.custom("DMSerifDisplay-Regular", size: 16))
                                .foregroundColor(.white)
                                .padding(.top, filteredNew.isEmpty ? 0 : 16)
                                .padding(.bottom, 12)
                            
                            ForEach(filteredEarlier) { item in
                                renderNotificationCard(item: item)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    func filterNotifications(_ list: [NotificationItem]) -> [NotificationItem] {
        if activeTab == "All" { return list }
        if activeTab == "Invites" { return list.filter { $0.type == "invite" } }
        if activeTab == "Updates" { return list.filter { $0.type == "update" || $0.type == "message" || $0.type == "going" } }
        return list
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}

