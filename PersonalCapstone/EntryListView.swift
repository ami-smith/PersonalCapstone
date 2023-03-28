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
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    @State private var showingNewEntryScreen = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(entries) { entry in
                        NavigationLink {
                            EntryDetailView(entry: entry)
                                .environment(\.managedObjectContext, DataController.shared.container.viewContext)
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
                        .swipeActions(edge: .trailing) {
                            Button("Delete") {
                                showingDeleteAlert = true
                            }
                            .tint(.red)
                        }
                        .alert("Delete Entry?", isPresented: $showingDeleteAlert) {
                            Button("Delete", role: .destructive) {
                                
//   I need a new function that takes an entry or index. Inside that function 
                            }
                            Button("Cancel", role: .cancel) {}
                        } message: {
                            Text("Are you sure?")
                        }
                    
                    }
//                    .onDelete(perform: deleteEntry)
                    
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
            .background(Color("cream"))
        }
    }
    
    func deleteEntry(at offsets: IndexSet) {
        showingDeleteAlert = true
        
                for index in offsets {
                    let entry = entries[index]
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

