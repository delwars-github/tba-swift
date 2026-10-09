import SwiftUI
import PhotosUI

struct EventImageView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var uploadedImage: UIImage? = nil
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var location: String = ""
    
    @State private var selectedDate: Date? = nil
    @State private var selectedTime: Date? = nil
    @State private var showDatePicker = false
    @State private var showTimePicker = false
    
    @State private var equipmentFee: String = ""
    @State private var ticketFee: String = ""
    @State private var otherFee: String = ""
    
    let progress: CGFloat = 0.98
    
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
                        Text("Event Image")
                            .font(.custom("DMSerifDisplay-Regular", size: 32))
                            .foregroundColor(.white)
                            .padding(.top, 20)
                            .padding(.bottom, 8)
                        
                        // Equipment
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Equipment")
                                .font(.custom("DMSerifDisplay-Regular", size: 15))
                                .foregroundColor(.white)
                            
                            HStack(spacing: 12) {
                                PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                                    VStack(spacing: 8) {
                                        if let img = uploadedImage {
                                            Image(uiImage: img)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                .clipped()
                                        } else {
                                            Image(systemName: "square.and.arrow.up")
                                                .font(.system(size: 20))
                                                .foregroundColor(.white)
                                            Text("Upload")
                                                .font(.system(size: 11))
                                                .foregroundColor(.white)
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 84)
                                    .glassCard(cornerRadius: 12)
                                }
                                .onChange(of: selectedPhotoItem) { newItem in
                                    Task {
                                        if let data = try? await newItem?.loadTransferable(type: Data.self),
                                           let img = UIImage(data: data) {
                                            uploadedImage = img
                                        }
                                    }
                                }
                                
                                Button(action: {}) {
                                    VStack(spacing: 8) {
                                        Image(systemName: "star")
                                            .font(.system(size: 20))
                                            .foregroundColor(.white)
                                        Text("AI Generate")
                                            .font(.system(size: 11))
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 84)
                                    .glassCard(cornerRadius: 12)
                                }
                                
                                Button(action: {}) {
                                    VStack(spacing: 8) {
                                        Image(systemName: "photo")
                                            .font(.system(size: 20))
                                            .foregroundColor(.white)
                                        Text("Preset")
                                            .font(.system(size: 11))
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 84)
                                    .glassCard(cornerRadius: 12)
                                }
                            }
                        }
                        
                        // Event Title
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Event Title *")
                                .font(.custom("DMSerifDisplay-Regular", size: 15))
                                .foregroundColor(.white)
                            
                            TextField("Enter event title", text: $title)
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .frame(height: 48)
                                .glassCard(cornerRadius: 12)
                        }
                        
                        // Description
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Description *")
                                .font(.custom("DMSerifDisplay-Regular", size: 15))
                                .foregroundColor(.white)
                            
                            if #available(iOS 16.0, *) {
                                TextField("Describe your event...", text: $description, axis: .vertical)
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .lineLimit(4...8)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 14)
                                    .frame(minHeight: 120, alignment: .topLeading)
                                    .glassCard(cornerRadius: 12)
                            } else {
                                TextEditor(text: $description)
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .frame(height: 120)
                                    .scrollContentBackground(.hidden)
                                    .background(Color.clear)
                                    .glassCard(cornerRadius: 12)
                            }
                        }
                        
                        // When
                        VStack(alignment: .leading, spacing: 12) {
                            Text("When *")
                                .font(.custom("DMSerifDisplay-Regular", size: 15))
                                .foregroundColor(.white)
                            
                            VStack(spacing: 8) {
                                HStack {
                                    Image(systemName: "calendar")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                    
                                    Text(selectedDate == nil ? "Select Date" : selectedDate!.formatted(date: .abbreviated, time: .omitted))
                                        .font(.system(size: 14))
                                        .foregroundColor(selectedDate == nil ? Color.white.opacity(0.4) : Color(hex: "FFAC4F"))
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                }
                                .padding(.horizontal, 16)
                                .frame(height: 48)
                                .glassCard(cornerRadius: 12)
                                .overlay(
                                    DatePicker("", selection: Binding(get: { selectedDate ?? Date() }, set: { selectedDate = $0 }), displayedComponents: .date)
                                        .blendMode(.destinationOver) // visually hide but keep interactive
                                        .opacity(0.011)
                                )
                                
                                HStack {
                                    Image(systemName: "clock")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                    
                                    Text(selectedTime == nil ? "Select Time" : selectedTime!.formatted(date: .omitted, time: .shortened))
                                        .font(.system(size: 14))
                                        .foregroundColor(selectedTime == nil ? Color.white.opacity(0.4) : Color(hex: "FFAC4F"))
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                }
                                .padding(.horizontal, 16)
                                .frame(height: 48)
                                .glassCard(cornerRadius: 12)
                                .overlay(
                                    DatePicker("", selection: Binding(get: { selectedTime ?? Date() }, set: { selectedTime = $0 }), displayedComponents: .hourAndMinute)
                                        .blendMode(.destinationOver)
                                        .opacity(0.011)
                                )
                            }
                        }
                        
                        // Where
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Where *")
                                .font(.custom("DMSerifDisplay-Regular", size: 15))
                                .foregroundColor(.white)
                            
                            TextField("Enter location", text: $location)
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .frame(height: 48)
                                .glassCard(cornerRadius: 12)
                        }
                        
                        // Extra Fees (Optional)
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Extra Fees (Optional)")
                                .font(.custom("DMSerifDisplay-Regular", size: 15))
                                .foregroundColor(.white)
                            
                            VStack(alignment: .leading, spacing: 16) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Equipment")
                                        .font(.custom("DMSerifDisplay-Regular", size: 12))
                                        .foregroundColor(.white)
                                    
                                    TextField("$0.00", text: $equipmentFee)
                                        .keyboardType(.decimalPad)
                                        .font(.system(size: 14))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 16)
                                        .frame(height: 48)
                                        .glassCard(cornerRadius: 12)
                                }
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Ticket")
                                        .font(.custom("DMSerifDisplay-Regular", size: 12))
                                        .foregroundColor(.white)
                                    
                                    TextField("$0.00", text: $ticketFee)
                                        .keyboardType(.decimalPad)
                                        .font(.system(size: 14))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 16)
                                        .frame(height: 48)
                                        .glassCard(cornerRadius: 12)
                                }
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Other Costs")
                                        .font(.custom("DMSerifDisplay-Regular", size: 12))
                                        .foregroundColor(.white)
                                    
                                    TextField("$0.00", text: $otherFee)
                                        .keyboardType(.decimalPad)
                                        .font(.system(size: 14))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 16)
                                        .frame(height: 48)
                                        .glassCard(cornerRadius: 12)
                                }
                            }
                            .padding(16)
                            .glassCard(cornerRadius: 12)
                        }
                        
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
                    
                    NavigationLink(destination: ReviewSuccessView()) {
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

