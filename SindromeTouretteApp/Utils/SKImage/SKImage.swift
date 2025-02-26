import SpriteKit
import UIKit

class SKImage: SKSpriteNode {
    init(systemName: String, size: CGSize = CGSize(width: 50, height: 50)) {
        if let image = UIImage(systemName: systemName) {
            let texture = SKTexture(image: image)
            super.init(texture: texture, color: .clear, size: size)
        } else {
            super.init(texture: nil, color: .clear, size: size)
            print("Error: Could not load system image \(systemName)")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
