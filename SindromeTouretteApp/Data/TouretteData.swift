import Foundation

enum Exercise {
    case hrt
    case erp
}

class TouretteData: Identifiable {
    var id: UUID = UUID()
    var type : Exercise
    var date: String
    var hour: String
    var isManage, totalManaged: Int
    var duration: TimeInterval
    var bodyParts: String
    
    init(type: Exercise, duration: TimeInterval, bodyParts: String) {
        self.type = type
        self.date = DatePrettier.format()
        self.hour = HourPrettier.format()
        self.isManage = 0
        self.totalManaged = 0
        self.duration = duration
        self.bodyParts = bodyParts
    }
}
