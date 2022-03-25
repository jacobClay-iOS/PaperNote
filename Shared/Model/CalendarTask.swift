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

// sample tasks
var tasks: [TaskMetaData] = [

    TaskMetaData(task: [
        CalendarTask(title: "Create calendar"),
        CalendarTask(title: "put that shit in PaperNote"),
        CalendarTask(title: "Make Bank")
    ], taskDate: getSampleDate(offset: 1)),
    
    TaskMetaData(task: [
        CalendarTask(title: "fugg yo bish"),
    ], taskDate: getSampleDate(offset: -3)),
    
    TaskMetaData(task: [
        CalendarTask(title: "wash my balls"),
    ], taskDate: getSampleDate(offset: -8)),
    
    TaskMetaData(task: [
        CalendarTask(title: "eat food"),
    ], taskDate: getSampleDate(offset: 10)),
    
    TaskMetaData(task: [
        CalendarTask(title: "wash my car"),
    ], taskDate: getSampleDate(offset: 15)),
    
    TaskMetaData(task: [
        CalendarTask(title: "wash my face"),
    ], taskDate: getSampleDate(offset: -20)),
]
