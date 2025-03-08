import Foundation
import SwiftUI
import Charts

struct ChartView: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: selectedDate)
        let month = calendar.component(.month, from: selectedDate)
        let chartData = prepareChartData(data: sampleData, year: year, month: month)
        
        
        Chart {
            ForEach(chartData, id: \.day) { item in
                let isHighlighted = Calendar.current.isDate(item.day, inSameDayAs: selectedDate)
                
                BarMark(
                    x: .value("Date", item.day),
                    y: .value("Managed Tics", item.managedTics)
                )
                .foregroundStyle(.green)
                .opacity(isHighlighted ? 1.0 : 0.4)
                
                BarMark(
                    x: .value("Date", item.day),
                    y: .value("Not Managed Tics", item.notManagedTics)
                )
                .foregroundStyle(.red)
                .opacity(isHighlighted ? 1.0 : 0.4)
            }
        }
        .chartXAxis(.hidden)
        .chartYAxis {
            AxisMarks()
        }
        .id(selectedDate)
        .padding()
        .frame(height: 300)
    }
}

func generateDaysForMonth(year: Int, month: Int) -> [Date] {
    var calendar = Calendar.current
    calendar.timeZone = TimeZone(secondsFromGMT: 0)!
    guard let startOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: 1)),
          let range = calendar.range(of: .day, in: .month, for: startOfMonth) else { return [] }
    return range.compactMap { day -> Date? in
        let components = DateComponents(year: year, month: month, day: day)
        return calendar.date(from: components)
    }
}


func prepareChartData(data: [TouretteData], year: Int, month: Int) -> [(day: Date, managedTics: Int, notManagedTics: Int)] {
    var calendar = Calendar.current
    calendar.timeZone = TimeZone(secondsFromGMT: 0)!
    let daysInMonth = generateDaysForMonth(year: year, month: month)
    
    var aggregatedData: [Date: (managedTics: Int, notManagedTics: Int)] = [:]
    
    for entry in data {
        let day = calendar.startOfDay(for: entry.realDate)
        if aggregatedData[day] == nil {
            aggregatedData[day] = (managedTics: 0, notManagedTics: 0)
        }
        aggregatedData[day]?.managedTics += entry.managedTics
        aggregatedData[day]?.notManagedTics += entry.notManagedTics
    }
    
    return daysInMonth.map { day -> (day: Date, managedTics: Int, notManagedTics: Int) in
        if let values = aggregatedData[day] {
            return (day: day, managedTics: values.managedTics, notManagedTics: values.notManagedTics)
        } else {
            return (day: day, managedTics: 0, notManagedTics: 0)
        }
    }
}

func shorten(_ date: Date?) -> Date? {
    var calendar = Calendar.current
    calendar.timeZone = TimeZone(secondsFromGMT: 0)!
    if let date = date {
        print(calendar.date(bySettingHour: 0, minute: 0, second: 0, of: date) ?? "nil")
        print("sep")
        return calendar.date(bySettingHour: 0, minute: 0, second: 0, of: date)
    }
    print("nil")
    return nil
}
