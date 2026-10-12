import SwiftUI

struct EventPhotosView: View {
    @Environment(\.presentationMode) var presentationMode
    var eventTitle: String = "Summer BBQ Cookout"

    let photoNames = ["home-1", "home-2", "home-3", "home-1", "home-2", "home-3", "home-1", "home-2", "home-3"]

    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#FFB162"), Color(hex: "#A35139"), Color(hex: "#2C3B4D"), Color(hex: "#1B2632")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack(spacing: 12) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .realGlass(cornerRadius: 18, strokeOpacity: 0.65, lineWidth: 1.2)
                    }

                    Text(eventTitle)
                        .font(.custom("DMSerifDisplay-Regular", size: 20))
                        .foregroundColor(.white)

                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 8)

                // Subheader
                HStack {
                    Text("Photo Album (123)")
                        .font(.custom("DMSerifDisplay-Regular", size: 14))
                        .foregroundColor(.white)
                        .tracking(1)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)

                // Grid
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(0..<photoNames.count, id: \.self) { idx in
                            Image(photoNames[idx])
                                .resizable()
                                .scaledToFill()
                                .frame(height: 140)
                                .clipped()
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white.opacity(0.15), lineWidth: 1)
                                )
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

