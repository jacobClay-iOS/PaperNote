//
//  DateValue.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/24/22.
//

import SwiftUI

struct CalendarDate: Identifiable {
    let id = UUID().uuidString
    let day: Int
    let date: Date
//    var events: [CalendarEvent] = []
//
//    init(id: String = UUID().uuidString, day: Int, date: Date, events: [CalendarEvent] = []) {
//        self.id = id
//        self.day = day
//        self.date = date
//        self.events = events
//    }
//
//    mutating func addEventToDate(event: CalendarEvent) {
//        self.events.append(event)
//    }
}
