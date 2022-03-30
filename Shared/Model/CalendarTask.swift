//
//  CalendarTask.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/24/22.
//

import SwiftUI

// task model and sample tasks

// array of tasks
struct CalendarTask: Identifiable {
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}

// total task meta view
struct TaskMetaData: Identifiable {
    var id = UUID().uuidString
    var task: [CalendarTask]
    var taskDate: Date
}

// sample data for testing
func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    return date ?? Date()
}

func sampleEvents(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date {
    let calendar = Calendar.current
    let event = calendar.date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute))
    return event ?? Date()
}

// sample tasks
var tasks: [TaskMetaData] = [

    TaskMetaData(task: [
        CalendarTask(title: "Sample event"),
        CalendarTask(title: "Sample event"),
        CalendarTask(title: "Sample event")
    ], taskDate: sampleEvents(year: 2022, month: 3, day: 29, hour: 9, minute: 30)),
    
    TaskMetaData(task: [
        CalendarTask(title: "Sample event"),
    ], taskDate: sampleEvents(year: 2022, month: 3, day: 1, hour: 1, minute: 30)),
    
    TaskMetaData(task: [
        CalendarTask(title: "Sample event"),
    ], taskDate: sampleEvents(year: 2022, month: 3, day: 20, hour: 15, minute: 30)),

    TaskMetaData(task: [
        CalendarTask(title: "Sample event"),
    ], taskDate: sampleEvents(year: 2022, month: 3, day: 17, hour: 20, minute: 30)),

    TaskMetaData(task: [
        CalendarTask(title: "Sample event"),
    ], taskDate: sampleEvents(year: 2022, month: 3, day: 5, hour: 5, minute: 30)),

    TaskMetaData(task: [
        CalendarTask(title: "Sample event"),
    ], taskDate: sampleEvents(year: 2022, month: 3, day: 8, hour: 7, minute: 30)),

    TaskMetaData(task: [
        CalendarTask(title: "Sample event"),
    ], taskDate: sampleEvents(year: 2022, month: 3, day: 23, hour: 9, minute: 30)),
]
