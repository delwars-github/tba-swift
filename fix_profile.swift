import Foundation

let path = "/Users/delwar/Desktop/active project/swift-project/tba-swift/TBASwift/Views/Profile/ProfileView.swift"
var content = try! String(contentsOfFile: path)

// We want to replace the Earn VStack with the user's specific Figma view.
// Wait, the easiest is to do sed or replace_file_content.
