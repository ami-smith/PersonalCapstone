//
//  NewJournalEntryView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/15/23.
//

import SwiftUI

struct NewJournalEntryView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var entryText = ""
    @State private var entryTitle = ""
    @State private var currentMood = "😊"
    
    let moods = [
        "🤩",
        "😊",
        "😐",
        "😠",
        "😢"
    ]
    
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color("updatedCream").ignoresSafeArea()
                
                Form {
                    Section {
                        TextField("Title", text: $entryTitle)
                            .lineLimit(2, reservesSpace: true)
                        
                        TextField("Write your entry here", text: $entryText, axis: .vertical)
                            .lineLimit(15, reservesSpace: true)
                        
                    }
                    Section {
                        VStack {
                            Text("How are you feeling?")
                            Picker("How are you feeling?", selection: $currentMood) {
                                ForEach(moods, id: \.self) { mood in
                                    Text(mood)
                                        .font(.largeTitle)
                                        .padding()
                                    
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                        }
                    }
                    Section {
                        
                        Button("Save") {
                            let newEntry = JournalData(context: moc)
                            newEntry.id = UUID()
                            newEntry.title = entryTitle
                            newEntry.body = entryText
                            newEntry.emoji = currentMood
                            
                            
                            try? moc.save()
                            dismiss()
                        }
                        .accentColor(Color("purpleHaze"))
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
