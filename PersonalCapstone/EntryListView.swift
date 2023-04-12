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
    var date: Date
    
    init(title: String? = nil, body: String? = nil, emoji: String? = nil, date: Date = Date()) {
        self.title = title ?? ""
        self.body = body ?? ""
        self.emoji = emoji ?? ""
        self.date = date
    }
    static func < (lhs: JournalEntry, rhs: JournalEntry) -> Bool {
        return lhs.date < rhs.date
    }
}

//@Binding var selectedMood: String?
func colorForMood(mood: String) -> Color {
    switch mood {
    case "🤩":
        return Color("fuchsia")
    case "😊":
        return Color("roseRed")
    case "😐":
        return Color("dustyRose")
    case "😠":
        return Color("lilac")
    case "😢":
        return Color("purpleHaze")
    default:
        return Color("lightGray")
    }
}

struct EntryListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \JournalData.date, ascending: false)
    ]) var entries: FetchedResults<JournalData>
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    @State private var showingNewEntryScreen = false
    @State private var entryToBeDeleted: JournalData?

    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("updatedCream").ignoresSafeArea()
                if entries.isEmpty {
                    Text("No Entries Yet")
                        .font(.title)
                        .foregroundColor(.secondary)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    showingNewEntryScreen.toggle()
                                } label: {
                                    Label("Add Entry", systemImage: "plus")
                                    
                                }
                                .background(Color("updatedCream"))
                                .scrollContentBackground(.hidden)
                            }
                        }
                } else {
                    VStack(spacing: 0) {
                        List {
                            ForEach(entries) { entry in
                                NavigationLink {
                                    EntryDetailView(entry: entry)
                                        .environment(\.managedObjectContext, DataController.shared.container.viewContext)
                                } label: {
                                    HStack {
                                        Circle()
                                            .foregroundColor(colorForMood(mood: entry.emoji ?? ""))
                                            .frame(width: 30, height: 30)
                                    }
                                    VStack(alignment: .leading) {
                                        Text(entry.title ?? "")
                                            .font(.title3)
                                        Text(entry.body ?? "")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .lineLimit(1)
                                    }
                                    .swipeActions(edge: .trailing) {
                                        Button("Delete") {
                                            entryToBeDeleted = entry
                                            showingDeleteAlert = true
                                        }
                                        .tint(.red)
                                    }
                                    .listStyle(InsetGroupedListStyle())
                                    .scrollContentBackground(.hidden)
                                }
                            }
                            .frame(maxHeight: 590)
                        }
                        
                        .background(Color("updatedCream"))
                        .scrollContentBackground(.hidden)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    showingNewEntryScreen.toggle()
                                } label: {
                                    Label("Add Entry", systemImage: "plus")
                                    
                                }
                            }
                        }
                        .navigationTitle("My Entries")
                        
                        VStack {
                            ZStack {
                                Rectangle()
                                    .fill(Color("roseQuartz"))
                                    .frame(width: 400, height: 60)
                                VStack{
                                    HStack {
                                        VStack {
                                            Circle()
                                                .fill(Color("fuchsia"))
                                                .frame(width: 20, height: 20)
                                            Text("Great")
                                            
                                        }
                                        Spacer()
                                        VStack {
                                            Circle()
                                                .fill(Color("roseRed"))
                                                .frame(width: 20, height: 20)
                                            Text("Good")
                                            
                                        }
                                        Spacer()
                                        VStack {
                                            Circle()
                                                .fill(Color("dustyRose"))
                                                .frame(width: 20, height: 20)
                                            Text("Meh")
                                        }
                                        Spacer()
                                        VStack {
                                            Circle()
                                                .fill(Color("lilac"))
                                                .frame(width: 20, height: 20)
                                            Text("Mad")
                                        }
                                        Spacer()
                                        VStack {
                                            Circle()
                                                .fill(Color("purpleHaze"))
                                                .frame(width: 20, height: 20)
                                            Text("Sad")
                                        }
                                    }
                                }
                                .padding(30)
                                
                            }
                        }
                    }
                }
                
            }
            .sheet(isPresented: $showingNewEntryScreen) {
                NewJournalEntryView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingNewEntryScreen.toggle()
                } label: {
                    Label("Add Entry", systemImage: "plus")
                    
                }
                .background(Color("updatedCream"))
                .scrollContentBackground(.hidden)
            }
        }
        .alert("Delete Entry?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                if let entryToBeDeleted {
                    deleteEntry(entryToBeDeleted)
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure?")
        }
    }
    
    
    func deleteEntry(_ entry: JournalData) {
        print("Entry:\(entry)")
        moc.delete(entry)
        try? moc.save()
    }
}


struct EntryListView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView()
    }
}

