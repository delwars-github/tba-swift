import SwiftUI

struct CreateEventIntroView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var router: AppRouter

    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                colors: [Color(hex: "#FFB162"), Color(hex: "#A35139"), Color(hex: "#2C3B4D"), Color(hex: "#1B2632")],
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
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)

                // Image / Banner
                Image("home-1")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .clipped()
                    .cornerRadius(24)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)

                Spacer()

                // Content
                VStack(spacing: 12) {
                    Text("Create Event")
                        .font(.custom("DMSerifDisplay-Regular", size: 32))
                        .foregroundColor(.white)

                    Text("Start by setting up your event. You'll choose\nhow people join, what type of gathering it is,\nand who it's for.")
                        .font(.system(size: 14))
                        .foregroundColor(Color.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }
                .padding(.horizontal, 24)

                Spacer()

                // Continue Button
                Button(action: {
                    router.navigationPath.append("EventType")
                }) {
                    Text("Continue")
                        .font(.custom("DMSerifDisplay-Italic", size: 14))
                        .foregroundColor(.white)
                        .frame(width: 84, height: 84)
                        .realGlass(cornerRadius: 42, strokeOpacity: 0.65, lineWidth: 1.2)
                }
                .padding(.bottom, 32)
            }
        }
        .navigationBarHidden(true)
    }
}

