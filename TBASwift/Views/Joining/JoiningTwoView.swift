import SwiftUI

struct JoiningTwoView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var router: AppRouter
    var eventName: String = "Friday Night Bright"

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#2C3B4D"), Color(hex: "#1B2632"), Color(hex: "#A35139"), Color(hex: "#A35139")],
                startPoint: .top,
                endPoint: .bottom
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

                Spacer()

                // Center message
                VStack(alignment: .leading, spacing: 16) {
                    Text("You're at\n\(eventName)")
                        .font(.custom("DMSerifDisplay-Regular", size: 34))
                        .foregroundColor(.white)
                        .lineSpacing(6)

                    Text("Lock your phone and enjoy the moment. We'll see\nyou on the other side.")
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "#E6E2DB"))
                        .lineSpacing(4)
                }
                .padding(.horizontal, 24)

                Spacer()

                // Skip to End button
                Button(action: {
                    router.navigationPath.append("GreatTime")
                }) {
                    Text("Skip To End!")
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "#E6E2DB"))
                        .tracking(0.3)
                        .padding(.vertical, 14)
                }
                .padding(.bottom, 32)
            }
        }
        .navigationBarHidden(true)
    }
}

