import Foundation

let path = "/Users/delwar/Desktop/active project/swift-project/tba-swift/TBASwift/Views/Profile/AchievementsView.swift"
var content = try String(contentsOfFile: path, encoding: .utf8)

let badText = "Text(\"\\\\(String(format: \\\"%02d\\\", p))/\\\\(String(format: \\\"%02d\\\", t))\")"
let goodText = "Text(String(format: \\\"%02d/%02d\\\", p, t))"

// Since there might be escaping issues from my last command, I'll just use regex.
if let range = content.range(of: "Text\\(.*%02d.*\\)", options: .regularExpression) {
    content.replaceSubrange(range, with: "Text(String(format: \\\"%02d/%02d\\\", p, t))")
}
try content.write(toFile: path, atomically: true, encoding: .utf8)
