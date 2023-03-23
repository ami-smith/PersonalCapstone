//
//  EntryDetailView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/21/23.
//

import SwiftUI

struct EntryDetailView: View {
    
    @Binding var entry: JournalEntry
    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Entry Title", text: $entry.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.title)
                    .lineLimit(2, reservesSpace: true)
                TextField("Entry Description", text: $entry.body)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .lineLimit(15, reservesSpace: true)
                    .padding()
                Spacer()
            }
        

        }
        .padding()
    }
}

//
//struct EntryDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryDetailView(entry: .constant(JournalEntry(title: "this is a test", body: "This is also a test")))
//    }
//}
