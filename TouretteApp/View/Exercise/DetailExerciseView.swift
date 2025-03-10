import SwiftUI

struct DetailExerciseView: View {
    let exercise : Exercises
    
    init(exerciseDetails: Exercises) {
        self.exercise = exerciseDetails
    }
    
    var body: some View {
        VStack{
            Text(exercise.titleExercise)
                .font(.largeTitle)
            
            Text(exercise.exercise)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.top, 15)
        }
        .padding(.top, 25)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("Sand"))
    }
}
