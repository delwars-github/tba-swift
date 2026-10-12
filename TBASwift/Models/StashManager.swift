import Foundation
import SwiftUI

public class StashManager: ObservableObject {
    public static let shared = StashManager()

    @Published public var stashEvents: [EventItem] = [
        EventItem(
            id: "stash-1",
            title: "Summer BBQ Cookout",
            date: "Sat, Jul 15, 2025",
            time: "5:00 PM",
            location: "Brooklyn, NY",
            imageName: "home-2",
            joined: 12,
            attending: "12 / 20"
        ),
        EventItem(
            id: "stash-2",
            title: "Board Game Night",
            date: "Sat, Jul 15, 2025",
            time: "5:00 PM",
            location: "Brooklyn, NY",
            imageName: "home-3",
            joined: 8,
            attending: "8 / 15"
        )
    ]

    public func addToStash(event: EventItem) {
        if !stashEvents.contains(where: { $0.id == event.id }) {
            stashEvents.insert(event, at: 0)
        }
    }

    public func removeFromStash(id: String) {
        stashEvents.removeAll(where: { $0.id == id })
    }

    public func isStashed(id: String) -> Bool {
        stashEvents.contains(where: { $0.id == id })
    }
}

