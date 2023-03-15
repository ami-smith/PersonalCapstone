//
//  testerView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/15/23.
//

import SwiftUI

struct JournalEntry: Identifiable {
    let id = UUID()
    let title: String
    let body: String
}

struct JournalView: View {
    @State private var entries = [
        JournalEntry(title: "First Entry", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
        JournalEntry(title: "Second Entry", body: "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
        JournalEntry(title: "Third Entry", body: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
    ]
    
    var body: some View {
        NavigationView {
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

struct JournalEntryView: View {
    let entry: JournalEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(entry.title)
                .font(.largeTitle)
            Text(entry.body)
                .padding(.top, 10)
        }
        .padding()
    }
}

struct testerView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
