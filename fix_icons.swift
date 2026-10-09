import Foundation

// SettingsView
var path = "/Users/delwar/Desktop/active project/swift-project/tba-swift/TBASwift/Views/Settings/SettingsView.swift"
var content = try String(contentsOfFile: path, encoding: .utf8)
content = content.replacingOccurrences(of: "iconName: \"user-circle\"", with: "iconName: \"person.circle\"")
content = content.replacingOccurrences(of: "iconName: \"wallet\"", with: "iconName: \"creditcard\"")
content = content.replacingOccurrences(of: "iconName: \"link\"", with: "iconName: \"link\"")
content = content.replacingOccurrences(of: "iconName: \"security\"", with: "iconName: \"lock.shield\"")
content = content.replacingOccurrences(of: "iconName: \"policy\"", with: "iconName: \"doc.text\"")
content = content.replacingOccurrences(of: "iconName: \"delete\"", with: "iconName: \"trash\"")
content = content.replacingOccurrences(of: "Image(iconName)", with: "Image(systemName: iconName)")
content = content.replacingOccurrences(of: "Image(\"logout\")", with: "Image(systemName: \"rectangle.portrait.and.arrow.right\")")
try content.write(toFile: path, atomically: true, encoding: .utf8)

// EventDetailsView
path = "/Users/delwar/Desktop/active project/swift-project/tba-swift/TBASwift/Views/Event/EventDetailsView.swift"
content = try String(contentsOfFile: path, encoding: .utf8)
content = content.replacingOccurrences(of: "Image(\"share\") // replace with actual share icon or systemName", with: "Image(systemName: \"square.and.arrow.up\")")
content = content.replacingOccurrences(of: "Image(\"calendar-love\") // Mock icon", with: "Image(\"calendar-love-icon\")")
content = content.replacingOccurrences(of: "Image(\"location\") // Mock icon", with: "Image(systemName: \"mappin.and.ellipse\")")
content = content.replacingOccurrences(of: "Image(\"host\") // Mock host image", with: "Image(\"profile-pic\")")
try content.write(toFile: path, atomically: true, encoding: .utf8)

