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
                    Spacer()
                        .frame(height: 50)
                        .padding(.bottom, 20)
                    HStack {
                        Spacer()
                        Text("Let's get started!")
                        VStack {
                            Image("squiggle")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding(10)
                            Spacer()
                        }
                        .padding(.trailing,100)
                    }
                    //.padding(.top, 10)
                    HStack {
                        Spacer()
                        ZStack(alignment: .center) {
                            //Spacer()
                            Image("This is where your story blooms")
                                .padding(30)
                        }
                        .offset(y: -50)
                        Spacer()
                    }
                    .padding(7)
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
