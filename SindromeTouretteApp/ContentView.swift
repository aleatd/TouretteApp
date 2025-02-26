import SwiftUI

struct ContentView: View {
    @State private var selected = 0
    
    init() {
        let appeareance = UITabBarAppearance()
        appeareance.backgroundColor = .brown
        appeareance.shadowColor = .white
        
        appeareance.stackedLayoutAppearance.normal.iconColor = .white
        appeareance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        appeareance.stackedLayoutAppearance.selected.iconColor = .black
        appeareance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        UITabBar.appearance().standardAppearance = appeareance
        UITabBar.appearance().scrollEdgeAppearance = appeareance
    }
    
    var body: some View {
        
        TabView(selection: $selected) {
            DataView()
                .tabItem {
                    Image(systemName: "text.page")
                    Text("Data")
                }.tag(1)
            
            MainView()
                .tabItem {
                    Image(systemName: "figure")
                    Text("Main")
                }
                .tag(0)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }.tag(2)
        }
        .background(
            Rectangle().stroke(Color.black, lineWidth: 5)
        )
      
    }
}

