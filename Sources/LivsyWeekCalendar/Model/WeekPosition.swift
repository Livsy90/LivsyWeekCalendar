//
//  WeekPosition.swift
//  
//
//  Created by Livsy on 19.08.2024.
//

import Foundation

public enum WeekPosition: Int, Identifiable, Hashable, CaseIterable {
    case left = -7
    case middle = 0
    case right = 7
    
    public var id: Int { rawValue }
}
