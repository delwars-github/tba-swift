import SwiftUI

struct CustomSwitch: View {
    @Binding var isOn: Bool
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                isOn.toggle()
            }
        }) {
            ZStack(alignment: isOn ? .trailing : .leading) {
                Capsule()
                    .fill(isOn ? Color(hex: "FFAC4F") : Color.white.opacity(0.1))
                    .frame(width: 44, height: 24)
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 20, height: 20)
                    .padding(2)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct DropdownField: View {
    let label: String
    let options: [String]
    @Binding var selected: String?
    var placeholder: String = "Select"
    
    @State private var expanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(label)
                .font(.custom("DMSerifDisplay-Regular", size: 15))
                .foregroundColor(.white)
            
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                    expanded.toggle()
                }
            }) {
                HStack {
                    Text(selected ?? placeholder)
                        .font(.system(size: 14))
                        .foregroundColor(expanded ? Color(hex: "1A2230") : (selected != nil ? .white : Color.white.opacity(0.6)))
                    Spacer()
                    Image(systemName: expanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(expanded ? Color(hex: "1A2230") : Color.white.opacity(0.6))
                        .font(.system(size: 16))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(
                    Group {
                        if expanded {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(hex: "FFAC4F"))
                        } else {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.clear)
                                .glassCard(cornerRadius: 12)
                        }
                    }
                )
            }
            .buttonStyle(PlainButtonStyle())
            
            if expanded {
                VStack(spacing: 0) {
                    ForEach(Array(options.enumerated()), id: \.element) { index, option in
                        Button(action: {
                            withAnimation(.spring()) {
                                selected = option
                                expanded = false
                            }
                        }) {
                            HStack {
                                Text(option)
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                Spacer()
                                if selected == option {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color(hex: "FFAC4F"))
                                        .font(.system(size: 16))
                                }
                            }
                            .padding(.vertical, 14)
                            .padding(.horizontal, 16)
                            .background(Color.white.opacity(0.01))
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        if index < options.count - 1 {
                            Divider()
                                .background(Color.white.opacity(0.1))
                        }
                    }
                }
                .background(Color(hex: "1A2534").opacity(0.6))
                .glassCard(cornerRadius: 12)
                .padding(.top, -8)
            }
        }
    }
}

struct PillGroupField: View {
    let label: String?
    let options: [String]
    @Binding var selected: [String]
    var multiple: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let label = label {
                Text(label)
                    .font(.custom("DMSerifDisplay-Regular", size: 15))
                    .foregroundColor(.white)
            }
            
            let columns = [GridItem(.adaptive(minimum: 70), spacing: 8)]
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
                ForEach(options, id: \.self) { option in
                    let isSelected = selected.contains(option)
                    
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            if multiple {
                                if isSelected {
                                    selected.removeAll { $0 == option }
                                } else {
                                    selected.append(option)
                                }
                            } else {
                                selected = [option]
                            }
                        }
                    }) {
                        Text(option)
                            .font(.system(size: 13))
                            .foregroundColor(isSelected ? Color(hex: "1A2230") : .white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 14)
                            .background(
                                Group {
                                    if isSelected {
                                        Capsule()
                                            .fill(Color(hex: "FFAC4F"))
                                    } else {
                                        Capsule()
                                            .fill(Color.clear)
                                            .glassPill()
                                    }
                                }
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct PreferencesView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var capacity: String? = nil
    @State private var minRequired: String? = nil
    @State private var prepTime: String? = "30 minutes"
    @State private var waitlist: Bool = true
    @State private var gender: [String] = ["All"]
    @State private var ageRange: String? = "18-35"
    @State private var type: [String] = []
    
    @State private var customTag: String = ""
    @State private var selectedTags: [String] = []
    
    let progress: CGFloat = 0.75
    
    let capacityOptions = ["1-10", "10-20", "20-30", "30-40", "40-50", "50-60", "60-70", "70-80", "80-90", "90-100", "100+"]
    let minRequiredOptions = ["1-10", "10-20", "20-30", "30-40", "40-50", "50-60"]
    let prepTimeOptions = ["15 minutes", "30 minutes", "1 hour", "2 hours", "3 hours", "1 day"]
    let genderOptions = ["All", "Male", "Female"]
    let ageRangeOptions = ["18-25", "18-35", "25-45", "All"]
    let typeOptions = ["Social", "Professional", "Casual", "Formal", "Outdoor", "Indoor"]
    
    var body: some View {
        ZStack {
            Color(hex: "1A2534")
                .ignoresSafeArea()
            
            // Abstract Blur Backgrounds
            Image("blur1")
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea()
                .opacity(0.6)
            
            Image("blur2")
                .resizable()
                .scaledToFill()
                .frame(height: 550)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
                .opacity(0.6)
            
            VStack(spacing: 0) {
                // Header Row
                HStack(spacing: 12) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .glassCard(cornerRadius: 18)
                    }
                    .buttonStyle(GlassButtonStyle())
                    
                    // Progress Bar
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.clear)
                            .glassCard(cornerRadius: 14)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "215A8A"))
                            .frame(width: max(0, (UIScreen.main.bounds.width - 40 - 44 - 12) * progress))
                            .padding(4)
                    }
                    .frame(height: 24)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 10)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Title
                        Text("Preferences")
                            .font(.custom("DMSerifDisplay-Regular", size: 32))
                            .foregroundColor(.white)
                            .padding(.top, 20)
                            .padding(.bottom, 8)
                        
                        // Form Fields
                        DropdownField(label: "Maximum Capacity", options: capacityOptions, selected: $capacity)
                        
                        DropdownField(label: "Minimum required", options: minRequiredOptions, selected: $minRequired)
                        
                        DropdownField(label: "Prep Time", options: prepTimeOptions, selected: $prepTime)
                        
                        // Waitlist Toggle
                        HStack {
                            Text("Waitlist")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                            Spacer()
                            CustomSwitch(isOn: $waitlist)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .glassCard(cornerRadius: 12)
                        
                        // Group Card
                        VStack(alignment: .leading, spacing: 24) {
                            PillGroupField(label: "Gender", options: genderOptions, selected: $gender)
                            
                            DropdownField(label: "Age Range", options: ageRangeOptions, selected: $ageRange)
                            
                            PillGroupField(label: "Type", options: typeOptions, selected: $type, multiple: true)
                        }
                        .padding(16)
                        .glassCard(cornerRadius: 16)
                        
                        // Tags Card
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Tags")
                                .font(.custom("DMSerifDisplay-Regular", size: 15))
                                .foregroundColor(.white)
                            
                            HStack {
                                Text("Add up to 5 tags")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.white.opacity(0.4))
                                Spacer()
                            }
                            .padding(16)
                            .glassCard(cornerRadius: 12)
                        }
                        .padding(16)
                        .glassCard(cornerRadius: 16)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 180)
                }
            }
            
            // Bottom Gradient Overlay & Continue Button
            VStack {
                Spacer()
                ZStack(alignment: .bottom) {
                    LinearGradient(
                        stops: [
                            .init(color: Color(hex: "1A2534").opacity(0), location: 0.0),
                            .init(color: Color(hex: "1A2534").opacity(0.8), location: 0.5),
                            .init(color: Color(hex: "1A2534"), location: 1.0)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 120)
                    
                    Button(action: {
                        // Navigate to next screen
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color(hex: "FFAC4F"))
                            
                            Text("Continue")
                                .font(.custom("DMSerifDisplay-Italic", size: 14))
                                .foregroundColor(Color(hex: "1A2230"))
                        }
                        .frame(width: 84, height: 84)
                    }
                    .buttonStyle(GlassButtonStyle())
                    .padding(.bottom, 16)
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationBarHidden(true)
    }
}

