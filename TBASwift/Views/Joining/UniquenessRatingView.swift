import SwiftUI

struct UniquenessRatingView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var router: AppRouter
    @State private var percent: CGFloat = 50

    var body: some View {
        ZStack {
            Color(hex: "#0A0D14").ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
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

                    // Progress bar 100%
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.white.opacity(0.08))
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(hex: "#215A8A"))
                                .frame(width: geo.size.width)
                                .padding(3)
                        }
                    }
                    .frame(height: 24)
                    .realGlass(cornerRadius: 14, strokeOpacity: 0.65, lineWidth: 1.0)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Uniqueness Rating")
                            .font(.custom("DMSerifDisplay-Regular", size: 28))
                            .foregroundColor(.white)
                            .padding(.top, 40)

                        Text("Being basic doesn't mean bad. Rate how unique this gathering felt.")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#E6E2DB"))
                            .lineSpacing(4)
                            .padding(.bottom, 60)

                        // Slider
                        VStack(spacing: 16) {
                            GeometryReader { geometry in
                                let width = geometry.size.width
                                ZStack(alignment: .leading) {
                                    // Track
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white.opacity(0.1))
                                        .frame(height: 24)

                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(hex: "#FFAC4F"))
                                        .frame(width: max(24, width * (percent / 100)), height: 24)

                                    // Thumb
                                    ZStack {
                                        Circle()
                                            .fill(Color(hex: "#FFAC4F"))
                                            .frame(width: 56, height: 56)
                                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                            .shadow(color: Color.black.opacity(0.3), radius: 6)

                                        Text("\(Int(percent))%")
                                            .font(.custom("DMSerifDisplay-Regular", size: 14))
                                            .foregroundColor(Color(hex: "#2C3B4D"))
                                    }
                                    .offset(x: min(max(0, width * (percent / 100) - 28), width - 56))
                                    .gesture(
                                        DragGesture()
                                            .onChanged { value in
                                                let newPercent = min(max(0, value.location.x / width * 100), 100)
                                                percent = newPercent
                                            }
                                    )
                                }
                            }
                            .frame(height: 56)

                            HStack {
                                Text("Basic")
                                    .font(.custom("DMSerifDisplay-Regular", size: 14))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("Unique")
                                    .font(.custom("DMSerifDisplay-Regular", size: 14))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 4)
                        }
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
                    router.navigationPath.removeLast(router.navigationPath.count)
                }) {
                    Text("Continue")
                        .font(.custom("DMSerifDisplay-Italic", size: 15))
                        .foregroundColor(Color(hex: "#2C3B4D"))
                        .frame(width: 84, height: 84)
                        .background(Color(hex: "#F5A65B"))
                        .clipShape(Circle())
                }
                .padding(.bottom, 24)
            }
        }
        .navigationBarHidden(true)
    }
}

