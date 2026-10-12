import SwiftUI

struct PersonalizeTimeModalView: View {
    @Binding var isPresented: Bool
    var onComplete: (String) -> Void

    struct TimeOption: Identifiable {
        let id: String
        let title: String
    }

    let options: [TimeOption] = [
        TimeOption(id: "morning", title: "morning - afternoon"),
        TimeOption(id: "afternoon", title: "afternoon - evening"),
        TimeOption(id: "evening", title: "evening - night")
    ]

    @State private var selectedId: String = "afternoon"

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
                    Text("Select Time")
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

                // Time Options
                VStack(spacing: 12) {
                    ForEach(options) { item in
                        let isSelected = selectedId == item.id
                        Button {
                            selectedId = item.id
                        } label: {
                            HStack {
                                Text(item.title)
                                    .font(.custom("DMSerifDisplay-Regular", size: 16))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 4)

                                Spacer()

                                if isSelected {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(Color(hex: "#FFB162"))
                                }
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 14)
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
                .padding(.top, 20)
                .padding(.bottom, 24)

                // Save / Complete Button
                Button {
                    withAnimation {
                        isPresented = false
                        onComplete(selectedId)
                    }
                } label: {
                    Text("Apply Filter")
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
            .frame(width: UIScreen.main.bounds.width * 0.92, height: UIScreen.main.bounds.height * 0.52)
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

