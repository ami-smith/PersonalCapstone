//
//  ContentView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/9/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: Text("SecondView")) {
                Section {
                    Button("This takes you to the second view") {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }
                    
    
                    
                }
                    .navigationBarTitle("Welcome")
        }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
