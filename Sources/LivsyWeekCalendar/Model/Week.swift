//
//  Week.swift
//  
//
//  Created by Livsy on 19.08.2024.
//

import Foundation

public struct Week {
    public let dates: [Date]
    public let referenceDate: Date
    
    public static let `default`: Self = Week.week(for: .now, at: .middle)
    
    public init(dates: [Date], referenceDate: Date) {
        self.dates = dates
        self.referenceDate = referenceDate
    }
    
    public static func week(
        for date: Date,
        at position: WeekPosition
    ) -> Self {
        let date = date.sameDay(at: position)
        let startOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))
        let weekDates = (0...6).compactMap {
            Calendar.current.date(
                byAdding: .day,
                value: $0,
                to: startOfWeek ?? .now
            )
        }
        
        return Week(
            dates: weekDates,
            referenceDate: date
        )
    }
    
}
