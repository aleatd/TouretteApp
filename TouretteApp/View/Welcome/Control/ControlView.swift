import SwiftUI

struct ControlView: View {
    @Binding var currentPage: Int
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(index == currentPage ? (colorScheme == .dark ? Color.white : Color.black) : Color.gray.opacity(0.5))
                    .frame(width: 10, height: 10)
                    .scaleEffect(index == currentPage ? 1.3 : 1.0)
            }
        }
        .padding(.top, 10)
    }
}

