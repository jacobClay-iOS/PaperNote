//
//  CalendarTask.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/24/22.
//

import SwiftUI

// task model and sample tasks

// array of tasks
struct CalendarEvent: Identifiable {
    var id = UUID().uuidString
    var title: String
    var note: String?
    var date: Date
    var isAllday = false
    var isRepeating = false
    var isWithAlert = false
}

// total task meta view
struct EachDayEventCollection: Identifiable {
    var id: String {
        date.description.components(separatedBy: " ")[0]
    }
    var todaysEvents: [CalendarEvent]
    var date: Date
}

//struct TotalEventCollection: Identifiable {
//    var id = UUID().uuidString
//    var totalEvents: [EachDayEventCollection]
//}

// sample data for testing
//func getSampleDate(offset: Int) -> Date {
//    let calendar = Calendar.current
//    let date = calendar.date(byAdding: .day, value: offset, to: Date())
//    return date ?? Date()
//}

//func sampleEvents(year: Int, month: Int, day: Int) -> Date {
//    let calendar = Calendar.current
//    let event = calendar.date(from: DateComponents(year: year, month: month, day: day))
//    return event ?? Date()
//}

// sample tasks
var sampleEvents: [EachDayEventCollection] = [

    EachDayEventCollection(todaysEvents:
        [CalendarEvent(title: "Sample event", date: Date())],
         date: Date()),


    EachDayEventCollection(todaysEvents:
        [CalendarEvent(title: "Sample event 2", date: Date())],
         date: Date(timeIntervalSinceNow: (86500 * 2))),


    EachDayEventCollection(todaysEvents:
        [CalendarEvent(title: "Sample event", date: Date())],
         date: Date())

]
    

