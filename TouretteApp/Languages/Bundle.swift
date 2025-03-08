import Foundation

extension Bundle {
    private static var currentBundle: Bundle = .main
    
    static func setLanguage(_ languageCode: String) {
        guard let languageBundlePath = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
              let languageBundle = Bundle(path: languageBundlePath) else {
            return
        }
        
        object_setClass(Bundle.main, CustomBundle.self)
        currentBundle = languageBundle
    }
    
    static func localizedString(forKey key: String, comment: String) -> String {
        return currentBundle.localizedString(forKey: key, value: nil, table: nil)
    }
}
