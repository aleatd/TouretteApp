//
//  Dot.swift
//  SindromeTouretteApp
//
//  Created by Gian Marco Taddeo on 24/02/25.
//

import SpriteKit

extension SKColor {
    func interpolateTo(color: SKColor, fraction: CGFloat) -> SKColor {
        let fraction = min(max(fraction, 0), 1) // Clamp fraction between 0 and 1
        
        let c1 = CIColor(color: self)
        let c2 = CIColor(color: color)
        
        let r = c1.red + (c2.red - c1.red) * fraction
        let g = c1.green + (c2.green - c1.green) * fraction
        let b = c1.blue + (c2.blue - c1.blue) * fraction
        let a = c1.alpha + (c2.alpha - c1.alpha) * fraction
        
        return SKColor(red: r, green: g, blue: b, alpha: a)
    }
}

func createColorTransitionAction(duration: TimeInterval, fromColor: SKColor, toColor: SKColor) -> SKAction {
    return SKAction.customAction(withDuration: duration) { node, elapsedTime in
        guard let shapeNode = node as? SKShapeNode else { return }
        
        let fraction = CGFloat(elapsedTime) / CGFloat(duration)
        shapeNode.fillColor = fromColor.interpolateTo(color: toColor, fraction: fraction)
    }
}

class Dot: SKShapeNode {
    let colorSequence: SKAction
    
    override init() {
        let colorTransitionAction1 = createColorTransitionAction(duration: 1.2, fromColor: .yellow, toColor: UIColor(red: 0.58, green: 0.47451, blue: 0, alpha: 1))
        let colorTransitionAction2 = createColorTransitionAction(duration: 1.2, fromColor: UIColor(red: 0.58, green: 0.47451, blue: 0, alpha: 1), toColor: .yellow)
        colorSequence = SKAction.repeatForever(SKAction.sequence([colorTransitionAction1, colorTransitionAction2]))
        
        super.init()
        let radius: CGFloat = 5
        let path = CGMutablePath()
        path.addArc(center: .zero, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        self.path = path
        self.fillColor = .gray
        self.strokeColor = .black
        
    }
    
    func activate() {
        self.run(colorSequence)
    }
    
    func deactivate() {
        self.removeAllActions()
        self.fillColor = .gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        let colorTransitionAction1 = createColorTransitionAction(duration: 1.2, fromColor: .yellow, toColor: UIColor(red: 0.58, green: 0.47451, blue: 0, alpha: 1))
        let colorTransitionAction2 = createColorTransitionAction(duration: 1.2, fromColor: UIColor(red: 0.58, green: 0.47451, blue: 0, alpha: 1), toColor: .yellow)
        colorSequence = SKAction.repeatForever(SKAction.sequence([colorTransitionAction1, colorTransitionAction2]))
        super.init(coder: aDecoder)
    }
}
