import SwiftUI

struct PersonalizeVibeModalView: View {
    @Binding var isPresented: Bool
    var onNext: (String) -> Void

    struct VibeOption: Identifiable {
        let id: String
        let title: String
        let icon: String
        let traits: String
    }

    let options: [VibeOption] = [
        VibeOption(id: "active", title: "Active Event", icon: "figure.run", traits: "Structured event with clear rules, goals, or outcomes"),
        VibeOption(id: "chill", title: "Chill Event", icon: "cup.and.saucer.fill", traits: "Casual, relaxed, low-pressure hangout")
    ]

    @State private var selectedId: String = "active"

    var body: some View {
        ZStack {
            Color.black.opacity(0.65)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation { isPresented = false }
                }

            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("Select Vibe")
                        .font(.custom("DMSerifDisplay-Regular", size: 18))
                        .foregroundColor(.white)

                    Spacer()

                    Button {
                        withAnimation { isPresented = false }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Color.white.opacity(0.12))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 22)
                .padding(.top, 22)
                .padding(.bottom, 16)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.white.opacity(0.2)),
                    alignment: .bottom
                )

                // Vibe Cards
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(options) { item in
                            let isSelected = selectedId == item.id
                            Button {
                                selectedId = item.id
                            } label: {
                                HStack(spacing: 16) {
                                    ZStack {
                                        Circle()
                                            .fill(isSelected ? Color(hex: "#FFB162") : Color.white.opacity(0.1))
                                            .frame(width: 48, height: 48)
                                        Image(systemName: item.icon)
                                            .font(.system(size: 20))
                                            .foregroundColor(isSelected ? .black : .white)
                                    }

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(item.title)
                                            .font(.custom("DMSerifDisplay-Regular", size: 17))
                                            .foregroundColor(.white)
                                        Text(item.traits)
                                            .font(.system(size: 12))
                                            .foregroundColor(Color.white.opacity(0.75))
                                    }

                                    Spacer()

                                    if isSelected {
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.system(size: 20))
                                            .foregroundColor(Color(hex: "#FFB162"))
                                    }
                                }
                                .padding(16)
                                .background(
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .fill(isSelected ? Color.white.opacity(0.12) : Color.white.opacity(0.04))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .stroke(isSelected ? Color(hex: "#FFB162") : Color.white.opacity(0.15), lineWidth: 1.2)
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                }

                // Next Button
                Button {
                    withAnimation {
                        isPresented = false
                        onNext(selectedId)
                    }
                } label: {
                    Text("Next")
                        .font(.custom("DMSerifDisplay-Regular", size: 15))
                        .foregroundColor(Color(hex: "#182633"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(hex: "#FFB162"))
                        .cornerRadius(25)
                }
                .padding(.horizontal, 22)
                .padding(.bottom, 20)
            }
            .frame(width: UIScreen.main.bounds.width * 0.92, height: UIScreen.main.bounds.height * 0.55)
            .background(
                LinearGradient(
                    colors: [
                        Color(hex: "#A35139"),
                        Color(hex: "#1A2534"),
                        Color(hex: "#1A2534"),
                        Color(hex: "#A35139")
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 36, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 36, style: .continuous)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.5), radius: 24)
        }
    }
}

