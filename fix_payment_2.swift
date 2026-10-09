import Foundation
let path = "/Users/delwar/Desktop/active project/swift-project/tba-swift/TBASwift/Views/Payment/PaymentView.swift"
var content = try! String(contentsOfFile: path)
content = content.replacingOccurrences(of: """
                    }
                )
        .buttonStyle(PlainButtonStyle())
""", with: """
                    }
                )
        }
        .buttonStyle(PlainButtonStyle())
""")
content = content.replacingOccurrences(of: """
            Spacer()
        .padding(16)
    }
}
""", with: """
            Spacer()
        }
        .padding(16)
    }
}
""")
try! content.write(toFile: path, atomically: true, encoding: .utf8)
