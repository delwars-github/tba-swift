import Foundation

let path = "/Users/delwar/Desktop/active project/swift-project/tba-swift/TBASwift/Views/Profile/ProfileView.swift"
var content = try String(contentsOfFile: path, encoding: .utf8)

let originalAchievements = """
                        Button(action: {}) {
                            HStack {
                                Text("Achievements")
"""
let newAchievements = """
                        Button(action: { router.navigationPath.append("Achievements") }) {
                            HStack {
                                Text("Achievements")
"""

content = content.replacingOccurrences(of: originalAchievements, with: newAchievements)
try content.write(toFile: path, atomically: true, encoding: .utf8)
