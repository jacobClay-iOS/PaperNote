//
//  TaskCollectionVM.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/2/22.
//

import SwiftUI

class TaskCollectionVM: ObservableObject {
    @Published var collectionOfLists: [TaskList] = []
    @Published var newListTitle = ""
    @Published var isShowingListTitleField = false
    
    @Published var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.45
    @Published var currentDragOffsetY: CGFloat = 0
    @Published var hiddenOffsetY: CGFloat = 0
    
    init() {
        loadSampleCollection()
    }
    
    
    func addListToCollection(_ list: TaskList) {
        collectionOfLists.append(list)
    }
    
    func deleteListFromCollection(_ list: TaskList) {
        guard let index = collectionOfLists.firstIndex(where: { $0.id == list.id }) else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.collectionOfLists.remove(at: index)
        }
    }

    func loadSampleCollection() {
        collectionOfLists.append(contentsOf: sampleCollection)
    }
    
    let sampleCollection: [TaskList] =
    [
        TaskList(name: "Grocery List",
                 list: [
                    TaskItem(name: "cereal", isTaskCompleted: true, note: ""),
                    TaskItem(name: "juice", isTaskCompleted: true, note: ""),
                    TaskItem(name: "bread", isTaskCompleted: true, note: "")
                 ],
                 totalTaskCount: 3,
                 completedTaskCount: 3,
                 customAccentColor: .mint
        ),
        TaskList(name: "To-do List",
                 list: [
                    TaskItem(name: "plan my day", isTaskCompleted: false, note: ""),
                    TaskItem(name: "get things done!", isTaskCompleted: false, note: ""),
                    TaskItem(name: "download PaperNote", isTaskCompleted: true, note: "on iPhone, iPad, and Mac", priority: .high)
                 ],
                 totalTaskCount: 3,
                 completedTaskCount: 1,
                 customAccentColor: .indigo
        )
    ]
}
