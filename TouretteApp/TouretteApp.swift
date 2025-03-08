import SwiftUI

@main
struct TouretteApp: App {
    @StateObject var colorBlindnessSettings = ColorBlindnessSettings()
    
    @State private var isInWelcome: Bool = UserDefaults.standard.bool(forKey: "isInWelcome")

    var body: some Scene {
        WindowGroup {
            if isInWelcome {
                WelcomeView()
                    .environmentObject(colorBlindnessSettings)
            } else {
                ContentView()
                    .environmentObject(colorBlindnessSettings)
            }
        }
    }
}
