//
//  CurrentMoodView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/23/23.
//

import SwiftUI

struct CurrentMoodView: View {
    @Binding var mood: String
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CurrentMoodView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentMoodView(mood: .constant("😁"))
    }
}
