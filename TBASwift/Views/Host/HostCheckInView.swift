import SwiftUI

struct HostCheckInView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var router: AppRouter

    var body: some View {
        ZStack {
            Color(hex: "#1A2534").ignoresSafeArea()

            // Subtle gradients
            VStack {
                Circle()
                    .fill(Color(hex: "#FFAC4F").opacity(0.12))
                    .blur(radius: 80)
                    .frame(width: 300, height: 300)
                    .offset(y: -100)
                Spacer()
                Circle()
                    .fill(Color(hex: "#A35139").opacity(0.15))
                    .blur(radius: 90)
                    .frame(width: 350, height: 350)
                    .offset(y: 100)
            }
            .ignoresSafeArea()

            VStack {
                // Top Bar
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

                Spacer()

                // Center Content
                VStack(spacing: 16) {
                    Text("Host Check-In")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color.white.opacity(0.8))
                        .padding(.horizontal, 14)
                        .padding(.vertical, 6)
                        .realGlass(cornerRadius: 12, strokeOpacity: 0.65, lineWidth: 1.0)

                    Text("Did everyone\nwho RSVP'd attend?")
                        .font(.custom("DMSerifDisplay-Regular", size: 30))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                        .padding(.top, 8)

                    Text("Help us keep the community accountable.\nMark anyone who didn't show up.")
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "#E6E2DB"))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, 24)
                }

                Spacer()

                // Bottom Buttons
                VStack(spacing: 24) {
                    Button(action: {
                        router.navigationPath.append("HostSelect")
                    }) {
                        Text("Yes,\nEveryone Came")
                            .font(.custom("DMSerifDisplay-Italic", size: 14))
                            .foregroundColor(Color(hex: "#1A2534"))
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                            .frame(width: 116, height: 116)
                            .background(Color(hex: "#FFB162"))
                            .clipShape(Circle())
                    }

                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("No, Someone Bailed")
                            .font(.system(size: 15))
                            .foregroundColor(Color(hex: "#E6E2DB"))
                    }
                }
                .padding(.bottom, 32)
            }
        }
        .navigationBarHidden(true)
    }
}

