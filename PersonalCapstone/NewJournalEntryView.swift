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
    @State private var currentMood = ""
    
    let moods = ["😊", "😠"]
    
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color("cream").ignoresSafeArea()
                // VStack {
                //                    Text("")
                //                        .navigationTitle("New Entry")
                //                        .navigationBarTitleDisplayMode(.inline)
                //                        .font(.title)
                
                
                Form {
                    Section {
                        TextField("Title", text: $entryTitle)
                            .lineLimit(2, reservesSpace: true)
                        
                        TextField("Write your entry here", text: $entryText, axis: .vertical)
                            .lineLimit(15, reservesSpace: true)
                            
                            }
                    Picker("How are you feeling?", selection: $currentMood) {
                        ForEach(moods, id: \.self) {
                            Text($0)
                        }
                    
                    }
                    Section {
                
                        Button("Save") {
                            let newEntry = JournalData(context: moc)
                            newEntry.id = UUID()
                            newEntry.title = entryTitle
                            newEntry.body = entryText
                            
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
