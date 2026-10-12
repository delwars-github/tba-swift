import SwiftUI

struct AcceptModalView: View {
    @Binding var isPresented: Bool
    var onAccept: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.65)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isPresented = false
                    }
                }

            VStack(spacing: 0) {
                // Header image
                Image("group")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120)
                    .clipped()

                VStack(spacing: 24) {
                    Text("You can bring one of\nyour friends to this Gathering")
                        .font(.custom("DMSerifDisplay-Regular", size: 24))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                        .padding(.top, 24)

                    HStack(spacing: 12) {
                        Button {
                            withAnimation {
                                isPresented = false
                            }
                        } label: {
                            Text("No")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54)
                                .realGlass(cornerRadius: 27, strokeOpacity: 0.65, lineWidth: 1.2)
                        }

                        Button {
                            withAnimation {
                                isPresented = false
                                onAccept()
                            }
                        } label: {
                            Text("Yes")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54)
                                .background(Color(hex: "#FFB162"))
                                .cornerRadius(27)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 28)
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
            .background(
                LinearGradient(
                    colors: [Color(hex: "#A35139"), Color(hex: "#1F2A38")],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.4), radius: 20)
        }
    }
}

