import SwiftUI
import CoreData

public struct CalendarView: View {
    @StateObject var moodModelController: MoodModelController
    let startDate: Date
    let monthsToDisplay: Int
    var selectableDays = true

    init(startDate: Date, monthsToDisplay: Int, selectableDays: Bool = true, moodModelController: MoodModelController) {
        self.startDate = startDate
        self.monthsToDisplay = monthsToDisplay
        self.selectableDays = selectableDays
        _moodModelController = StateObject(wrappedValue: moodModelController)
    }

    struct WeekdaysView: View {
        let weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

        var body: some View {
            HStack(spacing: 8) {
                ForEach(weekdays, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 20)
        }
    }

    struct MonthView: View {
        @ObservedObject var moodModelController: MoodModelController
        var month: Month

        var body: some View {
            VStack {
                Text("\(month.monthNameYear)")
                GridStack(rows: month.monthRows, cols: 7) { row, col in
                    let index = row * 7 + col
                    if index < self.month.monthDays.count {
                        let day = self.month.monthDays[index]
                        return AnyView(DayCellView(moodModelController: self.moodModelController, day: day))
                    } else {
                        return AnyView(Text("").frame(width: 40, height: 40))
                    }
                }
            }
            .padding(.bottom, 20)
        }
    }

    public var body: some View {
        VStack {
            WeekdaysView()
            ScrollView {
                MonthView(moodModelController: moodModelController, month: Month(startDate: startDate, selectableDays: selectableDays, emojiByDate: moodModelController.emojiByDate))
                if monthsToDisplay > 1 {
                    ForEach(1..<self.monthsToDisplay) { index in
                        MonthView(moodModelController: self.moodModelController, month: Month(startDate: self.nextMonth(currentMonth: self.startDate, add: index), selectableDays: self.selectableDays, emojiByDate: self.moodModelController.emojiByDate))
                    }
                }
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle("Mood Calendar", displayMode: .inline)
        .background(Color("updatedCream").ignoresSafeArea())
    }

    func nextMonth(currentMonth: Date, add: Int) -> Date {
        var components = DateComponents()
        components.month = add
        return Calendar.current.date(byAdding: components, to: currentMonth)!
    }
}
struct DayCellView: View {
    @ObservedObject var moodModelController: MoodModelController
    @ObservedObject var day: Day

    init(moodModelController: MoodModelController, day: Day) {
        self.moodModelController = moodModelController
        self.day = day
    }

    var body: some View {
        VStack {
            if day.isPlaceholder {
                Text("").frame(width: 40, height: 40)
            } else {
                VStack {
                    Text(day.dayName)
                        .frame(width: 40, height: 40)
                        .clipped()
                    if let emoji = day.emoji {
                        Text(emoji)
                            .font(.largeTitle)
                    }
                }
            }
        }
        .padding(4)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onTapGesture {
            if !self.day.disabled && self.day.selectableDays {
                self.day.isSelected.toggle()
            }
        }
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let cols: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack(spacing: 8) { // Adjust row spacing here
            ForEach(0..<self.rows, id: \.self) { row in
                HStack(spacing: 8) { // Adjust column spacing here
                    ForEach(0..<self.cols, id: \.self) { col in
                        self.content(row, col)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
        }
    }
    
    init(rows: Int, cols: Int, content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.cols = cols
        self.content = content
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(startDate: Date(), monthsToDisplay: 2, moodModelController: MoodModelController())
    }
}
