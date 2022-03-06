//
//  TaskCollectionVM.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/2/22.
//

import Foundation

class TaskCollectionVM: ObservableObject {
    @Published var collectionOfLists: [TaskList] = []
    @Published var newListTitle = ""
    @Published var isShowingListTitleField = false
    
    init() {
        loadSampleCollection()
    }
    
    
    func addListToCollection(_ list: TaskList) {
        collectionOfLists.append(list)
    }

    func loadSampleCollection() {
        collectionOfLists.append(contentsOf: sampleCollection)
    }
    
    let sampleCollection: [TaskList] =
    [
        TaskList(name: "Grocery List 1", list: [TaskItem(name: "eggs", note: "2 dozen")], totalTaskCount: 1, completedTaskCount: 0),
        TaskList(name: "Task List 1", list: [TaskItem(name: "wash car", note: "twice")], totalTaskCount: 1, completedTaskCount: 0)
    ]
}
