//
//  EntriesView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/14/23.
//

import SwiftUI

struct JournalEntry: Identifiable {
    let id = UUID()
    var title: String
    var body: String
    
    init(title: String = "", body: String = "") {
        self.title = title
        self.body = body
    }
}

struct EntryListView: View {
    @State var entries: [JournalEntry] = [
        JournalEntry(title: "First Entry", body: "This is my first entry"),
        JournalEntry(title: "Second Entry", body: "This is my second entry"),
        JournalEntry(title: "Third Entry", body: "This is my third entry")
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                List($entries) { $entry in
                    NavigationLink {
                        EntryDetailView(entry: $entry)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(entry.title)
                                .font(.headline)
                            Text(entry.body)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .lineLimit(1)
                        }
                    }
                }
                Divider()
            }
        }
        .background(Color("cream").ignoresSafeArea())
        .scrollContentBackground(.hidden)
        .navigationBarTitle(Text("Journal Entries"))
    }
}






struct EntriesView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView()
    }
}

