import SwiftUI

// MARK: - MyEventsView

struct MyEventsView: View {
    @EnvironmentObject var router: AppRouter
    @State private var selectedTab: String = "Past"
    private let tabs = ["Past", "Upcoming", "Planned"]

    var body: some View {
        ZStack {
            // ── Vibrant warm-to-midnight gradient background ──
            LinearGradient(
                stops: [
                    .init(color: Color(hex: "D97724"), location: 0.0),
                    .init(color: Color(hex: "C85A17"), location: 0.25),
                    .init(color: Color(hex: "3A2818"), location: 0.48),
                    .init(color: Color(hex: "0E131F"), location: 0.72),
                    .init(color: Color(hex: "090B10"), location: 1.0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                // ── Header ──
                HStack {
                    Text("My Event")
                        .font(.system(size: 24, weight: .regular, design: .serif))
                        .foregroundColor(.white)
                        .tracking(0.5)

                    Spacer()

                    HStack(spacing: 16) {
                        Button(action: {}) {
                            Text("Personalize")
                                .font(.system(size: 13, weight: .medium))
                                .underline()
                                .foregroundColor(Color(hex: "FFD1AA"))
                        }
                        Button(action: {}) {
                            Text("Stash")
                                .font(.system(size: 13, weight: .medium))
                                .underline()
                                .foregroundColor(Color(hex: "FFD1AA"))
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 56)
                .padding(.bottom, 16)

                // ── Segmented tab selector (glass pill) ──
                HStack(spacing: 4) {
                    ForEach(tabs, id: \.self) { tab in
                        Button {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                                selectedTab = tab
                            }
                        } label: {
                            Text(tab)
                                .font(.system(size: 14, weight: selectedTab == tab ? .semibold : .medium))
                                .foregroundColor(selectedTab == tab ? .white : .white.opacity(0.85))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background {
                                    if selectedTab == tab {
                                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                                            .fill(Color(hex: "F59E2E"))
                                            .shadow(color: Color(hex: "F59E2E").opacity(0.35), radius: 8, y: 2)
                                    }
                                }
                        }
                    }
                }
                .padding(4)
                .glassCard(cornerRadius: 18)
                .padding(.horizontal, 20)
                .padding(.bottom, 14)

                // ── Scrollable event list ──
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        if selectedTab == "Planned" {
                            RevenueCard()
                            ForEach(MockData.plannedEvents) { event in
                                Button(action: { router.navigationPath.append("EventDetails") }) {
                                    PlannedEventCard(event: event)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        } else if selectedTab == "Upcoming" {
                            ForEach(MockData.upcomingEvents) { event in
                                Button(action: { router.navigationPath.append("EventDetails") }) {
                                    PlannedEventCard(event: event)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        } else {
                            ForEach(MockData.pastEvents) { event in
                                Button(action: { router.navigationPath.append("EventDetails") }) {
                                    PastEventRow(event: event)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        Spacer().frame(height: 120)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 6)
                }
            }
        }
    }
}

// MARK: - Revenue Card

private struct RevenueCard: View {
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.06))
                    .frame(width: 44, height: 44)
                Image(systemName: "dollarsign.circle")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
            }
            .overlay(
                Circle()
                    .strokeBorder(Color.white.opacity(0.25), lineWidth: 1)
            )

            VStack(alignment: .leading, spacing: 3) {
                Text("$2,540")
                    .font(.system(size: 20, weight: .regular, design: .serif))
                    .foregroundColor(.white)
                Text("Total Revenue")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.7))
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white.opacity(0.5))
        }
        .padding(14)
        .glassCard(cornerRadius: 28)
    }
}

// MARK: - Past Event Row

private struct PastEventRow: View {
    let event: EventItem

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Left: event cover photo with "Ended" badge
            ZStack(alignment: .topLeading) {
                Image(event.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 108, height: 118)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

                // Semi-transparent frosted "Ended" pill badge
                Text(event.status ?? "Ended")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 4)
                    .glassPill(fillOpacity: 0.16, strokeOpacity: 0.35, lineWidth: 0.8)
                    .padding(7)
            }
            .frame(width: 108, height: 118)

            // Right: title, meta, action buttons
            VStack(alignment: .leading, spacing: 6) {
                Text(event.title)
                    .font(.system(size: 16, weight: .regular, design: .serif))
                    .foregroundColor(.white)
                    .lineLimit(2)

                HStack(spacing: 10) {
                    Label(event.date, systemImage: "calendar")
                    if let time = event.time {
                        Label(time, systemImage: "clock")
                    }
                }
                .font(.system(size: 11))
                .foregroundColor(Color(hex: "E6E2DB"))
                .labelStyle(.titleAndIcon)

                Spacer()

                // Action buttons
                HStack(spacing: 8) {
                    Button {} label: {
                        Text("Photos")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 9)
                            .background(Color(hex: "AE4B30"))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .shadow(color: Color(hex: "AE4B30").opacity(0.3), radius: 4, y: 2)
                    }

                    Button {} label: {
                        Text("Survey")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.white.opacity(0.95))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 9)
                            .glassCard(cornerRadius: 12)
                    }
                }
            }
            .frame(height: 118)
        }
        .padding(8)
        .glassCard(cornerRadius: 28)
    }
}

// MARK: - Planned / Upcoming Event Card

private struct PlannedEventCard: View {
    let event: EventItem

    var body: some View {
        ZStack(alignment: .leading) {
            // Full landscape banner
            Image(event.imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()

            // Left-to-right scrim for legibility
            LinearGradient(
                stops: [
                    .init(color: Color(hex: "0E131F"),                location: 0.0),
                    .init(color: Color(hex: "0E131F").opacity(0.85),  location: 0.50),
                    .init(color: Color(hex: "0E131F").opacity(0.20),  location: 0.82),
                    .init(color: .clear,                              location: 1.0)
                ],
                startPoint: .leading,
                endPoint: .trailing
            )

            VStack(alignment: .leading, spacing: 10) {
                Text(event.title)
                    .font(.system(size: 18, weight: .regular, design: .serif))
                    .foregroundColor(.white)
                    .lineLimit(1)

                HStack(spacing: 12) {
                    Label(event.date, systemImage: "calendar")
                    if let time = event.time {
                        Label(time, systemImage: "clock")
                    }
                    Label(event.location, systemImage: "mappin.and.ellipse")
                }
                .font(.system(size: 11))
                .foregroundColor(.white.opacity(0.80))
                .labelStyle(.titleAndIcon)

                Divider()
                    .background(Color.white.opacity(0.15))

                HStack {
                    HStack(spacing: 8) {
                        if let status = event.status {
                            Text(status)
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 9)
                                .padding(.vertical, 4)
                                .background(Color(hex: "FF4C4C").opacity(0.25))
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule().strokeBorder(
                                        LinearGradient(
                                            stops: [
                                                .init(color: .white.opacity(0.30), location: 0.0),
                                                .init(color: .white.opacity(0.05), location: 0.5),
                                                .init(color: .white.opacity(0.15), location: 1.0)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 0.8
                                    )
                                    .blendMode(.overlay)
                                )
                        }

                        if let attending = event.attending {
                            HStack(spacing: 4) {
                                Image(systemName: "person.2")
                                    .font(.system(size: 10))
                                Text(attending)
                                    .font(.system(size: 11))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 9)
                            .padding(.vertical, 4)
                            .background(Color(hex: "FF4C4C").opacity(0.20))
                            .clipShape(Capsule())
                            .overlay(
                                Capsule().strokeBorder(
                                    LinearGradient(
                                        stops: [
                                            .init(color: .white.opacity(0.25), location: 0.0),
                                            .init(color: .white.opacity(0.05), location: 0.5),
                                            .init(color: .white.opacity(0.15), location: 1.0)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 0.8
                                )
                                .blendMode(.overlay)
                            )
                        }
                    }

                    Spacer()

                    if let price = event.price {
                        Text(price)
                            .font(.system(size: 16, weight: .bold, design: .serif))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(16)
        }
        .frame(height: 155)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .overlay(
            ZStack {
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .strokeBorder(Color.white.opacity(0.18), lineWidth: 0.8)

                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .strokeBorder(
                        LinearGradient(
                            stops: [
                                .init(color: .white.opacity(0.50), location: 0.0),
                                .init(color: .white.opacity(0.20), location: 0.30),
                                .init(color: .clear,              location: 0.65),
                                .init(color: .white.opacity(0.25), location: 1.0)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1.0
                    )
            }
        )
        .shadow(color: .black.opacity(0.35), radius: 16, y: 8)
    }
}
