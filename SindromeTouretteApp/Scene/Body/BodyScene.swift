import SwiftUI
import SpriteKit

class BodyScene: SKScene {
    var partName : Binding<String>?
    let background = SKSpriteNode(imageNamed: "Man")
    
    override func didMove(to view: SKView) {
        
       
      
        background.size.height = 690.0
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(background)
        
        let parts = [
            ("Head", CGPoint(x: size.width / 2, y: size.height - 125), 96),
            
            ("Left Shoulder", CGPoint(x: size.width / 2 - 75, y: size.height / 2 + 90), 36),
            ("Right Shoulder", CGPoint(x: size.width / 2 + 75, y: size.height / 2 + 90), 36),

            ("Left Arm", CGPoint(x: size.width / 2 - 100, y: size.height / 2 - 10), 56),
            ("Right Arm", CGPoint(x: size.width / 2 + 100, y: size.height / 2 - 10), 56),
            
            ("Left Hand", CGPoint(x: size.width / 2 - 125, y: size.height / 2 - 115), 36),
            ("Right Hand", CGPoint(x: size.width / 2 + 125, y: size.height / 2 - 115), 36),

            ("Left Leg", CGPoint(x: size.width / 2 - 50, y: size.height / 4), 56),
            ("Right Leg", CGPoint(x: size.width / 2 + 50, y: size.height / 4), 56),
            
            ("Left Foot", CGPoint(x: size.width / 2 - 50, y: size.height / 4 - 125), 48),
            ("Right Foot", CGPoint(x: size.width / 2 + 50, y: size.height / 4 - 125), 48),
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
<<<<<<< Updated upstream
            print("\(name)")
            if let dot = node.childNode(withName: "dot") as? Dot {
                dot.activate()
=======
            partName?.wrappedValue = name
            
            if name == "Head" {
                zoomIn(background,CGPoint(x: node.position.x - 190 , y: node.position.y - 150) )
>>>>>>> Stashed changes
            }
        }
    }
    
    func zoomIn(_ node :SKSpriteNode, _ targetCoor : CGPoint) {
        let targetPosition = node.convert(targetCoor, to: self)
        
        let dx = (node.position.x - targetPosition.x) * (1.5 - 1)
        let dy = (node.position.y - targetPosition.y) * (1.5 - 1)
        
        let moveAction  = SKAction.move(by: CGVector(dx: dx, dy: dy), duration: 0.5)
        let scaleAction = SKAction.scale(by: 1.8, duration: 0.5)
        
        let group = SKAction.group([moveAction,scaleAction])
        node.run(group)
    }
}
