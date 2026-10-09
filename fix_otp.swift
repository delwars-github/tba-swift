import Foundation

let path = "/Users/delwar/Desktop/active project/swift-project/tba-swift/TBASwift/Views/Auth/OtpView.swift"
var content = try String(contentsOfFile: path, encoding: .utf8)

let badText = """
                        Text("Enter the One Time\\nPassword sent to ")
                            .font(.custom("DMSerifDisplay-Regular", size: 32))
                            .foregroundColor(Color(hex: "#F9EBE0"))
                            .lineSpacing(6)
                        +
                        Text(phoneNumber)
                            .font(.custom("DMSerifDisplay-Regular", size: 18))
                            .foregroundColor(Color.white.opacity(0.5))
"""

let goodText = """
                        (Text("Enter the One Time\\nPassword sent to ")
                            .font(.custom("DMSerifDisplay-Regular", size: 32))
                            .foregroundColor(Color(hex: "#F9EBE0"))
                        +
                        Text(phoneNumber)
                            .font(.custom("DMSerifDisplay-Regular", size: 18))
                            .foregroundColor(Color.white.opacity(0.5)))
                            .lineSpacing(6)
"""

content = content.replacingOccurrences(of: badText, with: goodText)

try content.write(toFile: path, atomically: true, encoding: .utf8)
