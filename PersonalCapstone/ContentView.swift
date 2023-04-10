//
//  ContentView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingNewEntry = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("updatedCream").ignoresSafeArea()
                VStack {
                    Image("HeyThere")
                        .padding(.leading, 7)
                        .padding(.top, 20)
                        
                    Spacer()
                    HStack {
                        Spacer()
                        ZStack(alignment: .center) {
                            
                            Image("This is where your story blooms")
                        }
                        .offset(y: -75)
                        Spacer()
                    }
                    .padding(53)
                    Spacer()
                }
                
                .navigationBarTitleDisplayMode(.large)
                .navigationBarItems(trailing:
                                        HStack {
                    Spacer()
                    Button(action: {
                        isShowingNewEntry = true
                    }) {
                        Image(systemName: "plus")
                    }
                
                }
                )
            }
            
            .sheet(isPresented: $isShowingNewEntry) {
                NewJournalEntryView()            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
