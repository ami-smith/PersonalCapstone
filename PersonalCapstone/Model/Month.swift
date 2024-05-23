import Foundation

struct Month {
    
    private let calendar = Calendar.current
    
    var startDate: Date
    var selectableDays: Bool
    var today = Date()
    var monthNameYear: String {
        self.monthHeader()
    }
    var monthDays: [Day]
    var monthRows: Int
    
    init(startDate: Date, selectableDays: Bool) {
        self.startDate = startDate
        self.selectableDays = selectableDays
        self.monthDays = Month.generateDaysArray(startDate: startDate, selectableDays: selectableDays, today: Date())
        self.monthRows = (self.monthDays.count + 6) / 7
    }
    
    private func monthHeader() -> String {
        let components = calendar.dateComponents([.year, .month], from: startDate)
        let currentMonth = calendar.date(from: components)!
        return currentMonth.dateToString(format: "LLLL yyyy")
    }
    
    private static func firstOfMonth(startDate: Date) -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: startDate)
        let firstOfMonth = Calendar.current.date(from: components)!
        return firstOfMonth
    }
    
    private static func lastOfMonth(startDate: Date) -> Date {
        var components = DateComponents()
        components.month = 1
        components.day = -1
        let lastOfMonth = Calendar.current.date(byAdding: components, to: firstOfMonth(startDate: startDate))!
        return lastOfMonth
    }
    
    private static func dateToWeekday(date: Date) -> Int {
        let components = Calendar.current.dateComponents([.weekday], from: date)
        guard let weekday = components.weekday else {
            fatalError("Cannot convert weekday to Int")
        }
        return weekday
    }
    
    private static func generateDaysArray(startDate: Date, selectableDays: Bool, today: Date) -> [Day] {
        var daysArray = [Day]()
        let fom = firstOfMonth(startDate: startDate)
        let lom = lastOfMonth(startDate: startDate)
        var currentDate = fom
        
        let startWeekday = dateToWeekday(date: fom)
        
        for _ in 1..<startWeekday {
            daysArray.append(Day(date: Date(timeIntervalSince1970: 0)))
        }
        
        while currentDate <= lom {
            let disabled = currentDate > today
            let currentDateInt = Int(currentDate.dateToString(format: "MMdyy"))!
            let todayDateInt = Int(today.dateToString(format: "MMdyy"))!
            let isToday = currentDateInt == todayDateInt
            daysArray.append(Day(date: currentDate, today: isToday, disable: disabled, selectable: selectableDays))
            
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        }
        let endWeekday = dateToWeekday(date: lom)
        for _ in endWeekday..<7 {
            daysArray.append(Day(date: Date(timeIntervalSince1970: 0)))
        }
        return daysArray
    }
}
