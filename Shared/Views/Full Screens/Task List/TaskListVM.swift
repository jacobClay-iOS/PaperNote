//
//  TaskListVM.swift
//  PaperNote
//
//  Created by Jacob Clay on 2/19/22.
//

import SwiftUI

class TaskListVM: ObservableObject {
    
    @Published var taskList: [TaskItem] = []
    @Published var totalTasks: Double = 0
    @Published var completedTasks: Double = 0
    @Published var listTitle = "Title"
    
    
    init() {}
    
    
    func addTaskToList(_ task: TaskItem) {
        if taskList.isEmpty {
            taskList.insert(task, at: taskList.startIndex)
            totalTasks += 1.0
        } else if completedTasks == 0.0 {
            taskList.insert(task, at: taskList.endIndex)
            totalTasks += 1.0
        } else {
            var j = 0
            while (!taskList[j].isTaskCompleted) {
                j += 1
            }
            taskList.insert(task, at: j)
            totalTasks += 1.0
            
        }
    }
    
    
    func updateTask(_ task: TaskItem) {
        guard let index = taskList.firstIndex(where: { $0.id == task.id }) else { return }
        taskList[index] = task
        if task.isTaskCompleted {
            unCompleteTask(task)
            moveTaskStartOfArray(task)
        }
    }
    
    func deleteTask(_ task: TaskItem) {
        guard let index = taskList.firstIndex(where: { $0.id == task.id }) else { return }
        taskList.remove(at: index)
        totalTasks -= 1
        if (completedTasks != 0) && (task.isTaskCompleted) {
            completedTasks -= 1
        }
    }
    
    func clearTaskList() {
        taskList.removeAll()
    }
    
    func resetTaskListCounters() {
        totalTasks = 0.0
        completedTasks = 0.0
    }
    
    func completeTask(_ task: TaskItem) {
        guard let index = taskList.firstIndex(where: { $0.id == task.id }) else { return }
        taskList[index].isTaskCompleted = true
        completedTasks += 1
    }
    
    func unCompleteTask(_ task: TaskItem) {
        guard let index = taskList.firstIndex(where: { $0.id == task.id }) else { return }
        taskList[index].isTaskCompleted = false
        completedTasks -= 1
    }
    
    func moveTaskEndOfArray(_ task: TaskItem) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            guard let index = self.taskList.firstIndex(where: { $0.id == task.id }) else { return }
            let removedElement = self.taskList.remove(at: index)
            self.taskList.append(removedElement)
        }
    }
    
    func moveTaskStartOfArray(_ task: TaskItem) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            guard let index = self.taskList.firstIndex(where: { $0.id == task.id }) else { return }
            let removedElement = self.taskList.remove(at: index)
            self.taskList.insert(removedElement, at: self.taskList.startIndex)
        }
    }
}
