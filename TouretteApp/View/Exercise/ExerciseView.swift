import SwiftUI

struct ExerciseView : View {
    let nameBodyPart: String
    @State private var selectedExercise: Exercises?
    
    init(bodyPart: String) {
        self.nameBodyPart = bodyPart
    }
    
    var body: some View {
        let filteredExercises = exercises.filter { $0.bodyPart == NSLocalizedString(nameBodyPart, comment: "Body part name") }
        
        VStack {
            Text("[" + NSLocalizedString(nameBodyPart, comment: "Body part name") + "]")
                .padding()
                .frame(width: 200, height: 50)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(NSLocalizedString("ChooseExercise", comment: "Prompt to choose exercise"))
                .padding(.top, 20)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .frame(width: 250, height: 45, alignment: .center)
                .font(.title3)
                
            if filteredExercises.isEmpty {
                Text(String(format: NSLocalizedString("NoExercisesFor", comment: "Message when no exercises are found"), nameBodyPart))
            } else {
                LazyVStack(spacing: 20) {
                    ForEach(filteredExercises) { exercise in
                        Button(action: {
                            withAnimation {
                                selectedExercise = exercise
                            }
                        }) {
                            Text(exercise.titleExercise)
                                .font(.title2)
                                .foregroundColor(.white)
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .frame(width: 240, height: 50)
                                .background(
                                    Color.greenVariant
                                        .cornerRadius(5)
                                        .shadow(radius : 3)
                                )
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
                .padding(.top, 25)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.sand)
        .navigationBarBackButtonHidden(false)
        
        .navigationDestination(item: $selectedExercise) { exercise in
            DetailExerciseView(exerciseDetails: exercise)
        }.accentColor(.greenVariant)
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
