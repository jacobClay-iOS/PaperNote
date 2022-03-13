//
//  AddTaskSheetView.swift
//  PaperNote
//
//  Created by Jacob Clay on 2/21/22.
//

import SwiftUI

struct AddTaskSheetView: View {
    @Binding var isShowingAddNewTaskSheet: Bool
    @Binding var isShowingEditTaskSheet: Bool
    @EnvironmentObject var taskListVM: TaskListVM
    @FocusState private var taskFieldFocus
    

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 25) {
                header
                    .padding(.horizontal, 10)
                
                textFields
        
                addTaskSheetToolBar
            }
            .padding()
            .background(
                LinearGradient(
                    colors: [Color("BackgroundTop"), Color("BackgroundBottom")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .shadow(color: Color("OuterGlare"), radius: 2, x: -2, y: -4)
            )
        }
        .ignoresSafeArea(.container, edges: .horizontal)
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                taskFieldFocus = true
            }
        }
    }
    
    
}

extension AddTaskSheetView {
    
// MARK: Functions
    func updateTask() {
        let task = TaskItem(
            id: taskListVM.taskID,
            name: taskListVM.taskName,
            isTaskCompleted: taskListVM.isTaskCompleted,
            note: taskListVM.taskNoteName
        )
        taskListVM.updateTask(task)
        taskListVM.isShowingEditTaskSheet = false
        taskListVM.resetAddTaskSheetProperties()
    }
    
    func addTask() {
        let task = TaskItem(name: taskListVM.taskName, note: taskListVM.taskNoteName)
        taskListVM.addTaskToList(task)
        taskListVM.isShowingAddNewTaskSheet = false
        taskListVM.resetAddTaskSheetProperties()
    }
    
// MARK: Components
    private var header: some View {
        HStack {
            Spacer()
            Text(taskListVM.isShowingEditTaskSheet ? "Edit Task" : "Add task")
                .customFontHeadline()
                .foregroundColor(.primary)
                .padding(.leading)
                .padding(.leading, 4)
            Spacer()
            Button {
                withAnimation {
                    taskFieldFocus = false
                    taskListVM.isShowingEditTaskSheet = false
                    taskListVM.isShowingAddNewTaskSheet = false
                    taskListVM.resetAddTaskSheetProperties()
                }
                
            } label: {
                Image(systemName: "xmark")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    
            }
            .buttonStyle(.plain)
        }
    }
    
    private var textFields: some View {
        VStack(spacing: 25) {
            SunkenTextField(textField: TextField("task", text: $taskListVM.taskName))
                .focused($taskFieldFocus)
                .onSubmit {
                    if !taskListVM.taskName.isEmpty {
                        if taskListVM.isShowingEditTaskSheet {
                            updateTask()
                        } else {
                            addTask()
                        }
                    } else {
                        withAnimation {
                            taskListVM.isShowingEditTaskSheet = false
                            taskListVM.isShowingAddNewTaskSheet = false
                        }
                    }
                }
                .submitLabel(.done)
            
            SunkenTextEditor(textField: TextEditor(text: $taskListVM.taskNoteName), placeHolderText: taskListVM.taskNoteName.isEmpty ? "note" : "")
                .frame(height: 150)
        }
    }
    
    private var addTaskSheetToolBar: some View {
        HStack(spacing: 15) {
            Image(systemName: "repeat")
                .font(.title2)
                .foregroundColor(.secondary)
            
            Button {
                withAnimation {
          
                 
                }
            } label: {
                Image(systemName: "note.text")
                    .font(.title2)
                    .foregroundColor(.secondary)
            }
            .buttonStyle(.plain)
            
            Button {
                withAnimation {
                   
         
                }
            } label: {
                Image(systemName: "point.topleft.down.curvedto.point.bottomright.up")
                    .font(.title2)
                    .foregroundColor(.secondary)
            }
            .buttonStyle(.plain)
            
            Spacer()
            
            Button {
                taskListVM.isShowingEditTaskSheet ? updateTask() : addTask()
            } label: {
                Image(systemName: "checkmark.rectangle.fill")
                    .font(.title)
                    .foregroundColor(taskListVM.taskName.isEmpty ? .secondary : Color("AccentStart"))
            }
            .disabled(taskListVM.taskName.isEmpty)
            .buttonStyle(.plain)
        }
    }
}

//
//struct AddTaskSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTaskSheetView(isShowingAddTaskSheet: .constant(true))
//            .environmentObject(TaskListVM((TaskList.init(id: "1", name: "Grocery List", list: [TaskItem(name: "Melons", note: "")], totalTaskCount: 1, completedTaskCount: 0))))
//
//    }
//}
