import SwiftUI

class AppRouter: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var navigationPath = NavigationPath()
    @Published var selectedEvent: EventItem = MockData.carouselEvents[1]
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
                    EventDetailsView(event: router.selectedEvent)
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
                case "NotificationDetails":
                    NotificationDetailsView()
                case "Terms":
                    TermsView()
                case "Privacy":
                    PrivacyView()
                case "LinkedAccounts":
                    LinkedAccountsView()
                case "DeleteAccount":
                    DeleteAccountView()
                case "DeleteAccountDetails":
                    DeleteAccountDetailsView()
                case "PaymentInfo":
                    PaymentInfoView()
                case "AddPaymentMethod":
                    AddPaymentMethodView()
                case "HostCheckIn":
                    HostCheckInView()
                case "HostSelect":
                    HostSelectView()
                case "GreatTime":
                    GreatTimeView()
                case "HostSurvey":
                    HostSurveyView()
                case "HostTwo":
                    HostTwoView()
                case "HostEmoji":
                    HostEmojiView()
                case "UniquenessRating":
                    UniquenessRatingView()
                case "JoiningEvent":
                    JoiningEventView()
                case "JoiningTwo":
                    JoiningTwoView()
                case "EventChat":
                    EventChatView()
                case "EventPhotos":
                    EventPhotosView()
                case "EventSurvey":
                    EventSurveyView()
                case "CreateEventIntro":
                    CreateEventIntroView()
                case "EventType":
                    EventTypeView()
                case "EventStructure":
                    EventStructureView()
                case "EventStructure2":
                    EventStructure2View()
                case "Preferences":
                    PreferencesView()
                case "GuestEvent":
                    GuestEventView()
                case "Questions":
                    QuestionsView()
                case "EventImage":
                    EventImageView()
                case "ReviewSuccess":
                    ReviewSuccessView()
                default:
                    EmptyView()
                }
            }
        }
        .environmentObject(router)
    }
}

