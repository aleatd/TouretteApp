import SwiftUI
import SpriteKit

class BodyScene: SKScene {
    var isZoomedIn: Bool = false
    
    var partName: Binding<String>?
    let partNames = [
        "Head",
        "Left Shoulder",
        "Right Shoulder",
        "Left Arm",
        "Right Arm",
        "Left Hand",
        "Right Hand",
        "Left Leg",
        "Right Leg",
        "Left Foot",
        "Right Foot"
    ]
    
    let background = SKSpriteNode(imageNamed: "Man")
    
    override func didMove(to view: SKView) {
        background.size.height = 690.0
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(background)
        
        let glass = SKImage(systemName: "plus.magnifyingglass", size: CGSize(width: 40, height: 40))
        glass.position = CGPoint(x: size.width / 2 + 160, y: size.height / 2 + 320)
        glass.name = "glass"
        addChild(glass)
        
        
        let parts = [
                   ("Head", CGPoint(x: 0, y: 220), 96),
                   ("Left Shoulder", CGPoint(x: -80, y: 85), 36),
                   ("Right Shoulder", CGPoint(x: 80, y: 85), 36),
                   ("Left Arm", CGPoint(x: -100, y: 0), 56),
                   ("Right Arm", CGPoint(x: 100, y: 0), 56),
                   ("Left Hand", CGPoint(x: -130, y: -120), 36),
                   ("Right Hand", CGPoint(x: 130, y: -120), 36),
                   ("Left Leg", CGPoint(x: -50, y: -175), 48),
                   ("Right Leg", CGPoint(x: 50, y: -175), 48),
                   ("Left Foot", CGPoint(x: -50, y: -300), 48),
                   ("Right Foot", CGPoint(x: 50, y: -300), 48),
                   ("Left Eye", CGPoint(x: -45, y: 210), 12),
                   ("Right Eye", CGPoint(x: 45, y: 210), 12),
                   ("Nose", CGPoint(x: 0, y: 195), 24),
                   ("Mouth", CGPoint(x: 0, y: 165), 24)
               ]
        
        for (name, position, size) in parts {
            let node = SKShapeNode(circleOfRadius: CGFloat(size))
            node.position = position
            node.name = name
            node.fillColor = .red
            node.alpha = 0.5
            node.strokeColor = .clear
            
            let dot = Dot()
            dot.name = "dot"
            node.addChild(dot)
            
            background.addChild(node)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        for node in background.children {
            if let dot = node.childNode(withName: "dot") as? Dot {
                dot.deactivate()
                partName?.wrappedValue = ""
            }
        }
        
        for node in nodes(at: location) {
            if node.name == "glass" {
                let pulse = SKAction.sequence([SKAction.scale(to: 1.2, duration: 0.1), SKAction.scale(to: 1, duration: 0.1)])
                
                let glass = node as! SKImage
                glass.removeAllActions()
                glass.size = CGSize(width: 40, height: 40)
                
                if !isZoomedIn {
                    glass.texture = SKTexture(image: UIImage(systemName: "minus.magnifyingglass")!)
                    zoomIn(background, CGPoint(x: size.width / 2 - 190, y: size.height - 255))
                    isZoomedIn = true
                } else {
                    glass.texture = SKTexture(image: UIImage(systemName: "plus.magnifyingglass")!)
                    zoomOut(background)
                    isZoomedIn = false
                }
                glass.run(pulse)
            } else if partNames.contains(node.name ?? "") {
                let name = node.name!
                print("\(name)")
                if let dot = node.childNode(withName: "dot") as? Dot {
                    dot.activate()
                    partName?.wrappedValue = name
                }
            }
        }
    }
    
    func zoomIn(_ node: SKSpriteNode, _ coordinate: CGPoint) {
        let position = node.convert(coordinate, to: self)
        
        let x = (node.position.x - position.x) * (1.5 - 1)
        let y = (node.position.y - position.y) * (1.5 - 1)
        
        let moveAction  = SKAction.move(by: CGVector(dx: x, dy: y), duration: 0.5)
        let scaleAction = SKAction.scale(by: 1.5, duration: 0.5)
        
        let group = SKAction.group([moveAction, scaleAction])
        node.run(group)
        
        for node in background.children {
            if partNames.contains(node.name ?? "") {
                node.isHidden = true
            }
        }
    }
    
    func zoomOut(_ node: SKSpriteNode) {
        let moveAction  = SKAction.move(to: CGPoint(x: size.width / 2, y: size.height / 2), duration: 0.5)
        let scaleAction = SKAction.scale(to: 1.0, duration: 0.5)
        
        let group = SKAction.group([moveAction, scaleAction])
        node.run(group)
        
        for node in background.children {
            if partNames.contains(node.name ?? "") {
                node.isHidden = false
            }
        }
    }
}
