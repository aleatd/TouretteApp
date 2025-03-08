import SwiftUI
import SpriteKit

class BodyScene: SKScene {
    var isZoomedIn: Bool = false
    
    var partName: Binding<String>?
    
    let bodyNames = [
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
    
    let faceNames = [
        "Left Eye",
        "Right Eye",
        "Nose",
        "Mouth"
    ]
    
    
    let background = SKSpriteNode(imageNamed: "Man")
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: size.width / 2, y: size.height / 2 + 25)
        addChild(background)
        
        let face = SKImage(systemName: "face.smiling", size: CGSize(width: 40, height: 40))
        face.position = CGPoint(x: size.width / 2 + 160, y: size.height / 2 + 320)
        face.name = "face"
        self.addChild(face)
        
        let label = SKLabelNode(text: "Face")
        label.fontSize = 14
        label.position = CGPoint(x: 0, y: -35)
        label.fontColor = .black
        label.fontName = "SF Pro Rounded"
        face.addChild(label)
        
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
            node.fillColor = .clear
            node.strokeColor = .clear
            
            let dot = Dot()
            dot.name = "dot"
            node.addChild(dot)
            
            if (faceNames.contains(node.name ?? "")) {
                node.isHidden = true
            }
            
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
            if node.name == "face" {
                let pulse = SKAction.sequence([SKAction.scale(to: 1.2, duration: 0.1), SKAction.scale(to: 1, duration: 0.1)])
                
                let face = node as! SKImage
                face.removeAllActions()
                face.size = CGSize(width: 40, height: 40)
                
                if !isZoomedIn {
                    face.texture = SKTexture(image: UIImage(systemName: "face.smiling.inverse")!)
                    
                    zoomIn(background, CGPoint(x: size.width / 2 - 190, y: size.height - 255))
                    
                    isZoomedIn = true
                } else {
                    face.texture = SKTexture(image: UIImage(systemName: "face.smiling")!)
                    zoomOut(background)
                    isZoomedIn = false
                }
                face.run(pulse)
            } else if bodyNames.contains(node.name ?? "") || faceNames.contains(node.name ?? "") {
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
            if bodyNames.contains(node.name ?? "") {
                node.isHidden = true
            }
            
            if (faceNames.contains(node.name ?? "")) {
                node.isHidden = false
            }
        }
    }
    
    func zoomOut(_ node: SKSpriteNode) {
        let moveAction  = SKAction.move(to: CGPoint(x: size.width / 2, y: size.height / 2 + 25), duration: 0.5)
        let scaleAction = SKAction.scale(to: 1.0, duration: 0.5)
        
        let group = SKAction.group([moveAction, scaleAction])
        node.run(group)
        
        for node in background.children {
            if bodyNames.contains(node.name ?? "") {
                node.isHidden = false
            }
            
            if (faceNames.contains(node.name ?? "")) {
                node.isHidden = true
            }
        }
    }
}
