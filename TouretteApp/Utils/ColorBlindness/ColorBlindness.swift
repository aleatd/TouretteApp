import SwiftUI

enum ColorBlindnessType: String, CaseIterable, Identifiable {
    case none = "None"
    case protanopia = "Protanopia"
    case deuteranopia = "Deuteranopia"
    case tritanopia = "Tritanopia"
    case monochromacy = "Monochromacy"
    
    var id: String { self.rawValue }
}

class ColorBlindnessSettings: ObservableObject {
    @Published var type: ColorBlindnessType = .none
}

struct SelectedColorBlindnessTypeKey: EnvironmentKey {
    static var defaultValue: ColorBlindnessSettings = ColorBlindnessSettings()
}

extension EnvironmentValues {
    var selectedColorBlindnessType: ColorBlindnessSettings {
        get {
            self[SelectedColorBlindnessTypeKey.self]
        }
        
        set {
            self[SelectedColorBlindnessTypeKey.self] = newValue
        }
    }
}
