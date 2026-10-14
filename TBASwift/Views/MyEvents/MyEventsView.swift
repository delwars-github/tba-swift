import SwiftUI

// MARK: - MyEventsView

struct MyEventsView: View {
    @EnvironmentObject var router: AppRouter
    @Namespace private var tabAnimationNamespace
    @State private var selectedTab: String = "Past"
    private let tabs = ["Past", "Upcoming", "Planned"]

    @State private var isStashModalVisible = false
    @State private var isPersonalizeModalVisible = false
    @State private var isPersonalizeVibeModalVisible = false
    @State private var isPersonalizeTimeModalVisible = false

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
                        Button(action: {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) { isPersonalizeModalVisible = true }
                        }) {
                            Text("Personalize")
                                .font(.system(size: 13, weight: .medium))
                                .underline()
                                .foregroundColor(Color(hex: "FFD1AA"))
                        }
                        .buttonStyle(GlassInteractiveButtonStyle(scaleAmount: 0.94))

                        Button(action: {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) { isStashModalVisible = true }
                        }) {
                            Text("Stash")
                                .font(.system(size: 13, weight: .medium))
                                .underline()
                                .foregroundColor(Color(hex: "FFD1AA"))
                        }
                        .buttonStyle(GlassInteractiveButtonStyle(scaleAmount: 0.94))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 56)
                .padding(.bottom, 16)

                // ── Segmented tab selector (glass pill) ──
                HStack(spacing: 4) {
                    ForEach(tabs, id: \.self) { tab in
                        Button {
                            UISelectionFeedbackGenerator().selectionChanged()
                            withAnimation(.spring(response: 0.32, dampingFraction: 0.72)) {
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
                                            .matchedGeometryEffect(id: "MY_EVENTS_ACTIVE_TAB_PILL", in: tabAnimationNamespace)
                                    }
                                }
                        }
                        .buttonStyle(.plain)
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
                                .glassStagger(index: 0, delayOffset: 0.08)
                                .scrollTransition(.animated.threshold(.visible(0.15))) { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1.0 : 0.45)
                                        .scaleEffect(phase.isIdentity ? 1.0 : 0.94)
                                        .offset(y: phase.isIdentity ? 0 : 20)
                                }

                            ForEach(Array(MockData.plannedEvents.enumerated()), id: \.element.id) { index, event in
                                Button(action: {
                                    router.selectedEvent = event
                                    router.navigationPath.append("EventDetails")
                                }) {
                                    PlannedEventCard(event: event)
                                }
                                .buttonStyle(GlassInteractiveButtonStyle(scaleAmount: 0.96))
                                .glassStagger(index: index + 1, delayOffset: 0.08)
                                .scrollTransition(.animated.threshold(.visible(0.15))) { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1.0 : 0.45)
                                        .scaleEffect(phase.isIdentity ? 1.0 : 0.94)
                                        .offset(y: phase.isIdentity ? 0 : 20)
                                }
                            }
                        } else if selectedTab == "Upcoming" {
                            ForEach(Array(MockData.upcomingEvents.enumerated()), id: \.element.id) { index, event in
                                Button(action: {
                                    router.selectedEvent = event
                                    router.navigationPath.append("EventDetails")
                                }) {
                                    PlannedEventCard(event: event)
                                }
                                .buttonStyle(GlassInteractiveButtonStyle(scaleAmount: 0.96))
                                .glassStagger(index: index, delayOffset: 0.08)
                                .scrollTransition(.animated.threshold(.visible(0.15))) { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1.0 : 0.45)
                                        .scaleEffect(phase.isIdentity ? 1.0 : 0.94)
                                        .offset(y: phase.isIdentity ? 0 : 20)
                                }
                            }
                        } else {
                            ForEach(Array(MockData.pastEvents.enumerated()), id: \.element.id) { index, event in
                                Button(action: {
                                    router.selectedEvent = event
                                    router.navigationPath.append("EventDetails")
                                }) {
                                    PastEventRow(event: event)
                                }
                                .buttonStyle(GlassInteractiveButtonStyle(scaleAmount: 0.96))
                                .glassStagger(index: index, delayOffset: 0.08)
                                .scrollTransition(.animated.threshold(.visible(0.15))) { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1.0 : 0.45)
                                        .scaleEffect(phase.isIdentity ? 1.0 : 0.94)
                                        .offset(y: phase.isIdentity ? 0 : 20)
                                }
                            }
                        }
                        Spacer().frame(height: 120)
                    }
                    .id(selectedTab)
                    .padding(.horizontal, 20)
                    .padding(.top, 6)
                }
            }

            // Stash Modal
            if isStashModalVisible {
                StashModalView(isPresented: $isStashModalVisible) { event in
                    router.selectedEvent = event
                    router.navigationPath.append("EventDetails")
                }
                .transition(.opacity.combined(with: .scale(scale: 0.95)))
            }

            // Personalize Modals Flow
            if isPersonalizeModalVisible {
                PersonalizeModalView(isPresented: $isPersonalizeModalVisible) { archetype in
                    isPersonalizeVibeModalVisible = true
                }
                .transition(.opacity.combined(with: .scale(scale: 0.95)))
            }

            if isPersonalizeVibeModalVisible {
                PersonalizeVibeModalView(isPresented: $isPersonalizeVibeModalVisible) { vibe in
                    isPersonalizeTimeModalVisible = true
                }
                .transition(.opacity.combined(with: .scale(scale: 0.95)))
            }

            if isPersonalizeTimeModalVisible {
                PersonalizeTimeModalView(isPresented: $isPersonalizeTimeModalVisible) { time in
                    // Finished personalization
                }
                .transition(.opacity.combined(with: .scale(scale: 0.95)))
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
        .glassShimmer(duration: 4.5, delay: 1.5)
    }
}

// MARK: - Past Event Row

private struct PastEventRow: View {
    @EnvironmentObject var router: AppRouter
    let event: EventItem

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Left: event cover photo with "Ended" badge
            ZStack(alignment: .topLeading) {
                Image(event.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 108, height: 118)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))

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
                HStack(spacing: 0) {
                    Button {
                        router.navigationPath.append("EventPhotos")
                    } label: {
                        Text("Photos")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color(hex: "AE4B30"))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .shadow(color: Color(hex: "AE4B30").opacity(0.3), radius: 4, y: 2)
                    }
                    .buttonStyle(GlassInteractiveButtonStyle(scaleAmount: 0.93))

                    Button {
                        router.navigationPath.append("EventSurvey")
                    } label: {
                        Text("Survey")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(.ultraThinMaterial.opacity(0.85))
                            )
                            .background(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(Color.white.opacity(0.16))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .strokeBorder(Color.white.opacity(0.18), lineWidth: 0.75)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .buttonStyle(GlassInteractiveButtonStyle(scaleAmount: 0.93))
                }
            .padding(.top, 12)
            .padding(.bottom, 12)
            }
            .padding(.trailing, 16)
            .frame(height: 140)
        }
        .padding(6)
        .glassCard(cornerRadius: 24)
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
