import SpriteKit

class SKImage: SKSpriteNode {
    
    init(image: String, size: CGSize) {
        let texture = SKImage.createTexture(from: image)
        super.init(texture: texture, color: .clear, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeImage(to image: String) {
        let newTexture = SKImage.createTexture(from: image)
        self.texture = newTexture
    }
    
    private static func createTexture(from source: Any) -> SKTexture {
        if let name = source as? String {
            return SKTexture(imageNamed: name)
        } else if let uiImage = source as? UIImage {
            return SKTexture(image: uiImage)
        } else if let texture = source as? SKTexture {
            return texture
        } else {
            return SKTexture()
        }
    }
}
