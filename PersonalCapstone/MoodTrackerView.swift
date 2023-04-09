//
//  MoodTrackerView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/14/23.
//

import SwiftUI

struct Emotion: Identifiable {
    @Binding var selectedMood: String
    let id = UUID()
    let value: String
//    let date: Date
}

struct EmotionKeyItem: Identifiable {
    let id = UUID()
    let color: Color
    let description: String
}
    
    
struct CircleGridView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()),
                   GridItem(.flexible())
    ]
    @Binding var selectedMood: String
    func colorForMood(mood: String) -> Color {
        switch mood {
        case "🤩":
            return Color("fuchsia")
        case "😊":
            return Color("roseRed")
        case "😐":
            return Color("dustyRose")
        case "😠":
            return Color("lilac")
        case "😢":
            return Color("purpleHaze")
        default:
            return Color("lightGray")
        }
    }

    
    var body: some View {
        Spacer()
        ScrollView(.horizontal) {
            Text("April")
                .font(.largeTitle)
            LazyHGrid(rows: columns, spacing: 17) {
                ForEach(1...30, id: \.self) { index in
                    ZStack {
                        Circle()
                            .fill(colorForMood(mood: selectedMood))
                            .frame(width: 45, height: 45)

                    }
                }
            }
            .frame(height:250)
            .padding(15)
        }
        Spacer()
        ZStack {
            Rectangle()
                .fill(Color("roseQuartz"))
                .frame(height: 200)
            VStack {
                HStack {
                    
                    Circle()
                        .fill(Color("fuchsia"))
                        .frame(width: 20, height: 20)
                    Text("Excited, Hopeful, Determined, Confident 🤩")
                    Spacer()
                    
                }
                HStack {
                    Circle()
                        .fill(Color("roseRed"))
                        .frame(width: 20, height: 20)
                    Text("Grateful, Happy, Joyful, Loving, Optimistic 😊")
                    Spacer()
                }
                HStack {
                    Circle()
                        .fill(Color("dustyRose"))
                        .frame(width: 20, height: 20)
                    Text("Pessimistic, Tired, Bored, Embarassed 😐")
                    Spacer()
                }
                HStack {
                    Circle()
                        .fill(Color("lilac"))
                        .frame(width: 20, height: 20)
                    Text("Annoyed, Angry, Resentful, Mad 😠")
                    Spacer()
                }
                HStack {
                    Circle()
                        .fill(Color("purpleHaze"))
                        .frame(width: 20, height: 20)
                    Text("Upset, Depressed, Frustrated, Unhappy 😢")
                    Spacer()
                }
            }
        }
    }
}
struct MoodTrackerView: View {
    @State var selectedMood: String

    var body: some View {
        ZStack {
            Color("updatedCream").ignoresSafeArea()
           VStack(spacing: 0) {
               CircleGridView(selectedMood: $selectedMood)
                
                Spacer()
//            CircleGridView()
//                    .frame(maxHeight: .infinity)

            }
        }
    }
}

struct MoodTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        MoodTrackerView(selectedMood: "🤩")
    }
}
