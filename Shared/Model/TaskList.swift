//
//  TaskList.swift
//  PaperNote
//
//  Created by Jacob Clay on 2/19/22.
//

import SwiftUI


struct TaskList: Identifiable {
    var id = UUID().uuidString
    var name: String
    var list: [TaskItem]
    var totalTaskCount: Double = 0
    var completedTaskCount: Double = 0
    var date: Date = .now
    
    static var sampleData: [TaskItem] =
    [
        TaskItem(name: "sample task 1"),
        TaskItem(name: "sample task 2"),
        TaskItem(name: "sample task 3")
    ]
}
