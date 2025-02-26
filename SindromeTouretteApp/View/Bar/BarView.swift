import SwiftUI

struct BarView: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.emerald)
                    .shadow(color: .gray.opacity(0.35), radius: 10, x: 0, y: 5)
                
                LayoutView(selectedTab: $selectedTab)
            }
            .frame(height: 70)
            .padding(.horizontal, 20)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

fileprivate struct LayoutView: View {
    @Binding var selectedTab: Tab
    @Namespace var namespace
    
    var body: some View {
        HStack(spacing: 40) {
            ForEach(Tab.allCases) { tab in
                TabButton(tab: tab, selectedTab: $selectedTab, namespace: namespace)
            }
        }
        .padding(.horizontal, 20)
    }
}

fileprivate struct TabButton: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    var namespace: Namespace.ID
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 1)) {
                selectedTab = tab
            }
        }) {
            ZStack {
                if isSelected {
                    Circle()
                        .fill(Color.greenVariant)
                        .shadow(radius: 10)
                        .matchedGeometryEffect(id: "SelectedTab", in: namespace)
                        .offset(y: -20)
                }
                
                Image(systemName: tab.icon)
                    .font(.system(size: 23, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .scaleEffect(isSelected ? 1 : 0.8)
                    .offset(y: isSelected ? -20 : 0)
                    .animation(.spring(), value: selectedTab)
            }
            .frame(width: 65, height: 65)
        }
        .buttonStyle(.plain)
    }
    
    private var isSelected: Bool {
        selectedTab == tab
    }
}

