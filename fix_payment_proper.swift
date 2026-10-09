import Foundation

let path = "/Users/delwar/Desktop/active project/swift-project/tba-swift/TBASwift/Views/Payment/PaymentView.swift"
var content = try String(contentsOfFile: path, encoding: .utf8)

// Remove the wrongly placed content
if let range = content.range(of: "    var content: some View \\{\\n        HStack\\(spacing: 16\\) \\{[\\s\\S]*?\\.padding\\(16\\)\\n    \\}", options: .regularExpression) {
    content.removeSubrange(range)
}

// Add content inside PaymentOption
let insertionTarget = "        .padding(.bottom, 12)\n    }\n"
let replacement = """
        .padding(.bottom, 12)
    }

    var content: some View {
        HStack(spacing: 16) {
            ZStack {
                Color(isSelected ? .white : .clear)
                if !isSelected {
                    Color.white.opacity(0.1)
                }
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? Color(hex: "#BA4127") : Color(hex: "#E6E2DB"))
            }
            .frame(width: 48, height: 48)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(isSelected ? 0 : 0.2), lineWidth: 1)
            )
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.custom("DMSerifDisplay-Regular", size: 16))
                    .foregroundColor(.white)
                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(Color.white.opacity(0.7))
            }
            
            Spacer()
        }
        .padding(16)
    }
"""

content = content.replacingOccurrences(of: insertionTarget, with: replacement)
try content.write(toFile: path, atomically: true, encoding: .utf8)
