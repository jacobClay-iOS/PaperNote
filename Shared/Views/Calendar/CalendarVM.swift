//
//  CalendarVM.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/26/22.
//

import SwiftUI


class CalendarVm: ObservableObject {
    @Published var userSelectedDate: Date = Date()
    @Published var userSelectedMonth: Int = 0
    @Published var currentDay: Date = Date()
    @Published var highlightedDay: Date = Date()
    
    @Published var isShowingAddEventView = false
    
    @Published var totalCollectionOfEvents: [EachDayEventCollection] = [
        EachDayEventCollection(todaysEvents: [CalendarEvent(title: "Sample event", date: Date.now)],
                               date: Date.now)
    
    ]

    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }

    func isDateToday(_: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(highlightedDay)
    }

    func isDateTomorrow(_: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInTomorrow(highlightedDay)
    }

    func isDateYesterday(_: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInYesterday(highlightedDay)
    }
    
    func isMonthNotInCurrentYear() -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        let currentYearNumber = formatter.string(from: Date.now)
        let userSelectedYearNumber = formatter.string(from: userSelectedDate)
        return currentYearNumber != userSelectedYearNumber
    }
    
    func displaySelectedMonthAndYear() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: userSelectedDate)
        
        return date.components(separatedBy: " ")
    }
    
    func displaySelectedDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE,  MMMM  d"
        
        let date = formatter.string(from: highlightedDay)
        
        return date.description
    }
    // working here
    func displayEventTime(event: CalendarEvent) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let date = formatter.string(from: event.date)
        return date.description
    }

    func getCurrentMonth() -> Date {
        let calendar = Calendar.current

        guard let currentMonth = calendar.date(byAdding: .month, value: self.userSelectedMonth, to: currentDay.startOfMonth())
        else {
            return Date()
        }
        return currentMonth
    }

    func populateCalendarWithDates()->[CalendarDate] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        var days = currentMonth.getAllDates().compactMap { date -> CalendarDate in
            
            let day = calendar.component(.day, from: date)
            
            return CalendarDate(day: day, date: date)
        }

        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(CalendarDate(day: -1, date: Date()), at: 0)
        }
        return days
    }
    
    func addEventToCollectionOfEvents(_ event: EachDayEventCollection) {
        totalCollectionOfEvents.append(event)
    }
    
    
    func resetCalendar() {
        userSelectedMonth = 0
        currentDay = Date()
        highlightedDay = currentDay
    }
    
    func refreshCurrentDate() {
        currentDay = Date()
    }
}

