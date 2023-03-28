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
    
    let container = NSPersistentContainer(name: "JournalData")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}


extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
