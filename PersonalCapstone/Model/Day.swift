import Foundation

// Date extension for the dateToString(format:) method
extension Date {
    func dateToString(format: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
    }
}


class Day: ObservableObject, Identifiable {
    
    @Published var isSelected = false
    
    var selectableDays: Bool
    var dayDate: Date?
    var dayName: String {
        dayDate?.dateToString(format: "d") ?? ""
    }
    var isToday = false
    var disabled = false
    
    var emoji: String?
    
    var monthString: String {
        guard let dayDate = dayDate else { return "" }
        let dateformatter1 = DateFormatter()
        dateformatter1.dateFormat = "DDD"
        return dateformatter1.string(from: dayDate)
    }
    
    var dayAsInt: Int {
        guard let dayDate = dayDate else { return 0 }
        let day = Calendar.current.component(.day, from: dayDate)
        return day
    }
    
    var year: String {
        guard let dayDate = dayDate else { return "" }
        return Calendar.current.component(.year, from: dayDate).description
    }
    
    init(date: Date?, today: Bool = false, disable: Bool = false, selectable: Bool = true, emoji: String? = nil) {
        self.dayDate = date
        self.isToday = today
        self.disabled = disable
        self.selectableDays = selectable
        self.emoji = emoji
    }
    
    init() {
        self.dayDate = nil
        self.isToday = false
        self.disabled = true
        self.selectableDays = false
    }
    
    var isPlaceholder: Bool {
        return dayDate == nil
    }
}
