import SwiftUI

struct SettingsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var colorBlindnessSettings: ColorBlindnessSettings
    
    @AppStorage("name") private var name: String = ""
    @State private var language: String = Locale.current.language.languageCode?.identifier == "it" ? "Italiano" : "English"
    @State private var avatar: Image? = Image("Face")
    @State private var interaction: String = "None"
    @State private var isEditingName: Bool = false
    
    let interactions = [
        "None",
        "Buttons",
        "Swipe",
        "Vocal",
        "Buttons/Vocal",
        "Swipe/Vocal"
    ]
    
    let languages = [
        "English",
        "Italiano"
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.sand.ignoresSafeArea()
                
                Form {
                    Section(header: Text(NSLocalizedString("Profile", comment: ""))
                        .foregroundColor(Color.brown)) {
                            HStack {
                                if let avatar = avatar {
                                    avatar
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                }
                                
                                VStack(alignment: .leading) {
                                    if isEditingName {
                                        TextField(NSLocalizedString("Name", comment: ""), text: $name)
                                            .textFieldStyle(PlainTextFieldStyle())
                                            .foregroundColor(Color.brown)
                                        
                                        Button(action: { isEditingName = false }) {
                                            Text(NSLocalizedString("Save", comment: ""))
                                                .font(.caption).foregroundColor(.blue)
                                        }
                                    } else {
                                        Text(name.isEmpty ? NSLocalizedString("SelectYourName", comment: "") : name)
                                            .font(.headline)
                                            .foregroundColor(Color.brown)
                                        
                                        Button(action: { isEditingName = true }) {
                                            Text(NSLocalizedString("Edit", comment: ""))
                                                .font(.caption)
                                                .foregroundColor(Color.greenVariant)
                                        }
                                    }
                                }
                            }
                            
                            Menu {
                                ForEach(languages, id: \.self) { lang in
                                    Button(action: { language = lang }) {
                                        Text(lang)
                                    }
                                }
                            } label: {
                                HStack {
                                    Text(NSLocalizedString("Language", comment: ""))
                                        .foregroundColor(.brown)
                                    Spacer()
                                    Text(language)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.sand)
                                .cornerRadius(8)
                                .frame(maxWidth: .infinity)
                            }
                            .padding(.bottom)
                        }
                        .listRowBackground(Color.sand)
                    
                    Section(header: Text(NSLocalizedString("AccessibilitySettings", comment: ""))
                        .foregroundColor(.brown)) {
                            
                            Menu {
                                ForEach(interactions, id: \.self) { interactionOption in
                                    Button(action: { interaction = interactionOption }) {
                                        Text(NSLocalizedString(interactionOption, comment: ""))
                                    }
                                }
                            }
                            label: {
                                HStack {
                                    Text(NSLocalizedString("Interactions", comment: ""))
                                        .foregroundColor(.brown)
                                    Spacer()
                                    Text(interaction)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.sand)
                                .cornerRadius(8)
                                .frame(maxWidth: .infinity)
                            }
                            .padding(.bottom)
                            
                            Menu {
                                ForEach(ColorBlindnessType.allCases) { type in
                                    Button(action: { colorBlindnessSettings.type = type }) {
                                        Text(NSLocalizedString(type.rawValue, comment: ""))
                                    }
                                }
                            } label: {
                                HStack {
                                    Text(NSLocalizedString("ColorBlindness", comment: ""))
                                        .foregroundColor(.brown)
                                    Spacer()
                                    Text(NSLocalizedString(colorBlindnessSettings.type.rawValue, comment: ""))
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.sand)
                                .cornerRadius(8)
                                .frame(maxWidth: .infinity)
                            }
                            .padding(.top, 10)
                        }
                        .listRowBackground(Color.sand)
                }
                .scrollContentBackground(.hidden)
                .background(Color.sand)
            }
            .navigationBarTitle("Settings")
            .onAppear {
                language = Locale.current.language.languageCode?.identifier == "it" ? "Italiano" : "English"
            }
        }
        .accentColor(Color.brown)
    }
}
