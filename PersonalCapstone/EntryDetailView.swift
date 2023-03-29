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
        ZStack {
            NavigationView {
                VStack(alignment: .leading) {
                    TextField("Entry Title", text: $entry.title.toUnwrapped(defaultValue: ""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.title)
                        .padding(.bottom, 8)
                    
                    ScrollView {
                        TextEditor(text: $entry.body.toUnwrapped(defaultValue: ""))
                            .frame(minHeight: 500, maxHeight: 500)
                            .font(.body)
                    }
                    
                    Spacer()
                }
                
                .padding()
                .background(Color("cream"))
                //.ignoresSafeArea()
            }
        }
    }
}

//
//struct EntryDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryDetailView(entry: JournalData)
//    }
//}
