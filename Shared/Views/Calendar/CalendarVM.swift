//
//  CalendarVM.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/26/22.
//

import SwiftUI


class CalendarVm: ObservableObject {
    @Published var userSelectedDate: Date = Date()
    
    // update month with arrow buttons
    @Published var userSelectedMonth: Int = 0
    @Published var currentDay: Date = Date()
    @Published var highlightedDay: Date = Date()
    
    
    
    // checking dates
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }

    func isDateToday(today: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(highlightedDay)
    }

    func isDateTomorrow(tomorrow: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInTomorrow(highlightedDay)
    }

    func isDateYesterday(yesterday: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInYesterday(highlightedDay)
    }
    
    func isMonthNotInCurrentYear(month: Date) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        let currentYearNumber = formatter.string(from: currentDay)
        let userSelectedYearNumber = formatter.string(from: userSelectedDate)
        return currentYearNumber != userSelectedYearNumber
    }
    
    func displaySelectedMonthAndYear() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: userSelectedDate)
        
        return date.components(separatedBy: " ")
    }
    
    func displaySelectedDay() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM"
        
        let date = formatter.string(from: highlightedDay)
        
        return date.components(separatedBy: " ")
    }

    func getCurrentMonth() -> Date {
        let calendar = Calendar.current

        guard let currentMonth = calendar.date(byAdding: .month, value: self.userSelectedMonth, to: Date())
        else {
            return Date()
        }
        return currentMonth
    }

    func populateCalendarWithDates()->[DateValue] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        // adding offset days to get exact week day
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
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



