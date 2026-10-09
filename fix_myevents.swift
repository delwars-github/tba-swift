import Foundation

let path = "/Users/delwar/Desktop/active project/swift-project/tba-swift/TBASwift/Views/MyEvents/MyEventsView.swift"
var content = try String(contentsOfFile: path, encoding: .utf8)

// Add EnvironmentObject
content = content.replacingOccurrences(of: "struct MyEventsView: View {\n    @State private var selectedTab: String", with: "struct MyEventsView: View {\n    @EnvironmentObject var router: AppRouter\n    @State private var selectedTab: String")

// Wrap PlannedEventCard (Planned)
content = content.replacingOccurrences(of: "PlannedEventCard(event: event)\n                            }", with: """
Button(action: { router.navigationPath.append("EventDetails") }) {
                                    PlannedEventCard(event: event)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
""")

// Wrap PastEventRow
content = content.replacingOccurrences(of: "PastEventRow(event: event)\n                            }", with: """
Button(action: { router.navigationPath.append("EventDetails") }) {
                                    PastEventRow(event: event)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
""")

try content.write(toFile: path, atomically: true, encoding: .utf8)
