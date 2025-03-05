import SwiftUI

struct DetailExerciseView: View {
    let exercise : ExerciseData
    
    init(exerciseDetails: ExerciseData) {
        self.exercise = exerciseDetails
    }
    
    var body: some View {
        VStack{
            Text(exercise.titleExercise)
                .font(.headline)
            Text(exercise.exercise)
                .font(.body)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("Sand"))
        .navigationBarBackButtonHidden(false)
        
    }
}
