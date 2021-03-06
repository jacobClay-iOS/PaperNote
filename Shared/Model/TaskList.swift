//
//  TaskList.swift
//  PaperNote
//
//  Created by Jacob Clay on 2/19/22.
//

import SwiftUI


struct TaskList: Identifiable {
    var id = UUID().uuidString
    var name = "Untitled"
    var list: [TaskItem] = []
    var totalTaskCount: CGFloat = 0
    var completedTaskCount: CGFloat = 0
    var customAccentColor: Color = Color("AccentStart")
    var date: Date = .now
    
//    static var sampleData: [TaskItem] =
//    [
//        TaskItem(name: "sample task 1"),
//        TaskItem(name: "sample task 2"),
//        TaskItem(name: "sample task 3")
//    ]
}
