import Foundation

struct ExerciseData : Identifiable, Hashable, Equatable {
    var id  : UUID = UUID()
    var bodyPart : String
    var exercise : String
    var titleExercise : String
    init(bodyPart: String, exercise: String, titleExercise: String) {
        self.bodyPart = bodyPart
        self.exercise = exercise
        self.titleExercise = titleExercise
    }
}
