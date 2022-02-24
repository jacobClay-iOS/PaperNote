//
//  AddTaskSheetVM.swift
//  PaperNote
//
//  Created by Jacob Clay on 2/21/22.
//

import SwiftUI

class AddTaskSheetVM: ObservableObject {
    
    @Published var taskName = ""
    @Published var taskNoteName = ""
    @Published var isTaskCompleted = false
    var id: String?
    
    var updating: Bool {
        id != nil
    }
    
    var isDisabled: Bool {
        taskName.isEmpty
    }
    
    init() {}

    init(_ currentTask: TaskItem) {
        self.taskName = currentTask.name
        self.isTaskCompleted = currentTask.isTaskCompleted
        id = currentTask.id
        self.taskNoteName = currentTask.note
    }
}
