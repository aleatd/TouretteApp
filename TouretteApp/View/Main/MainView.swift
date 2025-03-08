import SwiftUI
import SpriteKit

struct MainView : View {
    @State var partName: String = ""
    @State var navigateToExerciseView: Bool = false
    @State var isPartSelected : Bool = false
    
    var scene: SKScene {
        let scene = BodyScene(size: CGSize(width: 360, height: 720))
        scene.scaleMode = .resizeFill
        scene.backgroundColor = UIColor(named: "Sand") ?? UIColor(red: 255/255, green: 236/255, blue: 210/255, alpha: 1)
        scene.partName = $partName
        scene.isPartSelected = $isPartSelected
        
        return scene
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    if isPartSelected {
                        
                        Text(String(format: NSLocalizedString("SelectedPart", comment: "Selected part label") + NSLocalizedString(partName, comment: "")))
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
                        
                        
                        Button(NSLocalizedString("Confirm", comment: "Confirm button text")) {
                            navigateToExerciseView = true
                        }
                        .font(.caption)
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
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.sand)
            .navigationDestination(isPresented: $navigateToExerciseView) {
                MeditationTimer(partName: partName)
            }
            .tint(.red)
        }
        .accentColor(.greenVariant)
    }
}
