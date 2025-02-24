import SwiftUI
import SpriteKit

class BodyScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = .white
        
        let background = SKSpriteNode(imageNamed: "Man")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(background)
        
        let parts = [
            ("head", CGPoint(x: size.width / 2, y: size.height - 125), 96),
            
            ("lShoulder", CGPoint(x: size.width / 2 - 75, y: size.height / 2 + 90), 36),
            ("rShoulder", CGPoint(x: size.width / 2 + 75, y: size.height / 2 + 90), 36),

            ("lArm", CGPoint(x: size.width / 2 - 100, y: size.height / 2 - 10), 56),
            ("rArm", CGPoint(x: size.width / 2 + 100, y: size.height / 2 - 10), 56),
            
            ("lHand", CGPoint(x: size.width / 2 - 125, y: size.height / 2 - 115), 36),
            ("rHand", CGPoint(x: size.width / 2 + 125, y: size.height / 2 - 115), 36),

            ("lLeg", CGPoint(x: size.width / 2 - 50, y: size.height / 4), 56),
            ("rLeg", CGPoint(x: size.width / 2 + 50, y: size.height / 4), 56),
            
            ("lFoot", CGPoint(x: size.width / 2 - 50, y: size.height / 4 - 125), 48),
            ("rFoot", CGPoint(x: size.width / 2 + 50, y: size.height / 4 - 125), 48),
        ]
        
        var nodes: [SKShapeNode] = []
        
        for (name, position, size) in parts {
            let node = SKShapeNode(circleOfRadius: CGFloat(size))
            node.position = position
            
            node.name = name
            
            node.fillColor = .clear
            
            node.strokeColor = .clear
            
            let dot = Dot()
            dot.name = "dot"
            node.addChild(dot)
            
            addChild(node)
            
            nodes.append(node)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        for node in children {
            if let dot = node.childNode(withName: "dot") as? Dot {
                dot.deactivate()
            }
        }
        
        let node = self.atPoint(location)
        if let name = node.name {
            print("\(name)")
            if let dot = node.childNode(withName: "dot") as? Dot {
                dot.activate()
            }
        }
    }
}
