import Foundation

class CustomBundle: Bundle, @unchecked Sendable {
    override class func preferredLocalizations(from localizations: [String]) -> [String] {
        return [Bundle.preferredLocalizations(from: localizations).first ?? "en"]
    }
}
