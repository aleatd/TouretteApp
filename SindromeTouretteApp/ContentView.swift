import SwiftUI

let backgroundColor = Color.sand.opacity(0.95)

enum Tab: String, CaseIterable, Identifiable {
    case main
    case data
    case profile
    
    var id: String {
        rawValue
    }
    
    var icon: String {
        switch self {
        case .main: return "person"
        case .data: return "chart.pie"
        case .profile: return "gearshape"
        }
    }
    
    var title: String {
        switch self {
        case .main: return "Main"
        case .data: return "Data"
        case .profile: return "Settings"
        }
    }
}

struct ContentView: View {
    @State private var selectedTab: Tab = .main
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack {
                Group {
                    switch selectedTab {
                    case .main:
                        MainView()
                    case .data:
                        DataView()
                    case .profile:
                        ProfileView()
                    }
                }
            }
            
            BarView(selectedTab: $selectedTab)
        }
    }
}
