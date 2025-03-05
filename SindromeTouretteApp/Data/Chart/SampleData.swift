//
//  SampleData.swift
//  SindromeTouretteApp
//
//  Created by Gian Marco Taddeo on 05/03/25.
//


import Foundation
import SwiftUI

func generateTouretteDataArray() -> [TouretteData] {
    var dataArray: [TouretteData] = []
    
    let calendar = Calendar.current
    let startDate = calendar.date(from: DateComponents(year: 2024, month: 3, day: 6))!
    let endDate = calendar.date(from: DateComponents(year: 2025, month: 3, day: 5))!
    
    for _ in 1...500 {
        let randomTimeInterval = TimeInterval.random(in: 0...(endDate.timeIntervalSince(startDate)))
        let randomDate = startDate.addingTimeInterval(randomTimeInterval)

        let managedTics = Int.random(in: 0...50)
        let notManagedTics = Int.random(in: 0...50)
        let duration = TimeInterval.random(in: 60...3600)

        let exercise = ExerciseData(
            bodyPart: "Legs",
            exercise: "Jumping Jacks",
            titleExercise: "Cardio Warm-up"
        )
        
        let touretteData = TouretteData(
            date: randomDate,
            duration: duration,
            managedTics: managedTics,
            notManagedTics: notManagedTics,
            exercise: exercise
        )
        
        dataArray.append(touretteData)
    }
    
    return dataArray
}

let sampleData = generateTouretteDataArray()

func getUniqueDates(from touretteDataArray: [TouretteData]) -> [Date] {
    var calendar = Calendar.current
    calendar.timeZone = TimeZone(secondsFromGMT: 0)!
    
    let uniqueDates = Set(touretteDataArray.map {
        calendar.startOfDay(for: $0.realDate)
    })
    
    return Array(uniqueDates).sorted(by: >)
}

let uniqueDatesArray = getUniqueDates(from: sampleData)
