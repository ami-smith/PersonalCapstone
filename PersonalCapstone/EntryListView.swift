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
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        //SortDescriptor(from: \.date) *** I want it to be able to just sort the journal entries by date written
    ]) var entries: FetchedResults<JournalData>
    
    @State private var showingNewEntryScreen = false
    
    var body: some View {
        NavigationStack {
            ZStack {
//                Color("cream").ignoresSafeArea() ***** this is not working******
                List {
                    ForEach(entries) { entry in
                        NavigationLink {
                            // EntryDetailView(entry: entry)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(entry.title ?? "")
                                    .font(.headline)
                                Text(entry.body ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                            }
                        }
                    }
                    .onDelete(perform: deleteEntry)
                }
                
                .navigationTitle("My Entries")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                        
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingNewEntryScreen.toggle()
                        } label: {
                            Label("Add Entry", systemImage: "plus")
                        }
                    }
                    
                    
                }
                .sheet(isPresented: $showingNewEntryScreen) {
                    NewJournalEntryView()
                }
            }
        }
    }
    
    func deleteEntry(at offsets: IndexSet) {
        for offset in offsets {
            let entry = entries[offset]
            moc.delete(entry)
        }
        try? moc.save()
    }
}

struct EntryListView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView()
    }
}

