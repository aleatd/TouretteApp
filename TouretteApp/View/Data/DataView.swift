import SwiftUI

struct DataView: View {
    @State private var selectedDate: Date = Date()
    @State private var isDatePickerPresented: Bool = false
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text(formatter.string(from: selectedDate))
                        .font(.headline)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Spacer()
                    
                    Button(action: {
                        isDatePickerPresented.toggle()
                    }) {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.greenVariant)
                            .padding(.horizontal)
                    }
                }
                .padding()
                
                ScrollView(.vertical, showsIndicators: true) {
                    VStack {
                        ChartView(selectedDate: $selectedDate)
                    }
                }
            }
            .navigationTitle("Charts")
            .background(Color.sand.ignoresSafeArea())
            .sheet(isPresented: $isDatePickerPresented) {
                DatePickerSheet(selectedDate: $selectedDate)
            }
        }
    }
}
