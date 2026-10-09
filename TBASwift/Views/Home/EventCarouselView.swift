import SwiftUI

struct EventCarouselView: View {
    @EnvironmentObject var router: AppRouter
    let events: [EventItem]
    @State private var scrolledID: String? = "2"

    init(events: [EventItem] = MockData.carouselEvents) {
        self.events = events
    }

    var body: some View {
        GeometryReader { proxy in
            let screenWidth = proxy.size.width
            let itemWidth: CGFloat = screenWidth * 0.75
            let spacer: CGFloat = (screenWidth - itemWidth) / 2

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(events) { event in
                        Button(action: {
                            router.navigationPath.append("EventDetails")
                        }) {
                            EventCardView(event: event)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: itemWidth)
                        .scrollTransition(.interactive, axis: .horizontal) { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.85)
                                .offset(y: phase.isIdentity ? 0 : 20)
                                .opacity(phase.isIdentity ? 1.0 : 0.5)
                        }
                        .id(event.id)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .contentMargins(.horizontal, spacer, for: .scrollContent)
            .scrollPosition(id: $scrolledID, anchor: .center)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    scrolledID = "2"
                }
            }
        }
        .frame(height: 450)
    }
}
