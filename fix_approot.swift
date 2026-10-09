import Foundation

let path = "/Users/delwar/Desktop/active project/swift-project/tba-swift/TBASwift/App/AppRootView.swift"
var content = try String(contentsOfFile: path, encoding: .utf8)

let originalRouter = """
                case "EventDetails":
                    EventDetailsView()
                default:
"""
let newRouter = """
                case "EventDetails":
                    EventDetailsView()
                case "Achievements":
                    AchievementsView()
                default:
"""

content = content.replacingOccurrences(of: originalRouter, with: newRouter)
try content.write(toFile: path, atomically: true, encoding: .utf8)
