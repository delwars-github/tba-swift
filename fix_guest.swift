import Foundation

let path = "/Users/delwar/Desktop/active project/swift-project/tba-swift/TBASwift/Views/Guest/GuestView.swift"
var content = try String(contentsOfFile: path, encoding: .utf8)

let originalOverlay = """
                        .overlay(
                            Group {
                                if !isJoinActive {
                                    Color.clear
                                        .realGlass(cornerRadius: 20, strokeOpacity: 0.65, lineWidth: 1.2)
                                }
                            }
                        )
"""
let newOverlay = """
                        .background(
                            ZStack {
                                if !isJoinActive {
                                    Color.clear.realGlass(cornerRadius: 20, strokeOpacity: 0.65, lineWidth: 1.2)
                                }
                            }
                        )
"""
content = content.replacingOccurrences(of: originalOverlay, with: newOverlay)

try content.write(toFile: path, atomically: true, encoding: .utf8)
