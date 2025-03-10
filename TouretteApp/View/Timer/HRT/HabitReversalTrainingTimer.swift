import Combine
import SwiftUI



struct HabitReversalTrainingTimer: View {
    
    // Variabili per il riconoscimento vocale
    var speechRecognizer = SpeechRecognizer()
    @State private var isSTTStarted: Bool = false
    
    @State private var scaleM: CGFloat = 1.0
    
    // Variabili per il timer
    @State private var timerSubscription: Cancellable?
    @State var counter: Int = 0
    @State private var isRunning: Bool = false
    @State var countTo: Int = 10
    let selectedExercise: Exercises
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Variabili per tracciare la gestione del tic
    @State private var ticManaged: Int = 0
    @State private var ticNotManaged: Int = 0
    
    // Variabili per la navigazione
    @Binding var navigationPath: [String]
    @Environment(\.dismiss) private var dismiss
    
    @State private var setTimer = true
    
    init(exercise: Exercises, navigationPath: Binding<[String]>) {
        self.selectedExercise = exercise
        self._navigationPath = navigationPath
    }
    
    var body: some View {
        VStack {
            Text(selectedExercise.titleExercise)
                .font(.title)
            
            Text(selectedExercise.exercise)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.top, 15)
                .frame(width: 350)
            
            VStack {
                ZStack {
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 250, height: 250)
                        .overlay(
                            Circle().stroke(Color.greenVariant, lineWidth: 25)
                        )
                    
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 250, height: 250)
                        .overlay(
                            Circle().trim(from: 0, to: progress())
                                .stroke(
                                    style: StrokeStyle(
                                        lineWidth: 25,
                                        lineCap: .round,
                                        lineJoin: .round
                                    )
                                )
                                .foregroundColor(completed() ? Color.orange : Color.emerald)
                                .rotationEffect(.degrees(-90))
                        )
                    
                    Clock(counter: counter, countTo: countTo)
                }
            }
            .padding(.top, 40)
            .onReceive(timer) { _ in
                if isRunning {
                    if counter < countTo {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            counter += 1
                        }
                        
                        
                        if isSTTStarted, !speechRecognizer.transcript.isEmpty {
                            let newTranscript = speechRecognizer.transcript.lowercased()
                            print("Utente ha detto: \(newTranscript)")
                            
                            
                            if newTranscript.lowercased().contains("si") {
                                ticManaged += 1
                                print("Tic gestito: \(ticManaged)")
                                
                            } else if newTranscript.lowercased().contains("no") {
                                ticNotManaged += 1
                                print("Tic non gestito: \(ticNotManaged)")
                                
                            }
                            speechRecognizer.reset()
                            speechRecognizer.transcribe()
                            
                        }
                        
                    } else {
                        isRunning = false
                        speechRecognizer.stopTranscribing()
                        
                    }
                }
            }
            
            if setTimer {
                VStack {
                    Text("Set Timer Duration")
                        .font(.headline)
                    
                    Stepper(value: $countTo, in: 1...100000, step: 10) {
                        Text("\(countTo) seconds")
                    }
                    .padding()
                }
                .padding(.top, 20)
                
                Button("Start") {
                    counter = 0
                    isRunning = true
                    setTimer = false
                    
                    if !isSTTStarted {
                        speechRecognizer.reset()
                        speechRecognizer.transcribe()
                        isSTTStarted = true
                    }
                    
                }
                .foregroundColor(.white)
                .background(
                    Rectangle()
                        .fill(.greenVariant)
                        .frame(width: 120, height: 50)
                        .cornerRadius(8)
                )
                .padding(.top, 20)
            }
            
            if counter >= countTo && !setTimer {
                Button("Go back to Exercises") {
                    navigationPath.removeAll { $0 == "meditation" || $0 == "habitreversaltraining" }
                }
                .foregroundColor(.white)
                .background(
                    Rectangle()
                        .fill(.greenVariant)
                        .cornerRadius(8)
                        .frame(width: 250, height: 50)
                )
                .padding(.top, 60)
                
                Text("Good Job!")
                    .font(.title)
                    .offset(y: 80)
                    .multilineTextAlignment(.center)
                    .scaleEffect(scaleM)
                    .onAppear {
                        withAnimation(
                            Animation.easeInOut(duration: 0.8)
                                .repeatForever(autoreverses: true)
                        ) {
                            scaleM = 1.2
                        }
                    }
                
                
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.sand)
        .navigationBarBackButtonHidden(true)
    }
    
    func completed() -> Bool {
        return progress() == 1
    }
    
    func progress() -> CGFloat {
        return CGFloat(counter) / CGFloat(countTo)
    }
}

struct Clock: View {
    var counter: Int
    var countTo: Int
    
    var body: some View {
        VStack {
            Text(counterToMinutes())
                .font(.system(size: 60))
                .fontWeight(.black)
        }
    }
    
    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let seconds = currentTime % 60
        let minutes = currentTime / 60
        
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}
