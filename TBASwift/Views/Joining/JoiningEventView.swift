import SwiftUI

struct JoiningEventView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var router: AppRouter
    var eventName: String = "Friday Night Bright"
    var location: String = "Brooklyn, New York"
    var startingIn: String = "8 mins"

    var body: some View {
        ZStack {
            Color(hex: "#0A0D14").ignoresSafeArea()

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
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Ready to join?")
                            .font(.custom("DMSerifDisplay-Regular", size: 32))
                            .foregroundColor(.white)
                            .padding(.top, 20)

                        // Event Summary Card
                        VStack(alignment: .leading, spacing: 14) {
                            Text(eventName)
                                .font(.custom("DMSerifDisplay-Regular", size: 22))
                                .foregroundColor(.white)

                            HStack(spacing: 6) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.system(size: 13))
                                    .foregroundColor(.white)
                                Text(location)
                                    .font(.system(size: 13))
                                    .foregroundColor(.white)
                            }

                            HStack(spacing: 6) {
                                Text("Starting in \(startingIn)")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color.white.opacity(0.9))
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(hex: "#FF4C4C").opacity(0.2))
                            .cornerRadius(16)
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .realGlass(cornerRadius: 20, strokeOpacity: 0.65, lineWidth: 1.2)

                        Text("Once you arrive at the location, tap the button below to check in and unlock the event details.")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#E6E2DB"))
                            .lineSpacing(4)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 120)
                }

                Spacer()

                // Bottom Buttons
                VStack(spacing: 16) {
                    Button(action: {
                        router.navigationPath.append("JoiningTwo")
                    }) {
                        Text("I'm Here")
                            .font(.custom("DMSerifDisplay-Regular", size: 16))
                            .foregroundColor(Color(hex: "#2C3B4D"))
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color(hex: "#FFB162"))
                            .cornerRadius(28)
                    }

                    Button(action: {}) {
                        Text("Need Directions?")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#E6E2DB"))
                            .underline()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .navigationBarHidden(true)
    }
}

