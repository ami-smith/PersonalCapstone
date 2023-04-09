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
    var emoji: String
    
    init(title: String? = nil, body: String? = nil, emoji: String? = nil) {
        self.title = title ?? ""
            self.body = body ?? ""
            self.emoji = emoji ?? ""
        }
    }

struct EntryListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        //NSSortDescriptor(keyPath: \JournalData.date, ascending: false)
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
                                HStack {
                                    Text(entry.title ?? "")
                                        .font(.title3)
                                    Spacer()
                                    Text(entry.emoji ?? "")
                                }
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
                                deleteEntry(entry)
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
            .background(Color("updatedCream"))
            .scrollContentBackground(.hidden)
        }
    }
    
    func deleteEntry(_ entry: JournalData) {
        //showingDeleteAlert = true
            moc.delete(entry)
        try? moc.save()
        }
    }


struct EntryListView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView()
    }
}

