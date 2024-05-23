//
//  MoodTrackerView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/14/23.
//


//THIS IS THE OPTIONAL CODE FOR THE ENTRY DETAIL VIEW:
import SwiftUI
import CoreData

struct OptionalEntryDetailView: View {

    @ObservedObject var entry: JournalData

    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    TextField("Entry Title", text: $entry.title.toUnwrapped(defaultValue: ""))
                        .lineLimit(2)

                    TextField("Entry Body", text: $entry.body.toUnwrapped(defaultValue: ""))
                        .frame(height: 500)
//                        .font(.body)
//                        .padding()
                }
                .background(Color.white.opacity(0.7))
                .cornerRadius(10)
                .padding()
            }
        }
    }
}



//THIS IS THE CODE FOR THE MOOD TRACKER VIEW ->

//import SwiftUI
//
//struct Emotion: Identifiable {
//    @Binding var selectedMood: String
//    let id = UUID()
//    let value: String
//}
//
//struct EmotionKeyItem: Identifiable {
//    let id = UUID()
//    let color: Color
//    let description: String
//}
//
//
//struct CircleGridView: View {
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: [
//        //NSSortDescriptor(keyPath: \JournalData.date, ascending: false)
//    ]) var entries: FetchedResults<JournalData>
//
//    @Binding var selectedMood: String?
//    func colorForMood(mood: String) -> Color {
//        switch mood {
//        case "🤩":
//            return Color("fuchsia")
//        case "😊":
//            return Color("roseRed")
//        case "😐":
//            return Color("dustyRose")
//        case "😠":
//            return Color("lilac")
//        case "😢":
//            return Color("purpleHaze")
//        default:
//            return Color("lightGray")
//        }
//    }
//
//
//    var body: some View {
//        Spacer()
//        ScrollView(.horizontal) {
//            Text("April")
//                .font(.largeTitle)
//            VStack {
//                ForEach(entries) { entry in
//                    if let mood = entry.mood {
//                        Circle()
//                            .fill(colorForMood(mood: mood))
//                            .frame(width: 45, height: 45)
//                    }
//                }
//            }
//        }
//        Spacer()
//        ZStack {
//            Rectangle()
//                .fill(Color("roseQuartz"))
//                .frame(height: 200)
//            VStack {
//                HStack {
//
//                    Circle()
//                        .fill(Color("fuchsia"))
//                        .frame(width: 20, height: 20)
//                    Text("Excited, Hopeful, Determined, Confident")
//                    Spacer()
//
//                }
//                HStack {
//                    Circle()
//                        .fill(Color("roseRed"))
//                        .frame(width: 20, height: 20)
//                    Text("Grateful, Happy, Joyful, Loving, Optimistic")
//                    Spacer()
//                }
//                HStack {
//                    Circle()
//                        .fill(Color("dustyRose"))
//                        .frame(width: 20, height: 20)
//                    Text("Pessimistic, Tired, Bored, Embarassed")
//                    Spacer()
//                }
//                HStack {
//                    Circle()
//                        .fill(Color("lilac"))
//                        .frame(width: 20, height: 20)
//                    Text("Annoyed, Angry, Resentful, Mad")
//                    Spacer()
//                }
//                HStack {
//                    Circle()
//                        .fill(Color("purpleHaze"))
//                        .frame(width: 20, height: 20)
//                    Text("Upset, Depressed, Frustrated, Unhappy")
//                    Spacer()
//                }
//            }
//            .padding(5)
//        }
//    }
//}
//struct MoodTrackerView: View {
//    @State var selectedMood: String? = nil
//
//    var body: some View {
//        ZStack {
//            Color("updatedCream").ignoresSafeArea()
//           VStack(spacing: 0) {
//               CircleGridView(selectedMood: $selectedMood)
//
//                Spacer()
//            }
//        }
//    }
//}

//struct MoodTrackerView_Previews: PreviewProvider {
//    static var previews: some View {
//        OptionalEntryDetailView(entry: JournalData)
//    }
//}







//THIS IS THE OPTIONAL CODE FOR THE ENTRY DETAIL VIEW:
//import SwiftUI
//
//struct EntryDetailView: View {
//    
//    @ObservedObject var entry: JournalData
//    
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Image("background")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .edgesIgnoringSafeArea(.all)
//                
//                VStack {
//                    TextField("Entry Title", text: $entry.title.toUnwrapped(defaultValue: ""))
//                        .lineLimit(2)
//                    
//                    TextField("Entry Body", text: $entry.body.toUnwrapped(defaultValue: ""))
//                        .frame(height: 500)
////                        .font(.body)
////                        .padding()
//                }
//                .background(Color.white.opacity(0.7))
//                .cornerRadius(10)
//                .padding()
//            }
//        }
//    }
//}
