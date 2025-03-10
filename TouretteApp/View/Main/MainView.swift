import SwiftUI
import SpriteKit

struct MainView: View {
    @State private var partName: String = ""
    @State private var navigationPath : [String] = []
    @State private var navigateToNextView = false

    var scene: SKScene {
        let scene = BodyScene(size: CGSize(width: 360, height: 720))
        scene.scaleMode = .resizeFill
        scene.backgroundColor = UIColor(named: "Sand") ?? UIColor(red: 255/255, green: 236/255, blue: 210/255, alpha: 1)
        scene.partName = $partName
        scene.navigationPath = $navigationPath
        scene.navigateToExerciseView = $navigateToNextView
        return scene
    }

    var body: some View {
        NavigationStack {
            VStack {
                SpriteView(scene: scene)
                    .ignoresSafeArea(.all)
            }
        
            
            .navigationDestination(isPresented: $navigateToNextView) {
                ExerciseView(bodyPart: partName, navigationPath : $navigationPath)
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Sand"))
        }
        .accentColor(.greenVariant)
    }
}
