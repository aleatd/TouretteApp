import SwiftUI
import Combine

struct MeditationTimer: View {
    @State private var currentTextIndex = 0
    @State private var showText = true
    @State private var scale: CGFloat = 1.0
    @State private var timeRemaining = 0
    @State private var timerSubscription: Cancellable?
    @State private var hasStopped = false
    @State private var offsetY: CGFloat = 0
    @State private var meditationTextTimer: Timer?
    @State private var selectedBodyPart: String?
    
    let timer = Timer.publish(every: 1, on: .main, in: .common)
    let partName: String
    
    init(partName: String) {
        self.partName = partName
    }
    
    let meditationTexts: [String] = [
        NSLocalizedString("FirstMedText", comment: "Meditation Reinforcement Text"),
        NSLocalizedString("SecondMedText", comment: "Meditation Reinforcement Text"),
        NSLocalizedString("ThirdMedText", comment: "Meditation Reinforcement Text"),
        NSLocalizedString("FourthMedText", comment: "Meditation Reinforcement Text")
    ]
    
    
    private var currentMeditationText: String {
        if currentTextIndex == 0 {
            return meditationTexts[currentTextIndex] + (partName.lowercased())
        } else {
            return meditationTexts[currentTextIndex]
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if meditationTextTimer != nil {
                    Text(currentMeditationText)
                        .font(.largeTitle)
                        .offset(y: offsetY)
                        .opacity(showText ? 1 : 0)
                        .animation(.easeIn(duration: 1), value: offsetY)
                } else {
                    Text(NSLocalizedString("MeditationSuccess", comment: "Meditation Success Text"))
                        .font(.largeTitle)
                        .offset(y: 100)
                        .multilineTextAlignment(.center)
                        .scaleEffect(scale)
                        .onAppear {
                            scale = 1.0
                            withAnimation(
                                Animation.easeInOut(duration: 0.8)
                                    .repeatForever(autoreverses: true)
                            ) {
                                scale = 1.2
                            }
                        }
                }
                
                if !hasStopped {
                    Text(timeString(from: timeRemaining))
                        .font(.system(size: 100))
                        .padding()
                        .background(
                            Rectangle().fill(Color.greenVariant).cornerRadius(10)
                                .frame(width: 350, height: 150)
                        )
                        .foregroundColor(.white)
                        .padding(.top, 180)
                        .onAppear {
                            timeRemaining = 0
                            timerSubscription = timer.connect()
                            showComfortingTexts()
                        }
                        .onReceive(timer) { _ in
                            timeRemaining += 1
                        }
                } else {
                    VStack {
                        Text(NSLocalizedString("MeditationRating", comment: "Meditation Rating Text"))
                            .font(.largeTitle)
                            .frame(width: 350, height: 150)
                            .padding(.top, 180)
                    }
                }
                
                Spacer(minLength: geometry.size.height * 0.02)
                
                Button(hasStopped ? NSLocalizedString("MeditationContinue", comment: "Meditation Continuing Text") : "Stop") {
                    if !hasStopped {
                        timerSubscription?.cancel()
                        meditationTextTimer?.invalidate()
                        meditationTextTimer = nil
                        hasStopped = true
                    } else {
                        selectedBodyPart = partName
                    }
                }
                .frame(width: geometry.size.width * 0.8, height: 50)
                .background(Rectangle().fill(hasStopped ? .greenVariant : .red).cornerRadius(10))
                .font(.title)
                .foregroundColor(.white)
                .padding(.bottom, geometry.size.height * 0.08)
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .background(.sand)
        .navigationDestination(item: $selectedBodyPart) { bodyPart in
            ExerciseView(bodyPart: bodyPart)
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
