//
//  TaskItem.swift
//  PaperNote
//
//  Created by Jacob Clay on 2/19/22.
//

import SwiftUI

struct TaskItem: Identifiable {
    var id = UUID().uuidString
    var name: String
    var isTaskCompleted: Bool = false
    var date: Date = .now
    var note: String
    var priority: TaskPriority = .med
}


enum TaskPriority: String, Equatable, CaseIterable {
    case low = "Low"
    case med = "Medium"
    case high = "High"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
