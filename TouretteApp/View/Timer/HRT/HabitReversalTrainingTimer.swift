import Combine
import SwiftUI

struct HabitReversalTrainingTimer: View {
    @State private var timerSubscription: Cancellable?
    @State var counter: Int = 0
    @State var countTo: Int = 0
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
    
    var body: some View {
        VStack {
            VStack{
                ZStack{
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
                            Circle().trim(from:0, to: progress())
                                .stroke(
                                    style: StrokeStyle(
                                        lineWidth: 25,
                                        lineCap: .round,
                                        lineJoin:.round
                                    )
                                )
                                .foregroundColor(
                                    (completed() ? Color.orange : Color.emerald)
                                )
                                .rotationEffect(.degrees(-90))
                        )
                    
                    Clock(counter: counter, countTo: countTo)
                }
            }.onReceive(timer) { time in
                if (self.counter < self.countTo) {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        self.counter += 1
                    }
                }
            }
            .onAppear() {
                countTo = 10
                timerSubscription = timer.connect()
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.sand)
        .edgesIgnoringSafeArea(.all)
    }
    
    func completed() -> Bool {
        return progress() == 1
    }
    
    func progress() -> CGFloat {
        return (CGFloat(counter) / CGFloat(countTo))
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
        let minutes = Int(currentTime / 60)
        
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}


