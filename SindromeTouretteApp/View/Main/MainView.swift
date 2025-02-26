import SwiftUI
import SpriteKit


struct MainView : View {
    @State var partName: String = ""
    
    var scene: SKScene {
        let scene = BodyScene(size: CGSize(width: 360, height: 720))
        scene.scaleMode = .resizeFill
        scene.backgroundColor = UIColor(named: "Sand") ?? UIColor(red: 255/255, green: 236/255, blue: 210/255, alpha: 1)
        scene.partName = $partName
        
        return scene
    }
    
    var body: some View {
        
        VStack {
            Text("Part: \(partName)")
                .padding()
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .frame(width: 240, height: 50)
                .background(
                    Rectangle()
                        .stroke(Color.black, lineWidth: 3)
                        .shadow(radius: 5)
                )
                .cornerRadius(3)
            
            
            SpriteView(scene: scene)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Sand"))
        
    }
}
