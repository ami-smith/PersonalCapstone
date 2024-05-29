//
//  MainView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/11/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var moodModelController = MoodModelController()
    
    var body: some View {
        
        VStack {
            TabView {
                ContentView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                
                EntryListView(moodModelController: moodModelController)
                    .tabItem {
                        Image(systemName: "book")
                        Text("Entries")
                    }
                
                PromptsView(moodModelController: moodModelController)
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Prompts")
                    }
                
                CalendarView(startDate: Date(), monthsToDisplay: 12, moodModelController: MoodModelController())
                    .tabItem {
                        Image(systemName: "face.smiling")
                        Text("Mood Tracker")
                    }
            }
            .accentColor(Color("purpleHaze"))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        
    }
}

