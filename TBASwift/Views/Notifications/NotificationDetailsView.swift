import SwiftUI

struct NotificationDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var router: AppRouter

    var title: String = "Friday Night Bright"
    var subtitle: String = "You're invited to an exclusive rooftop event"
    var hostName: String = "Celiarn Mitchell"
    var hostRole: String = "Event Organizer"
    var desc: String = "Join us for an intimate evening of live jazz, cocktails, and great conversations overlooking the city skyline."
    var detailedNotes: String = "Dress code: Cocktail chic. Please arrive promptly to ensure entry before the live performances begin."
    var eventDate: String = "Friday, Dec 30, 2026"
    var eventTime: String = "8:00 PM - 1:00 AM"
    var location: String = "The Skylark, Manhattan"

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#FFB162"), Color(hex: "#A35139"), Color(hex: "#1A2534"), Color(hex: "#1A2534")],
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

                    Text("Notification")
                        .font(.custom("DMSerifDisplay-Regular", size: 20))
                        .foregroundColor(.white)

                    Spacer()

                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 16)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Main Details Card
                        VStack(alignment: .leading, spacing: 14) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(title)
                                    .font(.custom("DMSerifDisplay-Regular", size: 22))
                                    .foregroundColor(.white)
                                Text(subtitle)
                                    .font(.system(size: 13))
                                    .foregroundColor(Color.white.opacity(0.7))
                            }

                            // Host Profile Row
                            HStack(spacing: 12) {
                                Image("profile-pic")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())

                                VStack(alignment: .leading, spacing: 2) {
                                    Text(hostName)
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.white)
                                    Text(hostRole)
                                        .font(.system(size: 11))
                                        .foregroundColor(Color.white.opacity(0.6))
                                }
                                Spacer()
                            }
                            .padding(.vertical, 10)
                            .overlay(
                                VStack {
                                    Divider().background(Color.white.opacity(0.12))
                                    Spacer()
                                    Divider().background(Color.white.opacity(0.12))
                                }
                            )

                            // Description & notes
                            VStack(alignment: .leading, spacing: 8) {
                                Text(desc)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                                    .lineSpacing(4)
                                Text(detailedNotes)
                                    .font(.system(size: 13))
                                    .foregroundColor(Color.white.opacity(0.8))
                                    .lineSpacing(4)
                            }
                        }
                        .padding(18)
                        .realGlass(cornerRadius: 20, strokeOpacity: 0.65, lineWidth: 1.2)

                        // Event Information Card
                        VStack(alignment: .leading, spacing: 14) {
                            Text("Event Information")
                                .font(.custom("DMSerifDisplay-Regular", size: 16))
                                .foregroundColor(.white)

                            HStack(spacing: 12) {
                                Image(systemName: "calendar")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color(hex: "#FFAC4F"))
                                    .frame(width: 34, height: 34)
                                    .realGlass(cornerRadius: 8, strokeOpacity: 0.65, lineWidth: 1.0)

                                VStack(alignment: .leading, spacing: 2) {
                                    Text(eventDate)
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(.white)
                                    Text(eventTime)
                                        .font(.system(size: 11))
                                        .foregroundColor(Color.white.opacity(0.6))
                                }
                            }

                            HStack(spacing: 12) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color(hex: "#FFAC4F"))
                                    .frame(width: 34, height: 34)
                                    .realGlass(cornerRadius: 8, strokeOpacity: 0.65, lineWidth: 1.0)

                                VStack(alignment: .leading, spacing: 2) {
                                    Text(location)
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(.white)
                                    Text("New York, NY")
                                        .font(.system(size: 11))
                                        .foregroundColor(Color.white.opacity(0.6))
                                }
                            }
                        }
                        .padding(18)
                        .realGlass(cornerRadius: 20, strokeOpacity: 0.65, lineWidth: 1.2)

                        // Actions
                        VStack(spacing: 10) {
                            Button(action: {
                                router.navigationPath.append("EventDetails")
                            }) {
                                Text("View Event")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(Color(hex: "#1A2230"))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color(hex: "#FFAC4F"))
                                    .cornerRadius(16)
                            }

                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Dismiss")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.0)
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
}

