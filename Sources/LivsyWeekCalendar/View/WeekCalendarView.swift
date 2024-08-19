//
//  WeekCalendarView.swift
//
//
//  Created by Livsy on 19.08.2024.
//

import SwiftUI
import Foundation

public struct WeekCalendarView<Content: View>: View {
    
    @Binding var selectedDay: Date
    
    private let accentCircleColor: Color
    private let accentTextColor: Color
    private let defaultTextColor: Color
    private let font: Font
    private let circleHeight: CGFloat
    
    @State private var provider: WeekProvider = .init()
    @State private var activeTab: WeekPosition = .middle
    @State private var scrollDirection: WeekPosition = .middle
    
    private var customWeekView: ((_ week: Week) -> Content)?
    
    public init(
        accentCircleColor: Color = .blue,
        accentTextColor: Color = .white,
        defaultTextColor: Color = .primary,
        font: Font = .system(size: 20, weight: .semibold),
        circleHeight: CGFloat = 45,
        selectedDay: Binding<Date> = .constant(.now)
    ) {
        self.accentCircleColor = accentCircleColor
        self.accentTextColor = accentTextColor
        self.defaultTextColor = defaultTextColor
        self.font = font
        self.circleHeight = circleHeight
        _selectedDay = selectedDay
        customWeekView = nil
    }
    
    public init(@ViewBuilder customContent: @escaping (_ week: Week) -> Content) {
        self.init()
        self.customWeekView = customContent
    }
    
    public var body: some View {
        TabView(selection: $activeTab) {
            ForEach(WeekPosition.allCases) { position in
                weekView(for: provider.weekDict[position, default: .default])
                    .tag(position)
                    .frame(maxWidth: .infinity)
                    .onDisappear {
                        guard position == .middle, scrollDirection != .middle else { return }
                        provider.update(by: scrollDirection)
                        scrollDirection = .middle
                        activeTab = .middle
                    }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onChange(of: activeTab) { _, newValue in
            switch newValue {
            case .left, .right:
                scrollDirection = newValue
            case .middle:
                break
            }
        }
        .onChange(of: selectedDay) { _, newValue in
            provider.setDate(newValue)
        }
    }
    
    @ViewBuilder
    private func weekView(for week: Week) -> some View {
        if let customWeekView {
            customWeekView(week)
        } else {
            WeekView(
                week: week,
                selectedDay: $selectedDay,
                accentCircleColor: accentCircleColor,
                accentTextColor: accentTextColor,
                defaultTextColor: defaultTextColor,
                font: font,
                circleHeight: circleHeight
            )
        }
    }
    
}

