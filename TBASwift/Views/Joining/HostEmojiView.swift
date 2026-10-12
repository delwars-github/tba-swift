import SwiftUI

struct HostEmojiView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var router: AppRouter
    let progress: CGFloat = 0.85

    let emojis = ["😢", "☹️", "😐", "🙂", "🤩"]

    @State private var overall = -1
    @State private var location = -1
    @State private var people = -1

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
                    VStack(alignment: .leading, spacing: 28) {
                        Text("How was the gathering?")
                            .font(.custom("DMSerifDisplay-Regular", size: 28))
                            .foregroundColor(.white)
                            .padding(.top, 24)

                        emojiSection(title: "Overall Vibe", selection: $overall)
                        emojiSection(title: "Location", selection: $location)
                        emojiSection(title: "The People", selection: $people)
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
                    router.navigationPath.append("UniquenessRating")
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

    private func emojiSection(title: String, selection: Binding<Int>) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.custom("DMSerifDisplay-Regular", size: 15))
                .foregroundColor(.white)

            HStack {
                ForEach(0..<emojis.count, id: \.self) { idx in
                    let isSelected = selection.wrappedValue == idx
                    let hasSelection = selection.wrappedValue != -1
                    let opacity = isSelected ? 1.0 : (hasSelection ? 0.25 : 0.45)

                    Button(action: {
                        selection.wrappedValue = idx
                    }) {
                        Text(emojis[idx])
                            .font(.system(size: isSelected ? 30 : 24))
                            .opacity(opacity)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.vertical, 14)
            .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.0)
        }
    }
}

