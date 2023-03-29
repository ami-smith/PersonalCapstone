//
//  MoodTrackerView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/14/23.
//

import SwiftUI

struct Emotion {
    let value: String
    let date: Date
}

let emotions: [Emotion] = [
    Emotion(value: "😢", date: Date().addingTimeInterval(-86400 * 7)), // 1 week ago
    Emotion(value: "😠", date: Date().addingTimeInterval(-86400 * 6)), // 6 days ago
    Emotion(value: "😐", date: Date().addingTimeInterval(-86400 * 5)), // 5 days ago
    Emotion(value: "😠", date: Date().addingTimeInterval(-86400 * 4)), // 4 days ago
    Emotion(value: "🤩", date: Date().addingTimeInterval(-86400 * 3)), // 3 days ago
    Emotion(value: "😊", date: Date().addingTimeInterval(-86400 * 2)), // 2 days ago
    Emotion(value: "😢", date: Date().addingTimeInterval(-86400)), // 1 day ago
    Emotion(value: "😠", date: Date()), // today
]


struct HeatMapChart: View {
    
    let emotions: [Emotion]
    var calendar = Calendar.current
    
    private func getDaysInMonth(date: Date) -> [Date] {
        
        var startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        
       // let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: startOfMonth))!
        
        if calendar.component(.weekday, from: startOfMonth) != 1 {
                startOfMonth = calendar.date(byAdding: .day, value: 1 - calendar.component(.weekday, from: startOfMonth), to: startOfMonth)!
            }
//        var components = DateComponents()
//        components.month = 1
//        components.day = -1
        
        var day = startOfMonth
        var daysInMonth: [Date] = []
        
        while !calendar.isDate(day, inSameDayAs: endOfMonth) {
            daysInMonth.append(day)
            day = calendar.date(byAdding: .day, value: 1, to: day)!
        }
        return daysInMonth
    }
    
    private func getColorForEmotion(_ emotion: String) -> Color {
        switch emotion {
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
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.flexible())], spacing: 5) {
                ForEach((0..<12), id: \.self) { monthIndex in
                    VStack {
                        Text(getMonthAndYear(for: monthIndex))
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                        
                        HStack {
                            ForEach(0..<7) { i in
                                Spacer()
                                Text(calendar.shortWeekdaySymbols[i])
                                    .frame(maxWidth: .infinity)
                                
                                Spacer()
                            }
                            Spacer()
                        }
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 15) {
                            ForEach(getDaysInMonth(date: calendar.date(byAdding: DateComponents(month: monthIndex, day: 1), to: Date())!), id: \.self) { day in
                                let emotion = emotions.first(where: { calendar.isDate($0.date, inSameDayAs: day) })
                                VStack {
                                    Circle()
                                        .fill(getColorForEmotion(emotion?.value ?? ""))
                                        .overlay(
                                            Text("\(calendar.component(.day, from: day))")
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                        )
                                }
                            }
                        }

                        .padding(10)
                    }
                    .frame(width: UIScreen.main.bounds.width - 30)
                }
            }
            .padding(.horizontal, 15)
        }
    }
    
    private func getMonthAndYear(for monthIndex: Int) -> String {
        let today = Date()
        var components = calendar.dateComponents([.year, .month], from: today)
        components.month = monthIndex + 1
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: calendar.date(from: components)!)
    }
}



//struct CalendarScrollView: View {
//    var body: some View {
//        ScrollView {
//            LazyVStack(spacing: 0) {
//                ForEach(1...12, id: \.self) { monthIndex in
//                    let date = Calendar.current.date(byAdding: .month, value: monthIndex - 1, to: Date())!
//                    CalendarView(date: date)
//                }
//            }
//            .padding()
//        }
//    }
//}
//
//struct CalendarView: View {
//    let date: Date
//
//    var body: some View {
//        let formattedMonthYear: String = {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MMMM yyyy"
//            return dateFormatter.string(from: date)
//        }()
//
//        VStack {
//            Text("\(formattedMonthYear)")
//                .font(.title)
//            LazyVGrid(columns:Array(repeating: GridItem(), count: 7), spacing: 10) {
//                ForEach(Date.daysInMonth(for: date), id: \.self) { day in
//                    Text("\(day.day)")
//                        .frame(width: 30, height: 30)
//                        .background(day.isToday ? Color.blue : Color.clear)
//                        .cornerRadius(15)
//                }
//            }
//        }
//        .frame(height: 320)
//    }
//}
//
//extension Date {
//    static func daysInMonth(for date: Date) -> [Date] {
//        let calendar = Calendar.current
//        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
//        let range = calendar.range(of: .day, in: .month, for: startDate)!
//        return (range.lowerBound..<range.upperBound)
//            .compactMap { calendar.date(byAdding: .day, value: $0, to: startDate) }
//    }
//
//    var day: Int { Calendar.current.component(.day, from: self) }
//    var isToday: Bool { Calendar.current.isDateInToday(self) }
//}



struct MoodTrackerView: View {
    let date = Date()
    
    var body: some View {
        ZStack {
            Color("cream").ignoresSafeArea()
            HeatMapChart(emotions: emotions)
        }
        
        
    }
}



struct MoodTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        MoodTrackerView()
    }
}
