//
//  TaskListVM.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/2/22.
//

import SwiftUI

class TaskListVM: ObservableObject {
    
    // task list variables
    @Published var initializedTaskList = TaskList()
    @Published var taskID = ""
    @Published var taskName = ""
    @Published var taskNoteName = ""
    @Published var isTaskCompleted = false
    @Published var taskPriority: TaskPriority = .low
    
    var percentageCompleted: CGFloat {
        1 - (initializedTaskList.completedTaskCount / initializedTaskList.totalTaskCount)
    }
    
    var allTasksCompleted: Bool {
        (percentageCompleted == 0) && (initializedTaskList.totalTaskCount != 0)
    }
    
    
    // navigation variables
    @Published var isListExpanded = false
    @Published var isShowingAddNewTaskSheet = false
    @Published var isShowingEditTaskSheet = false
    @Published var isShowingSettingsSheet = false
    @Published var isShowingDeleteListAlert = false
    @Published var isShowingNoteField = false
    @Published var isShowingTaskPriorityPicker = false

    var isShowingASheet: Bool {
        isShowingSettingsSheet ||
        isShowingAddNewTaskSheet ||
        isShowingEditTaskSheet
    }
    
    var isShowingtaskListNoteField: Bool {
        !taskNoteName.isEmpty || isShowingNoteField 
    }
    
    // task list functions
    func addTaskToList(_ task: TaskItem) {
        if initializedTaskList.list.isEmpty || task.priority == .high {
            initializedTaskList.list.insert(task, at: initializedTaskList.list.startIndex)
            initializedTaskList.totalTaskCount += 1.0
        } else if initializedTaskList.completedTaskCount == 0.0 {
            initializedTaskList.list.insert(task, at: initializedTaskList.list.endIndex)
            initializedTaskList.totalTaskCount += 1.0
        } else {
            var i = 0
            while (!initializedTaskList.list[i].isTaskCompleted) {
                i += 1
            }
            initializedTaskList.list.insert(task, at: i)
            initializedTaskList.totalTaskCount += 1.0
        }
    }
    
    func updateTask(_ task: TaskItem) {
        guard let index = initializedTaskList.list.firstIndex(where: { $0.id == task.id }) else { return }
        initializedTaskList.list[index] = task
        if task.isTaskCompleted {
            unCompleteTask(task)
            moveTaskStartOfArray(task)
        }
    }
    
    func deleteTask(_ task: TaskItem) {
        guard let index = initializedTaskList.list.firstIndex(where: { $0.id == task.id }) else { return }
        initializedTaskList.list.remove(at: index)
        initializedTaskList.totalTaskCount -= 1
        if (initializedTaskList.completedTaskCount != 0) && (task.isTaskCompleted) {
            initializedTaskList.completedTaskCount -= 1
        }
    }
    
    func clearTaskList() {
        initializedTaskList.list.removeAll()
    }
    
    func resetTaskListCounters() {
        initializedTaskList.totalTaskCount = 0.0
        initializedTaskList.completedTaskCount = 0.0
    }
    
    func grabAndApplyTaskProperties(_ task: TaskItem) {
        taskID = task.id
        taskName = task.name
        taskNoteName = task.note
        isTaskCompleted = task.isTaskCompleted
        taskPriority = task.priority
        if !taskNoteName.isEmpty {
            isShowingNoteField = true
        }
    }
    
    func resetAddTaskSheetProperties() {
        taskID = ""
        taskName = ""
        taskNoteName = ""
        taskPriority = .low
        isTaskCompleted = false
        isShowingNoteField = false
        isShowingTaskPriorityPicker = false
    }
    
    func dismissWithoutSavingTask() {
        isShowingEditTaskSheet = false
        isShowingAddNewTaskSheet = false
        isShowingNoteField = false
        isShowingTaskPriorityPicker = false
    }
    
    func completeTask(_ task: TaskItem) {
        guard let index = initializedTaskList.list.firstIndex(where: { $0.id == task.id }) else { return }
        initializedTaskList.list[index].isTaskCompleted = true
        initializedTaskList.completedTaskCount += 1
    }
    
    func unCompleteTask(_ task: TaskItem) {
        guard let index = initializedTaskList.list.firstIndex(where: { $0.id == task.id }) else { return }
        initializedTaskList.list[index].isTaskCompleted = false
        initializedTaskList.completedTaskCount -= 1
    }
    
    func moveTaskEndOfArray(_ task: TaskItem) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            guard let index = self.initializedTaskList.list.firstIndex(where: { $0.id == task.id }) else { return }
            let removedElement = self.initializedTaskList.list.remove(at: index)
            self.initializedTaskList.list.append(removedElement)
        }
    }
    
    func moveTaskStartOfArray(_ task: TaskItem) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            guard let index = self.initializedTaskList.list.firstIndex(where: { $0.id == task.id }) else { return }
            let removedElement = self.initializedTaskList.list.remove(at: index)
            self.initializedTaskList.list.insert(removedElement, at: self.initializedTaskList.list.startIndex)
        }
    }
    
    func dismissAllSheets() {
        if isShowingEditTaskSheet || isShowingAddNewTaskSheet {
            isShowingAddNewTaskSheet = false
            isShowingEditTaskSheet = false
            resetAddTaskSheetProperties()
        } else {
            isShowingSettingsSheet = false
        }
    }
}
