//
//  EntryDetailView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/21/23.
//

import SwiftUI

struct EntryDetailView: View {
//    @Binding var entries: [JournalEntry]
    @Binding var entry: JournalEntry
    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Entry Title", text: $entry.title)
                    .font(.largeTitle)
                TextField("Entry Descritpion", text: $entry.body)
                    .padding(10)
            }
        

        }
        .padding()
    }
}


struct EntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EntryDetailView(entry: .constant(JournalEntry(title: "this is a test", body: "This is also a test")))
    }
}
