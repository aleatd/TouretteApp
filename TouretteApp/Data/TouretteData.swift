import Foundation

class TouretteData: Identifiable {
    var id: UUID = UUID()
    var realDate: Date
    var date: String
    var hour: String
    var managedTics, notManagedTics: Int
    var duration: TimeInterval
    var exercise: Exercises
    
    
    init(date: Date, duration: TimeInterval, managedTics: Int, notManagedTics: Int, exercise: Exercises) {
        self.realDate = date
        self.date = ""
        self.hour = ""
        self.managedTics = managedTics
        self.notManagedTics = notManagedTics
        self.duration = duration
        self.exercise = Exercises(bodyPart: "", exercise: "", titleExercise: "")
    }
}
