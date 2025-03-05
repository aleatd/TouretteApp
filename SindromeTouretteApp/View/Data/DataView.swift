import SwiftUI

struct DataView: View {
    @State private var selectedDate: Date = Date()
    @State private var showingDatePicker = false
    
    let calendar = Calendar.current
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    } ()
    
    var body: some View {
        VStack {
            HStack {
                if showingDatePicker {
                    DatePicker(
                        "",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .frame(height: 235)
                    .scaleEffect(0.8)
                    .clipped()
                }
                
                Spacer()
                
                Button(action: {
                    showingDatePicker.toggle()
                }) {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.emerald)
                        .padding(.horizontal)
                }
                .padding(.bottom, showingDatePicker ? 210 : 0)
            }
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 10) {
                        ForEach(uniqueDatesArray, id: \.self) { date in
                            Button(action: {
                                selectedDate = date
                            }) {
                                Text(dateFormatter.string(from: date))
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
                .padding()
            }
        }
    }
}

