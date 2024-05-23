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
            HStack(spacing: 0) {
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
                        return AnyView(Text("").frame(width: 32, height: 32))
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
                MonthView(moodModelController: moodModelController, month: Month(startDate: startDate, selectableDays: selectableDays))
                if monthsToDisplay > 1 {
                    ForEach(1..<self.monthsToDisplay) { index in
                        MonthView(moodModelController: self.moodModelController, month: Month(startDate: self.nextMonth(currentMonth: self.startDate, add: index), selectableDays: self.selectableDays))
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
    @State private var moods: [JournalMood] = []
    
    init(moodModelController: MoodModelController, day: Day) {
        self.moodModelController = moodModelController
        self.day = day
        _moods = State(initialValue: moodModelController.moods)
    }
    
    var body: some View {
        VStack {
            Text(day.dayName).frame(width: 32, height: 32)
                .clipped()
            moodText()
        }
        .clipShape(RoundedRectangle(cornerRadius: 10)).onTapGesture {
            if !self.day.disabled && self.day.selectableDays {
                self.day.isSelected.toggle()
            }
        }
    }
    
    func moodText() -> some View {
        if let matchingMood = moods.first(where: { $0.monthString == day.monthString && $0.dayAsInt == day.dayAsInt && $0.year == day.year }) {
            let imageName: String
            switch emotionState(rawValue: matchingMood.emotionState!) ?? .happy {
            case .happy: imageName = "happy"
            case .meh: imageName = "meh"
            case .sad: imageName = "sad"
            }
            return Image(imageName)
                .resizable()
                .frame(width: 20, height: 20)
                .opacity(1)
        } else {
            return Image("none")
                .resizable()
                .frame(width: 20, height: 20)
                .opacity(0)
        }
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let cols: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<self.rows, id: \.self) { row in
                HStack(spacing: 0) {
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
