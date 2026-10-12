import SwiftUI

struct HostSelectView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var router: AppRouter

    struct Person: Identifiable {
        let id: String
        let name: String
        let image: String
    }

    let people = [
        Person(id: "1", name: "Sarah Mitchell", image: "home-1"),
        Person(id: "2", name: "David Chen", image: "home-2"),
        Person(id: "3", name: "Jessica Taylor", image: "home-3"),
        Person(id: "4", name: "Alex Morgan", image: "home-1")
    ]

    @State private var selectedIds: Set<String> = []

    var body: some View {
        ZStack {
            Color(hex: "#1A2534").ignoresSafeArea()

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

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Who did you click with?")
                            .font(.custom("DMSerifDisplay-Regular", size: 28))
                            .foregroundColor(.white)
                            .padding(.top, 16)

                        Text("Select the people you'd like to see again.")
                            .font(.system(size: 15))
                            .foregroundColor(Color(hex: "#E6E2DB"))
                            .padding(.bottom, 16)

                        // People list
                        VStack(spacing: 10) {
                            ForEach(people) { person in
                                let isSelected = selectedIds.contains(person.id)
                                Button(action: {
                                    if isSelected {
                                        selectedIds.remove(person.id)
                                    } else {
                                        selectedIds.insert(person.id)
                                    }
                                }) {
                                    HStack {
                                        Image(person.image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 40, height: 40)
                                            .clipShape(Circle())

                                        Text(person.name)
                                            .font(.custom("DMSerifDisplay-Regular", size: 15))
                                            .foregroundColor(isSelected ? Color(hex: "#1A2534") : .white)
                                            .padding(.leading, 8)

                                        Spacer()
                                    }
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 10)
                                    .background(isSelected ? Color(hex: "#FFAC4F") : Color.clear)
                                    .cornerRadius(18)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 18)
                                            .stroke(isSelected ? Color.clear : Color.white.opacity(0.1), lineWidth: 1)
                                    )
                                    .shadow(color: isSelected ? Color(hex: "#FFAC4F").opacity(0.3) : Color.clear, radius: 8, y: 4)
                                }
                                .realGlass(cornerRadius: 18, strokeOpacity: isSelected ? 0.0 : 0.65, lineWidth: isSelected ? 0.0 : 1.0)
                            }
                        }

                        Text("Selected people will receive a strike\naccording to the bailout rules.")
                            .font(.custom("DMSerifDisplay-Regular", size: 14))
                            .foregroundColor(Color(hex: "#FFAC4F"))
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 24)
                            .padding(.horizontal, 20)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 120)
                }

                Spacer()
            }

            // Continue Button (Bottom Centered)
            VStack {
                Spacer()
                Button(action: {
                    router.navigationPath.append("GreatTime")
                }) {
                    Text("Continue")
                        .font(.custom("DMSerifDisplay-Italic", size: 14))
                        .foregroundColor(Color(hex: "#1A2534"))
                        .frame(width: 84, height: 84)
                        .background(Color(hex: "#FFAC4F"))
                        .clipShape(Circle())
                }
                .padding(.bottom, 24)
            }
        }
        .navigationBarHidden(true)
    }
}

