import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .main
    
    var body: some View {
        ZStack {
            Color.sand
                .ignoresSafeArea()
            
            VStack {
                Group {
                    switch selectedTab {
                    case .main:
                        MainView()
                    case .data:
                        DataView()
                    case .profile:
                        SettingsView()
                    }
                }
            }
            
            BarView(selectedTab: $selectedTab)
        }
    }
}
