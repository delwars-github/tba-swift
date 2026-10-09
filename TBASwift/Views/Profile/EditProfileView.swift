import SwiftUI

struct GlassInput: View {
    var label: String
    @Binding var text: String
    var multiline: Bool = false
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.custom("DMSerifDisplay-Regular", size: 14))
                .foregroundColor(.white)
                .tracking(0.5)
                .padding(.leading, 4)
            
            Group {
                if multiline {
                    TextEditor(text: $text)
                        .scrollContentBackground(.hidden) // for iOS 16+
                        .frame(minHeight: 90)
                } else {
                    TextField("", text: $text)
                        .keyboardType(keyboardType)
                }
            }
            .font(.system(size: 14))
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, multiline ? 8 : 12)
            .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)
        }
        .padding(.bottom, 16)
    }
}

struct PillTag: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 12))
            .foregroundColor(Color.white.opacity(0.8))
            .tracking(0.5)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .realGlass(cornerRadius: 14, strokeOpacity: 0.65, lineWidth: 1.2)
            .padding(.trailing, 8)
            .padding(.bottom, 12)
    }
}

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = "M. Yearo"
    @State private var age: String = "26"
    @State private var gender: String = "Male"
    @State private var city: String = "74C Aaliyah River ,Bayerhaven"
    @State private var bio: String = "Always looking for the next great conversation and spontaneous road trip. 🌿✨"
    
    // For simplicity, skip ImagePicker in pure UI translation for now
    
    let tags = ["#celebration", "#casual", "#networking", "#networking", "#dinner", "#casual", "#social"]

    var body: some View {
        ZStack {
            // Background Gradient
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
                    
                    Text("Edit Profile")
                        .font(.custom("DMSerifDisplay-Regular", size: 20))
                        .foregroundColor(.white)
                        .tracking(0.5)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 8)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Profile Image
                        ZStack(alignment: .bottomTrailing) {
                            Image("profile-pic") // Replace with actual default asset or loaded image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 110, height: 110)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white.opacity(0.9), lineWidth: 2))
                            
                            Button(action: {
                                // pick image action
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 36, height: 36)
                                    Image(systemName: "camera.fill")
                                        .font(.system(size: 18))
                                        .foregroundColor(Color(hex: "#142131"))
                                }
                            }
                        }
                        .padding(.top, 12)
                        .padding(.bottom, 32)
                        
                        // Form Fields
                        GlassInput(label: "Name", text: $name)
                        
                        HStack(spacing: 16) {
                            GlassInput(label: "Age", text: $age, keyboardType: .numberPad)
                            GlassInput(label: "Gender", text: $gender) // It was "Gander" in RN, kept it or corrected to Gender
                        }
                        
                        GlassInput(label: "City", text: $city)
                        
                        GlassInput(label: "Bio", text: $bio, multiline: true)
                        
                        // Tags Card
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Tags")
                                .font(.custom("DMSerifDisplay-Regular", size: 14))
                                .foregroundColor(.white)
                                .tracking(0.5)
                                .padding(.leading, 4)
                                .padding(.bottom, 20)
                            
                            // Wrapping tags
                            // Since SwiftUI doesn't have a native wrap view before iOS 16 FlowLayout, 
                            // we can use a simple LazyVGrid or custom layout. For now, simulating wrap with HStacks or FlowLayout wrapper.
                            // I'll write a simple flow layout approach or just use fixed HStacks for translation.
                            
                            // To keep it simple, let's use fixed rows or just standard SwiftUI 16+ Layout if possible. 
                            // Using a simple grid or let's use `WrapHStack` if available, otherwise just use HStacks.
                            VStack(alignment: .leading, spacing: 0) {
                                HStack(spacing: 0) {
                                    PillTag(title: "#celebration")
                                    PillTag(title: "#casual")
                                    PillTag(title: "#networking")
                                }
                                HStack(spacing: 0) {
                                    PillTag(title: "#networking")
                                    PillTag(title: "#dinner")
                                    PillTag(title: "#casual")
                                }
                                HStack(spacing: 0) {
                                    PillTag(title: "#social")
                                }
                            }
                        }
                        .padding(12)
                        .realGlass(cornerRadius: 16, strokeOpacity: 0.65, lineWidth: 1.2)
                        .padding(.bottom, 20)
                        
                        // Save Button
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Save")
                                // RN has "font-serif-italic". In iOS, DMSerifDisplay-Italic.
                                .font(.custom("DMSerifDisplay-Italic", size: 14))
                                .foregroundColor(Color(hex: "#142131"))
                                .tracking(0.5)
                                .frame(width: 84, height: 84)
                                .background(Color(hex: "#FFB162"))
                                .clipShape(Circle())
                        }
                        .padding(.top, 20)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}

