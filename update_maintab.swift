import Foundation

let path = "/Users/delwar/Desktop/active project/swift-project/tba-swift/TBASwift/Views/MainTabView.swift"
var content = try String(contentsOfFile: path)

// Fix width and height
content = content.replacingOccurrences(of: ".padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 32))\n            .frame(height: 64)", with: ".padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 32))\n            .frame(width: 300, height: 64)")

try content.write(toFile: path, atomically: true, encoding: .utf8)
