import Foundation

let path = "/Users/delwar/Desktop/active project/swift-project/tba-swift/TBASwift/Views/Home/EventCarouselView.swift"
var content = try String(contentsOfFile: path, encoding: .utf8)

// Add EnvironmentObject
content = content.replacingOccurrences(of: "struct EventCarouselView: View {\n    let events", with: "struct EventCarouselView: View {\n    @EnvironmentObject var router: AppRouter\n    let events")

// Add Button wrapping
let originalCard = """
                        EventCardView(event: event)
                            .frame(width: itemWidth)
                            .scrollTransition(.interactive, axis: .horizontal) { content, phase in
                                content
                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.85)
                                    .offset(y: phase.isIdentity ? 0 : 30)
                                    .rotationEffect(.degrees(phase.value * 5.0))
                                    .opacity(phase.isIdentity ? 1.0 : 0.5)
                            }
                            .id(event.id)
"""

let newCard = """
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
                                .offset(y: phase.isIdentity ? 0 : 30)
                                .rotationEffect(.degrees(phase.value * 5.0))
                                .opacity(phase.isIdentity ? 1.0 : 0.5)
                        }
                        .id(event.id)
"""

content = content.replacingOccurrences(of: originalCard, with: newCard)

try content.write(toFile: path, atomically: true, encoding: .utf8)
