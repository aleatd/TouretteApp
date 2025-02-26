import SpriteKit

class Dot: SKShapeNode {
    let colorSequence: SKAction
    
    override init() {
        let firstColorTransitionAction = createColorTransitionAction(duration: 1.2, fromColor: .yellow, toColor: UIColor(red: 0.58, green: 0.47451, blue: 0, alpha: 1))
        let secondColorTransitionAction = createColorTransitionAction(duration: 1.2, fromColor: UIColor(red: 0.58, green: 0.47451, blue: 0, alpha: 1), toColor: .yellow)
        colorSequence = SKAction.repeatForever(SKAction.sequence([firstColorTransitionAction, secondColorTransitionAction]))
        
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
