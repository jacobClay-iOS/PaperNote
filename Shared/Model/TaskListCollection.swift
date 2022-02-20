//
//  TaskListCollection.swift
//  PaperNote
//
//  Created by Jacob Clay on 2/19/22.
//

import SwiftUI

struct TaskListCollection {
 
    var collection: [TaskList]
    var collectionCount: Double = 0
    
    static var sampleData: [TaskList] =
    [
        TaskList(
            name: "List 1",
            list: [TaskItem(name: "sample task 1"),
                   TaskItem(name: "sample task 2"),
                   TaskItem(name: "sample task 3")],
            totalTaskCount: 3,
            completedTaskCount: 0),
        TaskList(
            name: "List 2",
            list: [TaskItem(name: "sample task 1"),
                   TaskItem(name: "sample task 2"),
                   TaskItem(name: "sample task 3")],
            totalTaskCount: 3,
            completedTaskCount: 0),
        TaskList(
            name: "List 3",
            list: [TaskItem(name: "sample task 1"),
                   TaskItem(name: "sample task 2"),
                   TaskItem(name: "sample task 3")],
            totalTaskCount: 3,
            completedTaskCount: 0),
    ]
    
}
