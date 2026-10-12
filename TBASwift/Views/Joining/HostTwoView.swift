import SwiftUI

struct HostTwoView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var router: AppRouter
    let progress: CGFloat = 0.65

    struct Person: Identifiable {
        let id: String
        let name: String
        let image: String
    }

    let people = [
        Person(id: "1", name: "Sarah Mitchell", image: "home-1"),
        Person(id: "2", name: "David Chen", image: "home-2"),
        Person(id: "3", name: "Jessica Taylor", image: "home-3"),
        Person(id: "4", name: "Alex Morgan", image: "home-1"),
        Person(id: "5", name: "Sam Wilson", image: "home-2"),
        Person(id: "6", name: "Emma Watson", image: "home-3")
    ]

    @State private var selectedIds: Set<String> = []

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
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Who did you click with?")
                            .font(.custom("DMSerifDisplay-Regular", size: 28))
                            .foregroundColor(.white)
                            .padding(.top, 24)

                        Text("Select the people you'd like to see again.")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#E6E2DB"))
                            .padding(.bottom, 12)

                        // 2-column Grid
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 10) {
                            ForEach(people) { person in
                                let isSelected = selectedIds.contains(person.id)
                                Button(action: {
                                    if isSelected {
                                        selectedIds.remove(person.id)
                                    } else {
                                        selectedIds.insert(person.id)
                                    }
                                }) {
                                    VStack(spacing: 8) {
                                        Image(person.image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 44, height: 44)
                                            .clipShape(Circle())

                                        Text(person.name)
                                            .font(.custom("DMSerifDisplay-Regular", size: 13))
                                            .foregroundColor(isSelected ? Color(hex: "#1A2534") : .white)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 100)
                                    .background(isSelected ? Color(hex: "#FFAC4F") : Color.clear)
                                    .cornerRadius(16)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(isSelected ? Color.clear : Color.white.opacity(0.12), lineWidth: 1)
                                    )
                                }
                                .realGlass(cornerRadius: 16, strokeOpacity: isSelected ? 0.0 : 0.65, lineWidth: isSelected ? 0.0 : 1.0)
                            }
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
                    router.navigationPath.append("HostEmoji")
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

