import SwiftUI



struct ExerciseView: View {
    let nameBodyPart: String
    @State private var isSheetPresented = false
    @State private var selectedExercise1: Exercises?
    @State private var selectedExercise2: Exercises?
    @State private var navigateToNextView = false
    @Binding var navigationPath : [String]
    
    
    
    init(bodyPart: String, navigationPath : Binding<[String]>) {
        self.nameBodyPart = bodyPart
        self._navigationPath = navigationPath
    }
    
    var body: some View {
        
        let filteredExercises = exercises.filter { $0.bodyPart == nameBodyPart }
        
        
        
        ScrollView(.vertical) {
            VStack {
                Text("\(nameBodyPart)")
                    .padding()
                    .frame(width: 200, height: 50)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Choose an exercise: ")
                    .padding(.top, 20)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .frame(width: 250, height: 45, alignment: .center)
                    .font(.title3)
                
                if filteredExercises.isEmpty {
                    Text("No exercises for \(nameBodyPart)")
                } else {
                    LazyVStack(spacing: 20) {
                        ForEach(filteredExercises) { exercise in
                            ZStack {
                                
                                
                                Text(exercise.titleExercise)
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 340, height: 160)
                                    .background(
                                        Color.emerald
                                            .cornerRadius(8)
                                            .shadow(radius: 3)
                                    )
                                
                                
                                HStack {
                                    Button {
                                        selectedExercise2 = exercise
                                        
                                        navigationPath.append("meditation")
                                        
                                        navigateToNextView.toggle()
                                        
                                        
                                    } label: {
                                        Image("play")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                            .background(
                                                Rectangle()
                                                    .fill(Color.greenVariant)
                                                    .cornerRadius(8)
                                                    .frame(width: 100, height: 45, alignment: .center)
                                            )
                                            .foregroundColor(.white)
                                            .padding()
                                    }
                                    .offset(x: 130, y: -14)
                                    
                                    Spacer()
                                    
                                    Button {
                                        selectedExercise1 = exercise
                                        
                                    } label: {
                                        Image("info")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                        
                                            .foregroundColor(.white)
                                            .padding()
                                        
                                    }
                                    .offset(x: 25, y: -110)
                                }
                                .frame(width: 300)
                                .offset(y: 60)
                                
                            }
                        }
                    }
                    .padding(.top, 25)
                    .padding(.bottom, 40)
                }
            }
            
        }
        .scrollIndicators(.visible, axes: .vertical)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.sand)
        
        
        .sheet(item: $selectedExercise1) { exerciseDetails in
            DetailExerciseView(exerciseDetails: exerciseDetails)
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium, .fraction(0.7), .large])
        }
        
        .navigationDestination(isPresented: $navigateToNextView) {
            
            if let exerciseDetails = selectedExercise2 {
                
                MeditationTimer(exercise: exerciseDetails, navigationPath: $navigationPath)
            }
            
        }
    }
    
    
    
}


struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
