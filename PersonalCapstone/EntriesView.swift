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

//                    NavigationStack {
//                        List {
//                            ForEach(entries.indices) { index in
//                                NavigationLink(destination: JournalEntryView(entry: $entries[index])) {
//                                    Text(entries[index])
//                                }
//                            }
//                            .navigationTitle("Entries")
//                        }
//                    }
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
                    .background(Color("cream").ignoresSafeArea())
                    .scrollContentBackground(.hidden)
                    .navigationBarTitle(Text("Journal Entries"))
               }
            }
        }
    }
    

//***this should be able to edit the view when the entry is clicked on and takes the user to an editable text field where they can edit their entry.
//    struct EditView: View {
//        @State private var entry = JournalEntry(title: title, body: body)
//        var body: some View {
//            VStack {
//                TextField("Enter Text here", text: $entries)
//                    .textFieldStyle(.roundedBorder)
//                Button("Save") {
//                    print("Save Button Pressed")
//                }
//            }
//            .navigationTitle("View and Edit")
//        }
//    }
    
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

