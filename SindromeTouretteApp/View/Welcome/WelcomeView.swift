import SwiftUI

struct WelcomeView: View {
    @State private var currentPage = 0
    @State private var showDefaultPage = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                TabView(selection: $currentPage) {
                    WelcomePageView(
                        imageName: "",
                        title: "First Page Title",
                        description: "First Page Description",
                        tag: 0
                    )
                    
                    WelcomePageView(
                        imageName: "",
                        title: "Second Page Title",
                        description: "Second Page Description",
                        tag: 1
                    )
                    
                    WelcomePageView(
                        imageName: "",
                        title: "Third Page Title",
                        description: "Third Page Description",
                        tag: 2
                    )
                }
                .indexViewStyle(.page(backgroundDisplayMode: .never))
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                Spacer(minLength: 20)
                
                ControlView(currentPage: $currentPage)
                    .padding(.top, -35)
                
                Spacer()
                
                Button(action: {
                }) {
                    if (currentPage == 2) {
                        Text("Get Started!")
                            .font(.custom("Helvetica", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(.greenVariant)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .background(.sand)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
