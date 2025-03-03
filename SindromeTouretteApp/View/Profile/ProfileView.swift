import SwiftUI

struct ProfileView: View {
    @State private var selectedGender: Gender = .other
    @State private var selectedSkinTone: SkinTone = .light
    @State private var timerDuration: Int = 30

    var body: some View {
        NavigationView {
            Form {
            }
            .background(Color.sand)
            .scrollContentBackground(.hidden)
            .buttonStyle(.plain)
            .navigationTitle("Profile")
            .navigationBarItems(trailing:
                Button(action: {
                    print("Mum, I'm in debugging mode!")
                }) {                    
                    Text("Done")
                        .foregroundStyle(.greenVariant)
                        .padding()
                }
            )
        }
    }
}

enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
    case other = "Toaster"
}

enum SkinTone: String, CaseIterable {
    case light = "White"
    case medium = "Mid"
    case dark = "Black"
}
