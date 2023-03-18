//
//  EntriesView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/14/23.
//

import SwiftUI

struct JournalEntry: Identifiable {
        let id = UUID()
        let title: String
        let body: String
    }

struct EntriesView: View {
    @State private var entries = [
        JournalEntry(title: "First Entry", body: "This is my first entry"),
        JournalEntry(title: "Second Entry", body: "This is my second entry"),
        JournalEntry(title: "Third Entry", body: "This is my third entry")
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("cream").ignoresSafeArea()
                VStack {
                    List(entries) { entry in
                        NavigationLink(destination: JournalEntryView(entry: entry)) {
                            VStack(alignment: .leading) {
                                Text(entry.title)
                                    .font(.headline)
                                Text(entry.body)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                    }
                    .navigationBarTitle(Text("Journal Entries"))
                }
            }
        }
    }
    
    struct JournalEntryView: View {
        let entry: JournalEntry
        
        var body: some View {
            NavigationView {
                Text(entry.title)
                    .font(.largeTitle)
                Text(entry.body)
                    .padding(10)
            }
            .padding()
        }
    }
    
    
    
    struct EntriesView_Previews: PreviewProvider {
        static var previews: some View {
            EntriesView()
        }
    }
}
