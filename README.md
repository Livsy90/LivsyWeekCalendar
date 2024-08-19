# SwiftUI customizable Week Calendar View

<img src="https://github.com/Livsy90/LivsyWeekCalendar/blob/main/SimulatorScreenRecording-iPhone15.gif" width="300">

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/Livsy90/LivsyWeekCalendar.git")
]
```

## Example 

```swift
struct ContentView: View {
    @State var selectedDay: Date = .now
    
    var body: some View {
        WeekCalendarView<WeekView>(selectedDay: $selectedDay) // Default WeekView
        
        WeekCalendarView { week in // Custom content
            Text(week.referenceDate.formatted())
        }
    }
}
```
