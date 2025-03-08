import SpriteKit

extension SKColor {
    func interpolateTo(color: SKColor, fraction: CGFloat) -> SKColor {
        let fraction = min(max(fraction, 0), 1)
        
        let firstColor = CIColor(color: self)
        let secondColor = CIColor(color: color)
        
        let red = firstColor.red + (secondColor.red - firstColor.red) * fraction
        let green = firstColor.green + (secondColor.green - firstColor.green) * fraction
        let blue = firstColor.blue + (secondColor.blue - firstColor.blue) * fraction
        let alpha = firstColor.alpha + (secondColor.alpha - firstColor.alpha) * fraction
        
        return SKColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static func createColorTransitionAction(duration: TimeInterval, fromColor: SKColor, toColor: SKColor) -> SKAction {
        return SKAction.customAction(withDuration: duration) { node, elapsedTime in
            guard let shapeNode = node as? SKShapeNode else { return }
            
            let fraction = CGFloat(elapsedTime) / CGFloat(duration)
            shapeNode.fillColor = fromColor.interpolateTo(color: toColor, fraction: fraction)
        }
    }
}
