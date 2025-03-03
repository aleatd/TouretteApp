import SwiftUI

struct Exercise : Identifiable{
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

let exercise: [Exercise] = [
    Exercise(bodyPart: "Head", exercise: "Tense your neck while lowering your shoulders.", titleExercise: "Neck Exercise"),
    Exercise(bodyPart: "Head", exercise: "Keep your neck tense in position, push your chin toward your chest, and breathe deeply.", titleExercise: "Tense Neck"),
    Exercise(bodyPart: "Head", exercise: "Maintain good posture (sit upright), look straight ahead, and pull your neck and head back.", titleExercise: "Correct Posture"),
    Exercise(bodyPart: "Eye", exercise: "Focus on a point in the room and blink your eyelids in a controlled manner.", titleExercise: "Eye Exercise"),
    Exercise(bodyPart: "Eye", exercise: "Contract your eyebrows and use controlled breathing.", titleExercise: "Eyebrow Contraction"),
    Exercise(bodyPart: "Nose", exercise: "Inhale and exhale through your mouth while tensing your nose and eyebrows.", titleExercise: "Nasal Breathing"),
    Exercise(bodyPart: "Nose", exercise: "Slightly pull your nose downward, keep your lips pressed together, and breathe deeply.", titleExercise: "Nose Tension"),
    Exercise(bodyPart: "Hand", exercise: "Place your hands on your legs, pressing if necessary.", titleExercise: "Hand Exercise"),
    Exercise(bodyPart: "Hand", exercise: "Clench your fists, bring your hands together, and press the palms against your hips or thighs.", titleExercise: "Tight Fists"),
    Exercise(bodyPart: "Hand", exercise: "Push your hand against an object, contracting the muscles opposite to the tic movement.", titleExercise: "Hand Push"),
    Exercise(bodyPart: "Hand", exercise: "Bring your hands together in front of your stomach and press.", titleExercise: "Hand Clasp"),
    Exercise(bodyPart: "Leg", exercise: "Press your heels against the floor.", titleExercise: "Leg Exercise"),
    Exercise(bodyPart: "Leg", exercise: "Press your knees tightly together.", titleExercise: "Tight Knees"),
    Exercise(bodyPart: "Leg", exercise: "Stand with your weight on your heels and your knees locked.", titleExercise: "Weight on Heels"),
    Exercise(bodyPart: "Mouth", exercise: "Clench your lips, bring your teeth together, and press your tongue against the roof of your mouth.", titleExercise: "Mouth Exercise"),
    Exercise(bodyPart: "Mouth", exercise: "Gently clench your jaw and press your lips together.", titleExercise: "Jaw Clenching"),
    Exercise(bodyPart: "Mouth", exercise: "Close your lips and gently press your teeth together.", titleExercise: "Lip Closure"),
    Exercise(bodyPart: "Arm", exercise: "Interlace your fingers, push your shoulders down, and push your arms against your sides.", titleExercise: "Interlaced Arms"),
    Exercise(bodyPart: "Shoulder", exercise: "Push your hands on your thighs and bring your elbows toward your hips.", titleExercise: "Thigh Push"),
    Exercise(bodyPart: "Shoulder", exercise: "Lower your shoulders and push your arms against your sides.", titleExercise: "Lowered Shoulders"),
    Exercise(bodyPart: "Foot", exercise: "Bend your knees, bring your feet closer to you, press the soles of your feet on the floor, and cross the other foot behind your ankle.", titleExercise: "Crossed Feet Position"),
    Exercise(bodyPart: "Foot", exercise: "Press the sole of your foot on the floor, spread your toes, and lift them upward.", titleExercise: "Toe Lift")
]


struct ExerciseView : View {
    let nameBodyPart: String
    
    init(bodyPart: String) {
        self.nameBodyPart = bodyPart
    }
    
    var body: some View {
        let filteredExercises = exercise.filter { $0.bodyPart == nameBodyPart }
        
        VStack {
            Text("\(nameBodyPart)")
                .font(.title)
            if filteredExercises.isEmpty {
                Text("No exercises for \(nameBodyPart)")
            } else {
                ForEach(filteredExercises) { exercise in
                    Button(exercise.titleExercise) {
                        
                    }
                    .padding()
                    .foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .frame(width: 240, height: 50)
                    .background(
                        Rectangle()
                            .stroke(Color.black, lineWidth: 3)
                            .shadow(radius: 5)
                    )
                    .cornerRadius(3)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.sand)
        
    }
}
