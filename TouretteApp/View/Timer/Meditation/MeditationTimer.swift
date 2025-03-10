import SwiftUI
import Combine

struct MeditationTimer: View {
    
    // Comforting texts variables
    @State private var offsetY: CGFloat = 0
    @State private var meditationTextTimer: Timer?
    @State private var currentTextIndex = 0
    @State private var showText = true
    @State private var scaleM: CGFloat = 1.0
    let meditationTexts: [String] = ["Concentrate on your ", "Focus on your breath", "Stay present", "Think of your trigger"]
    
    private var currentMeditationText: String {
        if currentTextIndex == 0 {
            return meditationTexts[currentTextIndex] + (exercise.bodyPart.lowercased())
        } else {
            return meditationTexts[currentTextIndex]
        }
    }
    
    // Timer variables
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common)
    @State private var timerSubscription: Cancellable?
    @State private var timeRemaining = 0
    @State private var hasStopped = false
    
    // Navigation variable
    @Binding var navigationPath : [String]
    @State private var navigateToNextView: Bool = false
    
    // Countdown variables
    @State private var countdownNumber = 3
    @State private var showNextNumber: Bool = true
    
    // Selecting exercises variables
    @State private var selectedExercise: Exercises?
    let exercise: Exercises
    
    init(exercise: Exercises, navigationPath: Binding<[String]>) {
        self.exercise = exercise
        self._navigationPath = navigationPath
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                
                if countdownNumber > 0 {
                    Text("\(countdownNumber)")
                        .font(.system(size: 100))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .offset(y: 50)
                        .opacity(showNextNumber ? 1 : 0.5)
                        .animation(.easeInOut(duration: 0.8), value: showNextNumber)
                } else {
                    if !hasStopped {
                        Text(currentMeditationText)
                            .font(.title)
                            .offset(y: offsetY)
                            .opacity(showText ? 1 : 0)
                            .onAppear() {
                                startMeditationTimer()
                            }
                            .animation(.easeInOut(duration: 1), value: offsetY)
                        
                    } else {
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
                
                Spacer()
                
                
                if countdownNumber <= 0 {
                    Button(hasStopped ? "Go to the exercise" : "Stop") {
                        if !hasStopped {
                            timerSubscription?.cancel()
                            meditationTextTimer?.invalidate()
                            hasStopped = true
                        } else {
                            navigationPath.append("habitreversaltraining")
                            selectedExercise = exercise
                            navigateToNextView.toggle()
                        }
                    }
                    .frame(width: geometry.size.width * 0.9, height: 80)
                    .background(
                        Rectangle().fill(hasStopped ? .greenVariant : .red)
                            .cornerRadius(10)
                    )
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.bottom, geometry.size.height * 0.2)
                }
            }
            .offset(y: geometry.size.height * 0.1)
            .frame(width: geometry.size.width, height: geometry.size.height)
            
            
            VStack {
                Spacer().frame(height: geometry.size.height * 0.4)
                
                ZStack {
                    Text(timeString(from: timeRemaining))
                        .font(.system(size: 100))
                        .padding()
                        .background(
                            Rectangle().fill(Color.emerald).cornerRadius(10)
                                .frame(width: 350, height: 150)
                        )
                        .foregroundColor(.white)
                        .onReceive(timer) { _ in
                            timeRemaining += 1
                        }
                }
                
                .frame(width: geometry.size.width, height: 150)
            }
        }
        .onAppear() {
            showCountdownText()
        }
        .background(.sand)
        .navigationBarBackButtonHidden(!hasStopped)
        .navigationDestination(isPresented: $navigateToNextView) {
            HabitReversalTrainingTimer(exercise: exercise, navigationPath: $navigationPath)
        }
    }
    
    private func startMeditationTimer() {
        timeRemaining = 0
        timerSubscription = timer.connect()
        showComfortingTexts()
    }
    
    private func showCountdownText() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            withAnimation(.easeInOut(duration: 0.8)) {
                showNextNumber = false
                countdownNumber -= 1
                showNextNumber = true
            }
            
            if countdownNumber <= 0 {
                timer.invalidate()
            }
        }
    }
    
    private func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func showComfortingTexts() {
        meditationTextTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            
            withAnimation {
                showText = false
                currentTextIndex = (currentTextIndex + 1) % meditationTexts.count
                showText = true
                offsetY += 50
                if currentTextIndex == 0 {
                    offsetY = 0
                }
            }
            
        }
    }
}
