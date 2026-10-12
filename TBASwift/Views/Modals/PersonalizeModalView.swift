import SwiftUI

struct PersonalizeModalView: View {
    @Binding var isPresented: Bool
    var onNext: (String) -> Void

    struct Archetype: Identifiable {
        let id: String
        let title: String
        let icon: String
        let traits: String
    }

    let options: [Archetype] = [
        Archetype(id: "wildfire", title: "The Wildfire", icon: "flame.fill", traits: "electric • spontaneous • nomad • boldfire"),
        Archetype(id: "dreamer", title: "The Dreamer", icon: "moon.stars.fill", traits: "boho • dreamer • visionary • blue blooded"),
        Archetype(id: "artist", title: "The Artist", icon: "paintbrush.fill", traits: "unconventional • expression • unique • aesthetic"),
        Archetype(id: "anchor", title: "The Anchor", icon: "anchor", traits: "selfless • introspective • resilient • empathetic")
    ]

    @State private var selectedId: String = "wildfire"

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
                    Text("Personalize")
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

                // Archetype Options
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(options) { item in
                            let isSelected = selectedId == item.id
                            Button {
                                selectedId = item.id
                            } label: {
                                HStack(spacing: 14) {
                                    ZStack {
                                        Circle()
                                            .fill(isSelected ? Color(hex: "#FFB162") : Color.white.opacity(0.1))
                                            .frame(width: 44, height: 44)
                                        Image(systemName: item.icon)
                                            .font(.system(size: 18))
                                            .foregroundColor(isSelected ? .black : .white)
                                    }

                                    VStack(alignment: .leading, spacing: 3) {
                                        Text(item.title)
                                            .font(.custom("DMSerifDisplay-Regular", size: 16))
                                            .foregroundColor(.white)
                                        Text(item.traits)
                                            .font(.system(size: 11))
                                            .foregroundColor(Color.white.opacity(0.75))
                                            .lineLimit(2)
                                    }

                                    Spacer()

                                    if isSelected {
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.system(size: 20))
                                            .foregroundColor(Color(hex: "#FFB162"))
                                    }
                                }
                                .padding(14)
                                .background(
                                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                                        .fill(isSelected ? Color.white.opacity(0.12) : Color.white.opacity(0.04))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                                        .stroke(isSelected ? Color(hex: "#FFB162") : Color.white.opacity(0.15), lineWidth: 1.2)
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 18)
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
            .frame(width: UIScreen.main.bounds.width * 0.92, height: UIScreen.main.bounds.height * 0.75)
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

