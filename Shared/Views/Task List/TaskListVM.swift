//
//  TaskListVM.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/2/22.
//

import Foundation

class TaskListVM: ObservableObject {
    @Published var initializedTaskList = TaskList()
//    @Published var taskList: [TaskItem] = []
//    @Published var title = ""
//    @Published var totalTasks: Double = 0
//    @Published var completedTasks: Double = 0
    @Published var isListExpanded = false
    @Published var isShowingAddNewTaskSheet = false
//    var collectionListItem: TaskList
//
//
//
//    init(_ list: TaskList) {
//        self.collectionListItem = list
//        self.taskList = list.list
//        self.title = list.name
//        self.totalTasks = list.totalTaskCount
//        self.completedTasks = list.completedTaskCount
//    }

    
    
    func addTaskToList(_ task: TaskItem) {
        if initializedTaskList.list.isEmpty {
            initializedTaskList.list.insert(task, at: initializedTaskList.list.startIndex)
            initializedTaskList.totalTaskCount += 1.0
        } else if initializedTaskList.completedTaskCount == 0.0 {
            initializedTaskList.list.insert(task, at: initializedTaskList.list.endIndex)
            initializedTaskList.totalTaskCount += 1.0
        } else {
            var j = 0
            while (!initializedTaskList.list[j].isTaskCompleted) {
                j += 1
            }
            initializedTaskList.list.insert(task, at: j)
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
}
