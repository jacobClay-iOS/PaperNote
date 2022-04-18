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
    var time: Date
}

// total task meta view
struct EventCollection: Identifiable {
    var id = UUID().uuidString
    var collection: [CalendarEvent]
    var date: Date
}

// sample data for testing
//func getSampleDate(offset: Int) -> Date {
//    let calendar = Calendar.current
//    let date = calendar.date(byAdding: .day, value: offset, to: Date())
//    return date ?? Date()
//}

func sampleEvents(year: Int, month: Int, day: Int) -> Date {
    let calendar = Calendar.current
    let event = calendar.date(from: DateComponents(year: year, month: month, day: day))
    return event ?? Date()
}

// sample tasks
var events: [EventCollection] = [

    
    
    EventCollection(collection: [
        CalendarEvent(title: "Sample event", time: Date())
                      ],  date: Date())
    ]
    
