//
//  TaskItem.swift
//  PaperNote
//
//  Created by Jacob Clay on 2/19/22.
//

import SwiftUI

struct TaskItem: Identifiable, Codable {
    var id = UUID().uuidString
    var name: String
    var isTaskCompleted: Bool = false
    var date: Date = .now
    var note = ""
}
