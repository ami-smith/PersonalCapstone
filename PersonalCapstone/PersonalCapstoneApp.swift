//
//  PersonalCapstoneApp.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/9/23.
//

import SwiftUI

@main
struct PersonalCapstoneApp: App {
//    @StateObject private var dataController = DataController()
    let dataController = DataController.shared
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
