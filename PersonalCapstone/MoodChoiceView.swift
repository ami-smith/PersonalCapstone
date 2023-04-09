//
//  MoodChoiceView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 4/4/23.
//

import SwiftUI




struct MoodChoice: View {
    let mood: Mood
    let color: Color
   
    
    var body: some View {
        HStack {
            
            
                
                
        }
    }
}


struct MoodChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MoodChoice(mood: "🐰")
            MoodChoice(mood: "🐱")
        }
    }
}
