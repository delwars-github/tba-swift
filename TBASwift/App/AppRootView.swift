import SwiftUI

class AppRouter: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var navigationPath = NavigationPath()
}

struct AppRootView: View {
    @StateObject private var router = AppRouter()
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            Group {
                if router.isAuthenticated {
                    MainTabView()
                } else {
                    LoginView()
                }
            }
            .navigationDestination(for: String.self) { route in
                switch route {
                case "EnterName":
                    EnterNameView()
                case "Otp":
                    OtpView()
                case "Settings":
                    SettingsView()
                case "EditProfile":
                    EditProfileView()
                case "Notifications":
                    NotificationsView()
                case "Guest":
                    GuestView()
                case "Payment":
                    PaymentView()
                case "EventDetails":
                    EventDetailsView()
                case "Achievements":
                    AchievementsView()
                case "Share":
                    ShareView()
                case "BailPolicy":
                    BailPolicyView()
                case "FeeBreakdown":
                    FeeBreakdownView()
                case "QuickQuestion":
                    QuickQuestionView()
                case "SelectCard":
                    SelectCardView()
                default:
                    EmptyView()
                }
            }
        }
        .environmentObject(router)
    }
}

