enum Tab: String, CaseIterable, Identifiable {
    case main
    case data
    case profile
    
    var id: String {
        rawValue
    }
    
    var icon: String {
        switch self {
        case .main:
            return "person"
        case .data:
            return "chart.pie"
        case .profile:
            return "gearshape"
        }
    }
    
    var title: String {
        switch self {
        case .main:
            return "Main"
        case .data: 
            return "Data"
        case .profile: 
            return "Settings"
        }
    }
}
