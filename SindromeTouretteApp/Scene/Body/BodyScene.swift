import SwiftUI
import SpriteKit

class BodyScene: SKScene {
    var isZoomedIn: Bool = false
    var isPartSelected : Binding<Bool>?
    
    var partName: Binding<String>?
    
    let bodyNames = [
        "Head",
        "Shoulder",
        "Arm",
        "Hand",
        "Leg",
        "Foot"
    ]
    
    let faceNames = [
        "Eye",
        "Nose",
        "Mouth"
    ]
    
    var currentSelectedDot: Dot? = nil
    
    let background = SKSpriteNode(imageNamed: "Man")
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: size.width / 2, y: size.height / 2 + 25)
        
        addChild(background)
        
        
        let face = SKImage(systemName: "face.smiling", size: CGSize(width: 40, height: 40))
        face.position = CGPoint(x: size.width / 2 + 160, y: size.height / 2 + 320)
        face.name = "face"
        face.color = .greenVariant
        self.addChild(face)
        
        let label = SKLabelNode(text: "Face")
        label.fontSize = 14
        label.position = CGPoint(x: 0, y: -35)
        label.fontColor = .black
        label.fontName = "SF Pro Rounded"
        face.addChild(label)
        
        let parts = [
            ("Head", CGPoint(x: 0, y: 220), 96),
            ("Shoulder", CGPoint(x: -80, y: 85), 36),
            ("Shoulder", CGPoint(x: 80, y: 85), 36),
            ("Arm", CGPoint(x: -100, y: 0), 56),
            ("Arm", CGPoint(x: 100, y: 0), 56),
            ("Hand", CGPoint(x: -130, y: -120), 36),
            ("Hand", CGPoint(x: 130, y: -120), 36),
            ("Leg", CGPoint(x: -50, y: -175), 48),
            ("Leg", CGPoint(x: 50, y: -175), 48),
            ("Foot", CGPoint(x: -50, y: -300), 48),
            ("Foot", CGPoint(x: 50, y: -300), 48),
            ("Eye", CGPoint(x: -45, y: 210), 12),
            ("Eye", CGPoint(x: 45, y: 210), 12),
            ("Nose", CGPoint(x: 0, y: 195), 18),
            ("Mouth", CGPoint(x: 0, y: 165), 18)
        ]
        
        for (name, position, size) in parts {
            let node = SKShapeNode(circleOfRadius: CGFloat(size))
            node.position = position
            node.name = name
            node.fillColor = .clear
            
            node.alpha = 0.5
            
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
        
        
        isPartSelected?.wrappedValue = false
        
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
                    face.changeImage(to: "face.smiling.inverse")
                    zoomIn(background, CGPoint(x: size.width / 2 - 190, y: size.height - 255))
                } else {
                    face.changeImage(to: "face.smiling")
                    zoomOut(background)
                }
                face.run(pulse)
            } else if bodyNames.contains(node.name ?? "") || faceNames.contains(node.name ?? "") {
                let name = node.name!
                
                if let dot = node.childNode(withName: "dot") as? Dot {
                    dot.activate()
                    partName?.wrappedValue = name
                    isPartSelected?.wrappedValue = true
                    
                }
                
                
                
                pulsate(node: node as! SKShapeNode)
                
                
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
        isZoomedIn = true
    }
    
    func pulsate(node: SKShapeNode) {
        let originalColor = node.strokeColor
        let originalAlpha = node.alpha
        let originalWidth = node.lineWidth
        
        let colorChange = SKAction.run {
            node.strokeColor = .greenVariant
            node.lineWidth = 5.0
        }
        
        let pulsateUp = SKAction.group([
            SKAction.scale(to: 1.2, duration: 0.5),
            SKAction.fadeAlpha(to: 0.5, duration: 0.5),
        ])
        
        let pulsateDown = SKAction.group([
            SKAction.scale(to: 1.0, duration: 0.5),
            SKAction.fadeAlpha(to: 0.3, duration: 0.5)
        ])
        
        let pulsate = SKAction.sequence([pulsateUp,pulsateDown])
        
        let colorReset = SKAction.run {
            node.strokeColor = originalColor
            node.alpha = originalAlpha
            node.lineWidth = originalWidth
        }
        
        let finalSequence = SKAction.sequence([colorChange,pulsate,colorReset])
        
        node.run(finalSequence)
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
        isZoomedIn = false
    }
}
