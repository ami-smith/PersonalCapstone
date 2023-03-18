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
                            Image(systemName: "house")
                            Text("Home")
                        }
                    
                    EntriesView()
                        .tabItem {
                            Image(systemName: "book")
                            Text("Entries")
                        }
                    
                    PromptsView()
                        .tabItem {
                            Image(systemName: "list.bullet")
                            Text("Prompts")
                        }
                    
                    MoodTrackerView()
                        .tabItem {
                            Image(systemName: "face.smiling")
                            Text("Mood Tracker")
                            
                            
                        }
                }
            }
//            .navigationTitle("Welcome")
//            .navigationBarTitleDisplayMode(.large)
//            .navigationBarItems(trailing: Button(action: {
//                // Action for plus button
//            }) {
//                Image(systemName: "plus")
//            }
//            )
        }
//    }
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        
    }
}

