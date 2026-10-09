import Foundation

let path = "/Users/delwar/Desktop/active project/swift-project/tba-swift/TBASwift/Views/Payment/PaymentView.swift"
var content = try! String(contentsOfFile: path)

// Fix PaymentOption button close brace
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

// Fix HStack close brace
content = content.replacingOccurrences(of: """
            Spacer()
        .padding(16)
    }
}

struct PaymentView: View {
""", with: """
            Spacer()
        }
        .padding(16)
    }
}

struct PaymentView: View {
""")

// Remove the two trailing }
// We added two } at the end, let's just make sure there are exactly the right number.
// Since we removed GlassEffectContainer, the body should just be ZStack.
// Actually, let's just re-write the file correctly.
