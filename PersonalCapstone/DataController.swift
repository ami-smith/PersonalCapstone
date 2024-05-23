//
//  DataController.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/22/23.
//


import CoreData
import Foundation
import SwiftUI

class DataController: ObservableObject {
    static let shared = DataController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "JournalData")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("An error has occurred while saving: \(error)")
            }
        }
    }
    
    func saveImage(image: UIImage) -> String? {
        guard let data = image.jpegData(compressionQuality: 1.0) else {
            print("Failed to convert UIImage to data")
            return nil
        }
        
        let filename = UUID().uuidString + ".jpg"
        let filePath = getDocumentsDirectory().appendingPathComponent(filename)
        
        do {
            try data.write(to: filePath)
            return filename
        } catch {
            print("Failed to save image data: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}

class MoodModelController: ObservableObject {
    
    @Published var moods: [JournalMood]
    
    init() {
        self.moods = []
        fetchMoods()
    }
    
    func fetchMoods() {
        let request: NSFetchRequest<JournalMood> = JournalMood.fetchRequest()
        
        do {
            self.moods = try DataController.shared.container.viewContext.fetch(request)
        } catch {
            print("Error fetching moods: \(error.localizedDescription)")
        }
    }
    
    func createMood(emotion: Emotion, comment: String?, date: Date) {
        let context = DataController.shared.container.viewContext
        let newMood = JournalMood(context: context)
        newMood.id = UUID()
        newMood.emotion = emotion.stringValue()
        newMood.date = date
        
        DataController.shared.saveContext()
        fetchMoods()
    }
    
    func deleteMood(at offsets: IndexSet) {
        let context = DataController.shared.container.viewContext
        offsets.forEach { index in
            let mood = moods[index]
            context.delete(mood)
        }
        
        DataController.shared.saveContext()
        fetchMoods()
    }
}

extension Binding {
    func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
