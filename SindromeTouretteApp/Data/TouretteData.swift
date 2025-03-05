import Foundation

class TouretteData: Identifiable {
    var id: UUID = UUID()
    var realDate: Date
    var date: String
    var hour: String
    var managedTics, notManagedTics: Int
    var duration: TimeInterval
    var exercise: ExerciseData
    
    
    init(date: Date, duration: TimeInterval, managedTics: Int, notManagedTics: Int, exercise: ExerciseData) {
        self.realDate = date
        self.date = DatePrettier.format()
        self.hour = HourPrettier.format()
        self.managedTics = managedTics
        self.notManagedTics = notManagedTics
        self.duration = duration
        self.exercise = ExerciseData(bodyPart: "", exercise: "", titleExercise: "")
    }
}
