import Foundation

class TouretteCache {
    static let shared = TouretteCache()
    private init() {}
    
    private let touretteCache = NSCache<NSString, NSString>()
    
    func set(_ value: String, forKey key: String) {
        touretteCache.setObject(value as NSString, forKey: key as NSString)
    }
    
    func clear() {
        touretteCache.removeAllObjects()
    }
    
    func toString(forKey key: String) -> String? {
        return touretteCache.object(forKey: key as NSString) as String?
    }
    
    func save(data: String, filename: String) {
        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)
        do {
            try data.write(to: fileURL, atomically: true, encoding: .utf8)
            print("Saved on: \(fileURL)")
        } catch {
            print("Error: \(error)")
        }
    }
    
    func load(filename: String) -> String? {
        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)
        do {
            let data = try String(contentsOf: fileURL, encoding: .utf8)
            return data
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    func toCached(filename: String, cacheKey: String) {
        if let data = load(filename: filename) {
            TouretteCache.shared.set(data, forKey: cacheKey)
            print("Loaded and cached: \(cacheKey)")
        }
    }
}

