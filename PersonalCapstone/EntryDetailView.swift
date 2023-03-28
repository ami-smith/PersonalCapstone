//
//  EntryDetailView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/21/23.
//

import SwiftUI

struct EntryDetailView: View {
    
    @ObservedObject var entry: JournalData
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                TextField("Entry Title", text: $entry.title.toUnwrapped(defaultValue: ""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.title)
                    //.lineLimit(2, truncationMode: .tail)
                    .padding(.bottom, 8)
                
                ScrollView {
                    TextEditor(text: $entry.body.toUnwrapped(defaultValue: ""))
                        .frame(minHeight: 300, maxHeight: .infinity)
                        .foregroundColor(.primary)
                        .font(.body)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding()
                
                Spacer()
            }
            .padding()
        }
        .background(Color("cream"))
        .ignoresSafeArea()
    }
}



//
//struct EntryDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryDetailView(entry: .constant(JournalEntry(title: "this is a test", body: "This is also a test")))
//    }
//}
