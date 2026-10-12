import SwiftUI

struct EventChatView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var router: AppRouter
    var hostName: String = "Celiarn Mitchell"

    struct ChatMessage: Identifiable {
        let id = UUID()
        let text: String
        let time: String
        let isSender: Bool
    }

    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "Hey everyone! Looking forward to seeing you all at Friday Night Bright!", time: "7:12 PM", isSender: false),
        ChatMessage(text: "Can't wait! What's the exact dress code again?", time: "7:15 PM", isSender: true),
        ChatMessage(text: "Cocktail chic! Casual elegant is totally fine too. See you soon!", time: "7:18 PM", isSender: false)
    ]
    @State private var messageText: String = ""

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#FFB162"), Color(hex: "#A35139"), Color(hex: "#1A2534"), Color(hex: "#1A2534")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack(spacing: 12) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .realGlass(cornerRadius: 18, strokeOpacity: 0.65, lineWidth: 1.2)
                    }

                    Image("profile-pic")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 2) {
                        Text(hostName)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.white)
                        Text("Host")
                            .font(.system(size: 11))
                            .foregroundColor(Color.white.opacity(0.7))
                    }

                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 12)

                // Messages list
                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 14) {
                            ForEach(messages) { msg in
                                HStack {
                                    if msg.isSender {
                                        Spacer()
                                        VStack(alignment: .trailing, spacing: 4) {
                                            Text(msg.text)
                                                .font(.system(size: 14))
                                                .foregroundColor(Color(hex: "#1A2534"))
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 12)
                                                .background(Color(hex: "#FFAC4F"))
                                                .cornerRadius(18)

                                            Text(msg.time)
                                                .font(.system(size: 10))
                                                .foregroundColor(Color.white.opacity(0.6))
                                                .padding(.trailing, 4)
                                        }
                                        .frame(maxWidth: 280, alignment: .trailing)
                                    } else {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(msg.text)
                                                .font(.system(size: 14))
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 12)
                                                .realGlass(cornerRadius: 18, strokeOpacity: 0.65, lineWidth: 1.0)

                                            Text(msg.time)
                                                .font(.system(size: 10))
                                                .foregroundColor(Color.white.opacity(0.6))
                                                .padding(.leading, 4)
                                        }
                                        .frame(maxWidth: 280, alignment: .leading)
                                        Spacer()
                                    }
                                }
                                .id(msg.id)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                    }
                }

                // Input Bar
                HStack(spacing: 10) {
                    TextField("Type a message....", text: $messageText)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .realGlass(cornerRadius: 18, strokeOpacity: 0.65, lineWidth: 1.0)

                    Button(action: {
                        guard !messageText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                        messages.append(ChatMessage(text: messageText, time: "Just now", isSender: true))
                        messageText = ""
                    }) {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 16))
                            .foregroundColor(Color(hex: "#1A2534"))
                            .frame(width: 44, height: 44)
                            .background(Color(hex: "#FFAC4F"))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
            }
        }
        .navigationBarHidden(true)
    }
}

