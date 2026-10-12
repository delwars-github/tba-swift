import SwiftUI

struct HostSurveyView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var router: AppRouter
    @State private var coordination = 0
    @State private var communication = 0
    @State private var creativity = 0

    let progress: CGFloat = 0.35

    var body: some View {
        ZStack {
            Color(hex: "#0A0D14").ignoresSafeArea()

            VStack(spacing: 0) {
                // Header with progress
                HStack(spacing: 16) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .realGlass(cornerRadius: 18, strokeOpacity: 0.65, lineWidth: 1.2)
                    }

                    // Progress bar
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.white.opacity(0.08))
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(hex: "#215A8A"))
                                .frame(width: geo.size.width * progress)
                                .padding(3)
                        }
                    }
                    .frame(height: 24)
                    .realGlass(cornerRadius: 14, strokeOpacity: 0.65, lineWidth: 1.0)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        Image("profile-pic")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 52, height: 52)
                            .clipShape(Circle())
                            .padding(.top, 24)

                        Text("Celiarn was your host.\nHow did they perform?")
                            .font(.custom("DMSerifDisplay-Regular", size: 28))
                            .foregroundColor(.white)
                            .lineSpacing(6)

                        // Rating rows
                        ratingCategory(title: "Coordination", rating: $coordination)
                        ratingCategory(title: "Communication", rating: $communication)
                        ratingCategory(title: "Creativity", rating: $creativity)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 120)
                }

                Spacer()
            }

            // Bottom Continue
            VStack {
                Spacer()
                Button(action: {
                    router.navigationPath.append("HostTwo")
                }) {
                    Text("Continue")
                        .font(.custom("DMSerifDisplay-Italic", size: 15))
                        .foregroundColor(Color(hex: "#1A2534"))
                        .frame(width: 84, height: 84)
                        .background(Color(hex: "#F5A65B"))
                        .clipShape(Circle())
                }
                .padding(.bottom, 24)
            }
        }
        .navigationBarHidden(true)
    }

    private func ratingCategory(title: String, rating: Binding<Int>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.white)

            HStack(spacing: 16) {
                ForEach(1...5, id: \.self) { star in
                    Button(action: {
                        rating.wrappedValue = star
                    }) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 28))
                            .foregroundColor(star <= rating.wrappedValue ? Color(hex: "#FFAC4F") : Color(hex: "#FFE5C8").opacity(0.3))
                    }
                }
            }
        }
    }
}

