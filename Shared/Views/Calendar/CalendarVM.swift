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
    @Published var userSelectedMonth1: Int = 0
    @Published var currentDay1: Date = Date()
    @Published var highlightedDay: Date = Date()
    
    
    
    // checking dates
    func isSameDay1(date1: Date, date2: Date) -> Bool {
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

    // extracting year and month for display
    func extraDate1() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        
        let date = formatter.string(from: userSelectedDate)
        
        return date.components(separatedBy: " ")
    }

    // extracting day for display
    func displayDay() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM"
        
        
        let date = formatter.string(from: highlightedDay)
        
        return date.components(separatedBy: " ")
    }

    func getCurrentMonth1() -> Date {
        let calendar = Calendar.current
        // getting current month date
        guard let currentMonth = calendar.date(byAdding: .month, value: self.userSelectedMonth1, to: Date())
        else {
            return Date()
        }
        return currentMonth
    }


    func extractDate1()->[DateValue] {
        let calendar = Calendar.current
        // getting current month date
        let currentMonth = getCurrentMonth1()
        var days = currentMonth.getAllDates1().compactMap { date -> DateValue in
            
            // getting day
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
}



