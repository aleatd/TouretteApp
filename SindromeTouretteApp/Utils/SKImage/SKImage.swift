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
    
    func changeImage(to img: String) {
        texture = SKTexture(image: UIImage(systemName: img) ?? UIImage(systemName: "face.smiling")!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
