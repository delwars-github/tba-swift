import Foundation

public struct EventItem: Identifiable, Hashable {
    public let id: String
    public let title: String
    public let date: String
    public let time: String?
    public let location: String
    public let imageName: String
    public let joined: Int
    public let status: String?
    public let attending: String?
    public let price: String?

    public init(
        id: String,
        title: String,
        date: String,
        time: String? = nil,
        location: String = "New York",
        imageName: String,
        joined: Int = 20,
        status: String? = nil,
        attending: String? = nil,
        price: String? = nil
    ) {
        self.id = id
        self.title = title
        self.date = date
        self.time = time
        self.location = location
        self.imageName = imageName
        self.joined = joined
        self.status = status
        self.attending = attending
        self.price = price
    }
}

public struct BannerItem: Identifiable, Hashable {
    public let id: String
    public let title: String
    public let date: String
    public let imageName: String

    public init(id: String, title: String, date: String, imageName: String) {
        self.id = id
        self.title = title
        self.date = date
        self.imageName = imageName
    }
}

public enum MockData {
    public static let banners: [BannerItem] = [
        BannerItem(id: "1", title: "The Night Bright", date: "Sun, Dec 25, 7:30PM", imageName: "home-top"),
        BannerItem(id: "2", title: "Neon Party", date: "Fri, Dec 30, 9:00PM", imageName: "home-top"),
        BannerItem(id: "3", title: "New Year Bash", date: "Sat, Dec 31, 11:00PM", imageName: "home-top")
    ]

    public static let carouselEvents: [EventItem] = [
        EventItem(
            id: "1",
            title: "The Night Bright",
            date: "Sun, Dec 25, 7:30PM",
            time: "7:30 PM",
            location: "New York",
            imageName: "home-1",
            joined: 15
        ),
        EventItem(
            id: "2",
            title: "Neon Party",
            date: "Fri, Dec 30, 9:00PM",
            time: "9:00 PM",
            location: "Los Angeles",
            imageName: "home-2",
            joined: 42
        ),
        EventItem(
            id: "3",
            title: "Sunset Vibes",
            date: "Sat, Dec 31, 5:00PM",
            time: "5:00 PM",
            location: "Miami",
            imageName: "home-3",
            joined: 28
        )
    ]

    public static let pastEvents: [EventItem] = [
        EventItem(
            id: "p1",
            title: "Summer BBQ Cookout",
            date: "Sat, Jul 15, 2025",
            time: "5:00 PM",
            imageName: "home-2",
            status: "Ended"
        ),
        EventItem(
            id: "p2",
            title: "Board Game Night",
            date: "Sat, Jul 15, 2025",
            time: "5:00 PM",
            imageName: "home-2",
            status: "Ended"
        ),
        EventItem(
            id: "p3",
            title: "Weekend Hiking Trip",
            date: "Sat, Jul 15, 2025",
            time: "5:00 PM",
            imageName: "home-2",
            status: "Ended"
        ),
        EventItem(
            id: "p4",
            title: "Summer BBQ Cookout",
            date: "Sat, Jul 15, 2025",
            time: "5:00 PM",
            imageName: "home-2",
            status: "Ended"
        )
    ]

    public static let plannedEvents: [EventItem] = [
        EventItem(
            id: "pl1",
            title: "Rooftop Sunset Gathering",
            date: "Sat, Jul 15, 2025",
            time: "5:00 PM",
            location: "New York",
            imageName: "home-1",
            status: "Confirmed",
            attending: "24 Attending",
            price: "$1280"
        ),
        EventItem(
            id: "pl2",
            title: "Rooftop Sunset Gathering",
            date: "Sat, Jul 15, 2025",
            time: "5:00 PM",
            location: "New York",
            imageName: "home-2",
            status: "Confirmed",
            attending: "24 Attending",
            price: "$540"
        ),
        EventItem(
            id: "pl3",
            title: "Rooftop Sunset Gathering",
            date: "Sat, Jul 15, 2025",
            time: "5:00 PM",
            location: "New York",
            imageName: "home-3",
            status: "Confirmed",
            attending: "24 Attending",
            price: "$720"
        )
    ]

    public static let upcomingEvents: [EventItem] = [
        EventItem(
            id: "u1",
            title: "Secret Jazz Speakeasy",
            date: "Fri, Aug 18, 2025",
            time: "8:00 PM",
            location: "Brooklyn, NY",
            imageName: "home-3",
            status: "Upcoming",
            attending: "18 Attending",
            price: "$45"
        ),
        EventItem(
            id: "u2",
            title: "Tech Founders Rooftop",
            date: "Thu, Aug 24, 2025",
            time: "6:30 PM",
            location: "Manhattan, NY",
            imageName: "home-1",
            status: "Upcoming",
            attending: "35 Attending",
            price: "$60"
        )
    ]
}
