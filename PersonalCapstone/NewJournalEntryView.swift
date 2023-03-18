//
//  NewJournalEntryView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/15/23.
//

import SwiftUI

struct NewJournalEntryView: View {
    
    
    @State private var entryText = ""
    @State private var entryTitle = ""
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color("cream").ignoresSafeArea()
                VStack {
                    Text("")
                        .navigationTitle("New Entry")
                        .navigationBarTitleDisplayMode(.inline)
                        .font(.title)
                    
                    TextField("Title", text: $entryTitle, axis: .vertical)
                        .lineLimit(2, reservesSpace: true)
                    
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    TextField("Write your entry here", text: $entryText, axis: .vertical)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .lineLimit(23, reservesSpace: true)
                        .padding()
                    Spacer()
                    
                    Button(action: {}, label: {
                        Text("Save Entry")
                        
                        
                        
                    })
                }
            }
        }
       
    }
}

struct NewJournalEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NewJournalEntryView()
    }
}
