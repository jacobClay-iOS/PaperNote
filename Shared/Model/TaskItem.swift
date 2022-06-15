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
    var note: String
    var priority: TaskPriority = .low
}


enum TaskPriority: String, Equatable, CaseIterable {
    case high = "High"
    case low = "Low"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
