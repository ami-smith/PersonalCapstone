//
//  tester view.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/18/23.
//

import SwiftUI
struct tester_view: View {
    @State var items = ["Item 1", "Item 2", "Item 3"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items.indices) { index in
                    NavigationLink(destination: EditView(text: $items[index])) {
                        Text(items[index])
                    }
                }
            }
            .navigationTitle("Items")

        }
    }
    
    
}

struct EditView: View {
    @Binding var text: String
    
    var body: some View {
        VStack {
            TextField("Enter text here", text: $text)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button("Save") {
                // Save text
            }
            .padding()
            Spacer()
        }
        .navigationTitle("Edit Item")
    }
}


struct tester_view_Previews: PreviewProvider {
    static var previews: some View {
        tester_view()
    }
}
