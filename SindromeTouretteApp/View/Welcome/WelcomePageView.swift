import SwiftUI

struct WelcomePageView: View {
    let imageName: String
    let title: String
    let description: String
    let tag: Int
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding(.bottom, 8)
            
            Text(title)
                .font(.custom("Helvetica", size: 18))
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 12)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
            Divider()
                .frame(width: 100, height: 2)
                .background(.black)
                .padding(.top, 10)
            
            Text(description)
                .font(.custom("Helvetica", size: 14))
                .fontWeight(.regular)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .padding(.top, 10)
        }
        .tag(tag)
    }
}
