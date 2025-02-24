import SwiftUI

struct ContentView: View {
    @State private var selected = 0
    
    var body: some View {
        TabView(selection: $selected) {
            DataView()
                .tabItem {
                    Image(systemName: "text.page")
                    Text("Data")
                }.tag(1)
            
            MainView()
                .tabItem {
                    Image(systemName: "figure.wave")
                    Text("Main")
                }
                .tag(0)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }.tag(2)
        }
    }
}

