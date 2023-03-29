//
//  NewJournalEntryView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/15/23.
//

import SwiftUI

struct MoodChoice: View {
    let mood: String
    let color: Color
    
    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 30, height: 30)
            
            Text(mood)
        }
    }
}


struct NewJournalEntryView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var entryText = ""
    @State private var entryTitle = ""
    @State private var currentMood: String?
    
    let moods = [
        ("🤩", Color("fuchsia")),
        ("😊", Color("roseRed")),
        ("😐", Color("dustyRose")),
        ("😠", Color("lilac")),
        ("😢", Color("purpleHaze"))
    ]
    
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color("cream").ignoresSafeArea()
                
                Form {
                    Section {
                        TextField("Title", text: $entryTitle)
                            .lineLimit(2, reservesSpace: true)
                        
                        TextField("Write your entry here", text: $entryText, axis: .vertical)
                            .lineLimit(15, reservesSpace: true)
                        
                    }
                    Section {
                        Picker("How are you feeling?", selection: $currentMood) {
                            ForEach(moods, id: \.0) { mood, color in
                                MoodChoice(mood: mood, color: color)
                                    .tag(mood)
                            }
                        }
                    }
                    Section {
                        
                        Button("Save") {
                            let newEntry = JournalData(context: moc)
                            newEntry.id = UUID()
                            newEntry.title = entryTitle
                            newEntry.body = entryText
                            newEntry.mood = currentMood ?? ""
                            
                            try? moc.save()
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle("Add Entry")
            .scrollContentBackground(.hidden)
        }
    }
    
}


struct NewJournalEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NewJournalEntryView()
    }
}
