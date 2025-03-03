import SwiftUI
import SpriteKit


struct MainView : View {
    @State var partName: String = ""
    @State var navigateToExerciseView: Bool = false
    @State var isPartSelected : Bool = false
    
    @State var isActive: Bool = false
    
    var scene: SKScene {
        let scene = BodyScene(size: CGSize(width: 360, height: 720))
        scene.scaleMode = .resizeFill
        scene.backgroundColor = UIColor(named: "Sand") ?? UIColor(red: 255/255, green: 236/255, blue: 210/255, alpha: 1)
        scene.partName = $partName
        scene.isPartSelected = $isPartSelected
        
        return scene
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Selected Part: \(partName)")
                        .padding()
                        .foregroundColor(.black)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .frame(width: 240, height: 50)
                        .background(
                            Rectangle()
                                .stroke(.greenVariant, lineWidth: 3)
                                .cornerRadius(3)
                        )
                    
                    
                    if isPartSelected {
                        Button("Confirm") {
                            isActive = true
                        }
                        .padding()
                        .background(
                            Color.greenVariant
                                .cornerRadius(5)
                        )
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(width: 100, height: 50)
                        .foregroundColor(.white)
                    }
                }
                
                SpriteView(scene: scene)
                
                NavigationLink(destination: ExerciseView(bodyPart: partName), isActive: $isActive) {
                    EmptyView()
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Sand"))
        }
        
        
    }
}
