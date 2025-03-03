import SwiftUI

struct DataView: View {
    @State private var selectedDate: Date = Date()
    
    let calendar = Calendar.current
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM" // Format: "02 Mar"
        return formatter
    }()
    
    var weekDates: [Date] {
        let today = Date()
        return (0..<30).compactMap { calendar.date(byAdding: .day, value: $0, to: today) }
    }
    
    var body: some View {
        VStack {
            Text("Selected Date: \(dateFormatter.string(from: selectedDate))")
                .font(.headline)
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(weekDates, id: \.self) { date in
                        Button(action: {
                            selectedDate = date
                        }) {
                            VStack {
                                Text(dateFormatter.string(from: date))
                                    .foregroundColor(selectedDate == date ? .white : .black)
                                    .padding()
                                    .background(selectedDate == date ? Color.blue : Color.gray.opacity(0.2))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }
                }
                Spacer().padding(310)
            }
        }
    }
}
