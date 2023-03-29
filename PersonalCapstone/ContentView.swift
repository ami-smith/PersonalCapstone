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
                Color("cream").ignoresSafeArea()
                VStack {
                    HStack {
                        ZStack {
                            Spacer()
                            Rectangle()
                                .fill(Color( "dustyRose"))
                                .frame(width: 200, height: 200)
                            Text("This is a placeholder where the quote is gonna go")
                                .frame(width: 183, height: 183)
                                .foregroundColor(.white)
                                .padding(7)
                        }
                    }
                    .padding(7)
                }
                .navigationTitle("Welcome")
                .navigationBarTitleDisplayMode(.large)
                .navigationBarItems(trailing: Button(action: {
                    isShowingNewEntry = true
                }) {
                    Image(systemName: "plus")
                    
                }
                )
            }
                
            .sheet(isPresented: $isShowingNewEntry) {
                NewJournalEntryView()            }
        }
    }
}
//struct WeekView: View {
//    let calendar = Calendar.current
//
//    var body: some View {
//        HStack {
//            ForEach(0..<7) { index in
//                let date = calendar.date(byAdding: .day, value: index, to: Date())!
//                let formatter = DateFormatter()
//                formatter.dateFormat = "EEE"
//                let day = formatter.string(from: date)
//                Text(day)
//            }
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
