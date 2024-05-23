import Foundation

// Date extension for the dateToString(format:) method
extension Date {
    func dateToString(format: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
    }
}

// Day class definition
class Day: ObservableObject {
    
    @Published var isSelected = false
    
    var selectableDays: Bool
    var dayDate: Date
    var dayName: String {
        dayDate.dateToString(format: "d")
    }
    var isToday = false
    var disabled = false
    
    var monthString: String {
        let dateformatter1 = DateFormatter()
        dateformatter1.dateFormat = "DDD"
        return dateformatter1.string(from: dayDate)
    }
    
    var dayAsInt: Int {
        let day = Calendar.current.component(.day, from: dayDate)
        return day
    }
    
    var year: String {
        return Calendar.current.component(.year, from: dayDate).description
    }
    
    // Initializer for actual days
    init(date: Date, today: Bool = false, disable: Bool = false, selectable: Bool = true) {
        self.dayDate = date
        self.isToday = today
        self.disabled = disable
        self.selectableDays = selectable
    }
    
    // Initializer for empty days
    init() {
        self.dayDate = Date(timeIntervalSince1970: 0)
        self.isToday = false
        self.disabled = true
        self.selectableDays = false
    }
}
