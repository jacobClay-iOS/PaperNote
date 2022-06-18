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
    @Published var isEventViewExpanded = false
    @Published var isShowingAddEventView = false
    @Published var isShowingCalendarSettings = false
    @Published var totalCollectionOfEvents: [EachDayEventCollection] = [
        EachDayEventCollection(
            todaysEvents:
                [CalendarEvent(title: "Sample event", date: Date.now),
                 CalendarEvent(title: "Sample event", date: Date.now)],
                              
            date: Date.now)
    
    ]
    
    var isShowingASheet: Bool {
        isShowingCalendarSettings || isShowingAddEventView
    }
    
    var hideEventView: Bool {
        !isEventViewExpanded && isShowingAddEventView
    }

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
    
    func gatherWeeklyIntervalDates(startingDate: Date) -> [Date] {
        
        let calendar = Calendar.current
        let daysPerYear: Int = 364
        let years: Int = 10
        let multiplier = daysPerYear * years
        var arrayOfDates: [Date] = []
        
        for num in stride(from: 0, to: multiplier, by: 7) {
            guard let date = calendar.date(byAdding: .day, value: num, to: startingDate) else { return [Date()] }
            arrayOfDates.append(date)
        }
        return arrayOfDates
        
    }
    
    func gatherMonthlyIntervalDates(startingDate: Date) -> [Date] {
        
        let calendar = Calendar.current
        let numberOfMonths: Int = 12
        let years: Int = 10
        let multiplier = numberOfMonths * years
        var arrayOfDates: [Date] = []
        
        for num in 0...multiplier {
            guard let date = calendar.date(byAdding: .month, value: num, to: startingDate) else { return [Date()] }
            arrayOfDates.append(date)
        }
        return arrayOfDates
    }

    func gatherYearlyIntervalDates(startingDate: Date) -> [Date] {
        
        let calendar = Calendar.current
        let numberOfYears: Int = 10
        var arrayOfDates: [Date] = []
        
        for num in 0...numberOfYears {
            guard let date = calendar.date(byAdding: .year, value: num, to: startingDate) else { return [Date()] }
            arrayOfDates.append(date)
        }
        return arrayOfDates
    }

    
    func addEventToCollection(_ event: CalendarEvent) {
        // create collection id from event date for comparison
        let collectionID = event.date.description.components(separatedBy: " ")[0]
        // find if collection for date already exists
        guard let index = totalCollectionOfEvents.firstIndex(where: { $0.id == collectionID }) else {
            // if it doesnt, create collection for that date
            let newEventCollection = EachDayEventCollection(todaysEvents: [event], date: event.date)
            totalCollectionOfEvents.append(newEventCollection)
            return
        }
        // if it does, append event to that collection
        totalCollectionOfEvents[index].todaysEvents.append(event)
       
    }
    
    
    func addEventWithRepeatInterval(_ event: CalendarEvent) {
        switch event.repeatInterval {
        case .week:
            let repeatingEventIdSuffix = UUID().uuidString
            let arrayofDates = gatherWeeklyIntervalDates(startingDate: event.date)
            for date in 0...arrayofDates.count - 1 {
                let newEvent = CalendarEvent(
                    id: event.date.description.components(separatedBy: " ")[0] + repeatingEventIdSuffix,
                    title: event.title,
                    note: event.note,
                    date: arrayofDates[date],
                    isAllday: event.isAllday,
                    isWithAlert: event.isWithAlert,
                    eventType: event.eventType,
                    repeatInterval: event.repeatInterval)
                addEventToCollection(newEvent)
            }
            
        case .month:
            let repeatingEventIdSuffix = UUID().uuidString
            let arrayofDates = gatherMonthlyIntervalDates(startingDate: event.date)
            for date in 0...arrayofDates.count - 1 {
                let newEvent = CalendarEvent(
                    id: event.date.description.components(separatedBy: " ")[0] + repeatingEventIdSuffix,
                    title: event.title,
                    note: event.note,
                    date: arrayofDates[date],
                    isAllday: event.isAllday,
                    isWithAlert: event.isWithAlert,
                    eventType: event.eventType,
                    repeatInterval: event.repeatInterval)
                addEventToCollection(newEvent)
            }
        case .year:
            let repeatingEventIdSuffix = UUID().uuidString
            let arrayofDates = gatherYearlyIntervalDates(startingDate: event.date)
            for date in 0...arrayofDates.count - 1 {
                let newEvent = CalendarEvent(
                    id: event.date.description.components(separatedBy: " ")[0] + repeatingEventIdSuffix,
                    title: event.title,
                    note: event.note,
                    date: arrayofDates[date],
                    isAllday: event.isAllday,
                    isWithAlert: event.isWithAlert,
                    eventType: event.eventType,
                    repeatInterval: event.repeatInterval)
                addEventToCollection(newEvent)
            }
        default:
           addEventToCollection(event)
        }
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

