import SwiftUI

struct StashModalView: View {
    @Binding var isPresented: Bool
    @ObservedObject var stashManager = StashManager.shared
    var onSelectEvent: ((EventItem) -> Void)? = nil

    var body: some View {
        ZStack {
            // Dimmed backdrop
            Color.black.opacity(0.65)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        isPresented = false
                    }
                }

            // Modal Card
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("Stash")
                        .font(.custom("DMSerifDisplay-Regular", size: 18))
                        .foregroundColor(.white)

                    Spacer()

                    Button {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            isPresented = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .bold))
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

                // Scroll Content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        if stashManager.stashEvents.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "bookmark.slash")
                                    .font(.system(size: 38))
                                    .foregroundColor(.white.opacity(0.4))
                                Text("No saved events in your stash yet.")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white.opacity(0.6))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 60)
                        } else {
                            ForEach(stashManager.stashEvents) { event in
                                StashCardItem(event: event) {
                                    withAnimation {
                                        stashManager.removeFromStash(id: event.id)
                                    }
                                } onTap: {
                                    isPresented = false
                                    onSelectEvent?(event)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 18)
                    .padding(.bottom, 24)
                }

                // Close / Next Button
                Button {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        isPresented = false
                    }
                } label: {
                    Text("Done")
                        .font(.custom("DMSerifDisplay-Regular", size: 15))
                        .foregroundColor(Color(hex: "#182633"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(hex: "#FFB162"))
                        .cornerRadius(25)
                }
                .padding(.horizontal, 22)
                .padding(.bottom, 20)
                .padding(.top, 8)
            }
            .frame(width: UIScreen.main.bounds.width * 0.92, height: UIScreen.main.bounds.height * 0.82)
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
            .shadow(color: Color.black.opacity(0.5), radius: 24, y: 10)
        }
    }
}

// MARK: - Stash Card Item Component
private struct StashCardItem: View {
    let event: EventItem
    let onDelete: () -> Void
    let onTap: () -> Void

    var body: some View {
        ZStack(alignment: .leading) {
            // Background Event Image
            Image(event.imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()

            // Dark Blue Scrim Gradient (Matching TBA Native exactly)
            LinearGradient(
                stops: [
                    .init(color: Color(hex: "#1A2534"), location: 0.0),
                    .init(color: Color(hex: "#1A2534").opacity(0.85), location: 0.55),
                    .init(color: Color(hex: "#1A2534").opacity(0.15), location: 0.9),
                    .init(color: Color.clear, location: 1.0)
                ],
                startPoint: .leading,
                endPoint: .trailing
            )

            // Content
            VStack(alignment: .leading, spacing: 8) {
                Text(event.title)
                    .font(.custom("DMSerifDisplay-Regular", size: 18))
                    .foregroundColor(.white)
                    .lineLimit(1)

                HStack(spacing: 12) {
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.system(size: 11))
                            .foregroundColor(.white)
                        Text(event.date)
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }

                    HStack(spacing: 4) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 11))
                            .foregroundColor(.white)
                        Text(event.location)
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }
                }

                Rectangle()
                    .fill(Color.white.opacity(0.15))
                    .frame(height: 1)
                    .padding(.vertical, 4)

                HStack {
                    // Attending Pill
                    HStack(spacing: 4) {
                        Image(systemName: "person.2")
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                        Text(event.attending ?? "\(event.joined) / 30")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(hex: "#FF4C4C").opacity(0.2))
                    .cornerRadius(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.white.opacity(0.15), lineWidth: 1)
                    )

                    Spacer()

                    // Delete button
                    Button(action: onDelete) {
                        Image(systemName: "trash")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Color.white.opacity(0.1))
                            .clipShape(Circle())
                    }
                }
            }
            .padding(16)
        }
        .frame(height: 135)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(Color.white.opacity(0.18), lineWidth: 1)
        )
        .onTapGesture(perform: onTap)
    }
}

