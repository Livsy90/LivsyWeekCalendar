//
//  WeekProvider.swift
//
//
//  Created by Livsy on 19.08.2024.
//

import Foundation
import Observation

@Observable
final class WeekProvider {
    
    private(set) var weekDict: [WeekPosition: Week] = [:]
    private var referenceDate: Date = .now {
        didSet {
            configureWeeks()
        }
    }
    
    init() {
        configureWeeks()
    }
    
    func setDate(_ date: Date) {
        referenceDate = date.startOfTheDay
    }
    
    func update(by position: WeekPosition) {
        referenceDate = referenceDate.sameDay(at: position)
    }
    
    private func configureWeeks() {
        weekDict = Dictionary(uniqueKeysWithValues: WeekPosition.allCases.map { ($0, .week(for: referenceDate, at: $0)) })
    }
    
}
