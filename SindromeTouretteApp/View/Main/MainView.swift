import SwiftUI
import SpriteKit

struct MainView: UIViewRepresentable {
    func makeUIView(context: Context) -> SKView {
        let view = SKView()
        let scene = BodyScene(size: CGSize(width: 360, height: 720))
        scene.scaleMode = .aspectFit
        scene.backgroundColor = .white
        view.presentScene(scene)
        return view
    }

    func updateUIView(_ uiView: SKView, context: Context) {}
}

