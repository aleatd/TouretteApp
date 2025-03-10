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
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 10) {
                            ForEach(uniqueDatesArray, id: \.self) { date in
                                Button(action: {
                                    selectedDate = date
                                }) {
                                    Text(formatter.string(from: date))
                                        .foregroundColor(selectedDate == date ? .white : .black)
                                        .padding()
                                        .background(selectedDate == date ? Color.emerald : Color.gray.opacity(0.2))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                .id(date)
                            }
                        }
                    }
                    .frame(height: 60)
                    .onAppear() {
                        selectedDate = uniqueDatesArray.first ?? Date()
                    }
                    .onChange(of: selectedDate) {
                        withAnimation {
                            proxy.scrollTo(selectedDate, anchor: .center)
                        }
                    }
                }
                
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
        .overlay(
            Button(action: {
                isDatePickerPresented.toggle()
            }) {
                Image(systemName: "calendar")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.greenVariant)
                    .padding(.horizontal)
            }
            .padding()
            .offset(x: 15, y: 40)
            .alignmentGuide(.top) { d in d[.top] }
            , alignment: .topTrailing
        )
    }
}
