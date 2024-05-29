//
//  EntriesView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/14/23.
//

import SwiftUI
import CoreData

struct JournalEntry: Identifiable {
    let id = UUID()
    var title: String
    var body: String
    var emoji: String
    var date: Date
    var image: Data?
    var imageData: Data?
    var mood: String
    
    init(title: String? = nil, body: String? = nil, emoji: String? = nil, date: Date = Date(), image: Data? = nil, imageData: Data? = nil, mood: String = "") {
        self.title = title ?? ""
        self.body = body ?? ""
        self.emoji = emoji ?? ""
        self.date = date
        self.image = image
        self.imageData = imageData
        self.mood = mood
    }
    static func < (lhs: JournalEntry, rhs: JournalEntry) -> Bool {
        return lhs.date < rhs.date
    }
}


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
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: JournalData.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \JournalData.date, ascending: false)
    ]) var entries: FetchedResults<JournalData>
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    @State private var showingNewEntryScreen = false
    @State private var selectedEntry: JournalData?
    
    @ObservedObject var moodModelController: MoodModelController
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("updatedCream").ignoresSafeArea()
                if entries.isEmpty {
                    NoEntriesView(showingNewEntryScreen: $showingNewEntryScreen)
                } else {
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
                    List {
                        ForEach(entries) { entry in
                            EntryRowView(entry: entry, dateFormatter: dateFormatter) {
                                selectedEntry = entry
                                showingDeleteAlert = true
                            }
                            .frame(maxHeight: 590)
                        }
                    }
                    .background(Color("updatedCream"))
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("My Entries")
            .navigationBarItems(trailing: Button(action: {
                showingNewEntryScreen.toggle()
            }) {
                Label("Add Entry", systemImage: "plus")
            })
            .sheet(isPresented: $showingNewEntryScreen) {
                NewJournalEntryView(moodModelController: moodModelController)
            }
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(
                title: Text("Delete Entry?"),
                message: Text("Are you sure?"),
                primaryButton: .destructive(Text("Delete")) {
                    if let entryToBeDeleted = selectedEntry {
                        deleteEntry(entryToBeDeleted)
                        selectedEntry = nil
                        showingDeleteAlert = false
                    }
                },
                secondaryButton: .cancel() {
                    selectedEntry = nil
                    showingDeleteAlert = false
                }
            )
        }
    }
    
    func deleteEntry(_ entry: JournalData) {
        print("Entry:\(entry)")
        moc.delete(entry)
        try? moc.save()
    }
}

struct NoEntriesView: View {
    @Binding var showingNewEntryScreen: Bool
    
    var body: some View {
        VStack {
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
        }
    }
}

struct EntryRowView: View {
    var entry: JournalData
    var dateFormatter: DateFormatter
    var deleteAction: () -> Void
    var day: Day
    
    init(entry: JournalData, dateFormatter: DateFormatter, deleteAction: @escaping () -> Void) {
        self.entry = entry
        self.dateFormatter = dateFormatter
        self.deleteAction = deleteAction
        self.day = Day(date: entry.date ?? Date()) // Pass entry.date to Day initializer
    }
    
    var body: some View {
        NavigationLink(destination: EntryDetailView(entry: entry, saveAction: {}).environment(\.managedObjectContext, DataController.shared.container.viewContext)) {
            
            HStack {
                Circle()
                    .foregroundColor(colorForMood(mood: entry.emoji ?? ""))
                    .frame(width: 30, height: 30)
                
                VStack(alignment: .leading) {
                    Text(entry.title ?? "")
                        .font(.title3)
                    Text(entry.body ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                    
                    Text(dateFormatter.string(from: entry.date ?? Date())) // Display entry's date directly
                        .foregroundColor(.secondary)
                }
                .listStyle(InsetGroupedListStyle())
                .scrollContentBackground(.hidden)
            }
            .swipeActions(edge: .trailing) {
                DeleteButtonView(deleteAction: deleteAction)
            }
        }
    }
}

struct DeleteButtonView: View {
    var deleteAction: () -> Void
    
    var body: some View {
        Button("Delete") {
            deleteAction()
        }
        .tint(.red)
    }
}

struct AddEntryButtonView: View {
    @Binding var showingNewEntryScreen: Bool
    
    var body: some View {
        Button {
            showingNewEntryScreen.toggle()
        } label: {
            Label("Add Entry", systemImage: "plus")
        }
    }
}

struct EntryListView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView(moodModelController: MoodModelController())
    }
}
