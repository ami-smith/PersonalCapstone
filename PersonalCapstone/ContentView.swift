//
//  ContentView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/9/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            
            Text("This is the main page")
                .navigationTitle("Welcome")
                .toolbar {
                    Button(action: {
                        
                    }) {
                        print("Entries Button Tapped")
                    } label: {
                        Image(systemName: "plus")
                    }

                        
                        
                    
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
