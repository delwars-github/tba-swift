import SwiftUI

struct GreatTimeView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var router: AppRouter
    var fromHost: Bool = false

    var body: some View {
        ZStack {
            Color(hex: "#0A0D14").ignoresSafeArea()

            // Gradients
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

                Spacer()

                // Center illustration & text
                VStack(spacing: 20) {
                    Text("👏")
                        .font(.system(size: 80))

                    Text("Hope you\nhad a great time!")
                        .font(.custom("DMSerifDisplay-Regular", size: 30))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)

                    Text("The event has ended. Take a moment to\nreflect on your experience and help the\ncommunity grow.")
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "#E6E2DB"))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }
                .padding(.horizontal, 24)

                Spacer()

                // Bottom Buttons
                VStack(spacing: 20) {
                    Button(action: {
                        if fromHost {
                            router.navigationPath.removeLast(router.navigationPath.count)
                        } else {
                            router.navigationPath.append("HostSurvey")
                        }
                    }) {
                        Text("Post Event\nSurvey")
                            .font(.custom("DMSerifDisplay-Italic", size: 14))
                            .foregroundColor(Color(hex: "#2C3B4D"))
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                            .frame(width: 88, height: 88)
                            .background(Color(hex: "#D4894A"))
                            .clipShape(Circle())
                    }

                    Button(action: {
                        router.navigationPath.removeLast(router.navigationPath.count)
                    }) {
                        Text("Skip for Now")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#E6E2DB"))
                    }
                }
                .padding(.bottom, 32)
            }
        }
        .navigationBarHidden(true)
    }
}

