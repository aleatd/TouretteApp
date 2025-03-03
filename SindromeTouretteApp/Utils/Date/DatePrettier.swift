import Foundation
import Combine

struct DatePrettier {
    static func format() -> String {
        var date = NSDate()
        
        var formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.string(from: date as Date)
    }
}

struct HourPrettier {
    static func format() -> String {
        var date = NSDate()
        
        var formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return formatter.string(from: date as Date)
    }
}

