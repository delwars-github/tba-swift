import Foundation

let path = "/Users/delwar/Desktop/active project/swift-project/tba-swift/TBASwift/Views/Auth/LoginView.swift"
var content = try String(contentsOfFile: path, encoding: .utf8)

if let range = content.range(of: "// Helper for Hex Color\\nextension Color \\{[\\s\\S]*?\\n\\}\\n", options: .regularExpression) {
    content.removeSubrange(range)
    try content.write(toFile: path, atomically: true, encoding: .utf8)
}
