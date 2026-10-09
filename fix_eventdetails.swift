import Foundation

let path = "/Users/delwar/Desktop/active project/swift-project/tba-swift/TBASwift/Views/Event/EventDetailsView.swift"
var content = try String(contentsOfFile: path, encoding: .utf8)

content = content.replacingOccurrences(of: "struct EventDetailsView: View {\n    @Environment", with: "struct EventDetailsView: View {\n    @EnvironmentObject var router: AppRouter\n    @Environment")

// "I'm In" button
let originalImIn = """
                    Button(action: {
                        // I'm In
                    }) {
                        Text(isFromInvite ? "I Will Go" : "I'm In")
"""
let newImIn = """
                    Button(action: {
                        router.navigationPath.append("Payment")
                    }) {
                        Text(isFromInvite ? "I Will Go" : "I'm In")
"""
content = content.replacingOccurrences(of: originalImIn, with: newImIn)

// Guests Button
let originalGuests = """
                        // People Joined
                        Text("\\(joined) People Joined")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.bottom, 6)
                        
                        // Face Pile (Mock images)
                        HStack(spacing: -12) {
                            Circle().fill(Color.gray).frame(width: 32, height: 32)
                            Circle().fill(Color.gray).frame(width: 40, height: 40)
                            Circle().fill(Color.gray).frame(width: 48, height: 48).zIndex(1)
                            Circle().fill(Color.gray).frame(width: 40, height: 40)
                            Circle().fill(Color.gray).frame(width: 32, height: 32)
                        }
                        .padding(.bottom, 16)
"""
let newGuests = """
                        // People Joined -> Navigate to GuestView
                        Button(action: { router.navigationPath.append("Guest") }) {
                            VStack(spacing: 0) {
                                Text("\\(joined) People Joined")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                                    .padding(.bottom, 6)
                                
                                HStack(spacing: -12) {
                                    Circle().fill(Color.gray).frame(width: 32, height: 32)
                                    Circle().fill(Color.gray).frame(width: 40, height: 40)
                                    Circle().fill(Color.gray).frame(width: 48, height: 48).zIndex(1)
                                    Circle().fill(Color.gray).frame(width: 40, height: 40)
                                    Circle().fill(Color.gray).frame(width: 32, height: 32)
                                }
                                .padding(.bottom, 16)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
"""
content = content.replacingOccurrences(of: originalGuests, with: newGuests)

try content.write(toFile: path, atomically: true, encoding: .utf8)
