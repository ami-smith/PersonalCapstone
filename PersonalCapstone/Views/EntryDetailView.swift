//
//  EntryDetailView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/21/23.
//

import SwiftUI
import CoreData

struct EntryDetailView: View {
    
    @ObservedObject var entry: JournalData
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage? = nil
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataController: DataController
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    var saveAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let entryDate = entry.date {
                Text(dateFormatter.string(from: entryDate))
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .padding(.bottom, 4)
            } else {
                Text("No Date Available")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .padding(.bottom, 4)
            }
            
            TextField("Entry Title", text: $entry.title.toUnwrapped(defaultValue: ""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.title)
            
            ScrollView {
                CustomTextEditor(text: $entry.body.toUnwrapped(defaultValue: ""), placeholder: "Enter your journal entry here...")
                    .frame(minHeight: 500, maxHeight: 500)
                    .font(.body)
            }
            
            if let imageData = entry.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 200)
            }
            
            Button(action: {
                showImagePicker = true
            }) {
                Text("Choose Photo")
            }
            Spacer()
        }
        .padding()
        .background(Color("cream"))
        .navigationTitle("Edit Entry")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    saveEntry()
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .onAppear {
            loadImage()
        }
        .onDisappear {
            saveEntry()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage)
        }
        .onChange(of: selectedImage) { newImage in
            if let newImage = newImage {
                entry.imageData = newImage.jpegData(compressionQuality: 1.0)
                saveEntry() 
            }
        }
    }
    
    func loadImage() {
        if let imageData = entry.imageData, let uiImage = UIImage(data: imageData) {
            selectedImage = uiImage
        }
    }
    
    func saveEntry() {
        do {
            try viewContext.save()
            saveAction()
        } catch {
            print("Failed to save entry: \(error.localizedDescription)")
        }
    }
}

extension Binding where Value == String? {
    func toUnwrapped(defaultValue: String) -> Binding<String> {
        return Binding<String>(
            get: { self.wrappedValue ?? defaultValue },
            set: { self.wrappedValue = $0 }
        )
    }
}

// Ensure CustomTextEditor is defined elsewhere in your project



//
//struct EntryDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryDetailView(entry: JournalData)
//    }
//}
