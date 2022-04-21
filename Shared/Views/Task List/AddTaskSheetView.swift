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
    @State private var currentDragOffsetY: CGFloat = 0
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 15) {
                header
                    .padding(.horizontal, 4)
                
                textFields
                
                addTaskSheetToolBar
            }
            .padding(.horizontal)
            .padding(.bottom)
            .background(Color("Surface"))
            .customCornerRadius(25, corners: [.topLeft, .topRight])
            .shadow(color: Color("OuterGlare"), radius: 0.5, y: -1)
            .shadow(color: Color("OuterGlare"), radius: 0.5, y: -1)
            .shadow(color: Color("OuterGlare"), radius: 0.5, y: -1)
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .task {
            DispatchQueue.main.async {
                taskFieldFocus = true
            }
        }
        .offset(y: currentDragOffsetY)
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation(.spring()) {
                        currentDragOffsetY = value.translation.height
                    }
                }
                .onEnded{ value in
                    withAnimation(.spring()) {
                        if currentDragOffsetY > 40 {
                            withAnimation {
                                taskFieldFocus = false
                                taskListVM.dismissAllSheets()
                            }
                        }
                        currentDragOffsetY = 0
                    }
                }
        )
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
        VStack {
            DragGestureTab()
            HStack {
                Text(taskListVM.isShowingEditTaskSheet ? "Edit Task" : "Add task")
                    .customFontHeadline()
                    .foregroundColor(.primary)

                Spacer()
            }
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
                .frame(height: 100)
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
                    .foregroundColor(taskListVM.taskName.isEmpty ? .secondary : taskListVM.initializedTaskList.customAccentColor)
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
