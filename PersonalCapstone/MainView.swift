//
//  MainView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/11/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
                VStack {
                    TabView {
                        ContentView()
                            .tabItem {
                                Label("Home", systemImage: "house")
                            }
                        EntriesView()
                            .tabItem {
                                Label("My Entries", systemImage: "book")
                            }
                        
                        PromptsView()
                            .tabItem {
                                Label("Prompts", systemImage: "list.bullet.clipboard")
                            }
                        MoodTrackerView()
                            .tabItem {
                                Label("Mood Tracker", systemImage: "face.smiling")
                                
                        }
                    }
                
            }
        }
    }




struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        
    }
}
