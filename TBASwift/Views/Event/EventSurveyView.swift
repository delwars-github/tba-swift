import SwiftUI

struct EventSurveyView: View {
    @Environment(\.presentationMode) var presentationMode
    var eventTitle: String = "Summer BBQ Cookout"

    @State private var rating: Int = 0
    @State private var feedback: String = ""

    var isFormValid: Bool {
        rating > 0
    }

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
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .realGlass(cornerRadius: 18, strokeOpacity: 0.65, lineWidth: 1.2)
                    }

                    Spacer()

                    Text("Survey")
                        .font(.custom("DMSerifDisplay-Regular", size: 20))
                        .foregroundColor(.white)

                    Spacer()

                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 16)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        VStack(spacing: 4) {
                            Text(eventTitle)
                                .font(.custom("DMSerifDisplay-Regular", size: 22))
                                .foregroundColor(.white)
                            Text("How was your experience?")
                                .font(.system(size: 14))
                                .foregroundColor(Color.white.opacity(0.8))
                        }
                        .padding(.top, 8)

                        // Rating Card
                        VStack(spacing: 16) {
                            Text("Rate this event")
                                .font(.custom("DMSerifDisplay-Regular", size: 16))
                                .foregroundColor(.white)

                            HStack(spacing: 12) {
                                ForEach(1...5, id: \.self) { star in
                                    Button(action: {
                                        rating = star
                                    }) {
                                        Image(systemName: star <= rating ? "star.fill" : "star")
                                            .font(.system(size: 30))
                                            .foregroundColor(star <= rating ? Color(hex: "#FFAC4F") : Color.white.opacity(0.8))
                                    }
                                }
                            }
                        }
                        .padding(24)
                        .frame(maxWidth: .infinity)
                        .realGlass(cornerRadius: 18, strokeOpacity: 0.65, lineWidth: 1.2)

                        // Feedback Input
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Share your thoughts (optional)")
                                .font(.custom("DMSerifDisplay-Regular", size: 16))
                                .foregroundColor(.white)

                            ZStack(alignment: .topLeading) {
                                if feedback.isEmpty {
                                    Text("What did you enjoy? Any suggestions?")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.white.opacity(0.6))
                                        .padding(16)
                                }
                                TextEditor(text: $feedback)
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .scrollContentBackground(.hidden)
                                    .padding(12)
                            }
                            .frame(height: 120)
                            .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.0)

                            Text("Your feedback helps hosts improve future events")
                                .font(.system(size: 12))
                                .foregroundColor(Color.white.opacity(0.6))
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 120)
                }

                Spacer()
            }

            // Submit Button
            VStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Submit\nFeedback")
                        .font(.custom("DMSerifDisplay-Italic", size: 13))
                        .foregroundColor(isFormValid ? Color(hex: "#1A2230") : .white)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .frame(width: 96, height: 96)
                        .background(isFormValid ? Color(hex: "#FFAC4F") : Color.clear)
                        .clipShape(Circle())
                        .realGlass(cornerRadius: 48, strokeOpacity: isFormValid ? 0.0 : 0.65, lineWidth: isFormValid ? 0.0 : 1.2)
                }
                .disabled(!isFormValid)
                .padding(.bottom, 24)
            }
        }
        .navigationBarHidden(true)
    }
}

