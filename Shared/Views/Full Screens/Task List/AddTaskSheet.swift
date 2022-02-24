//
//  AddTaskSheet.swift
//  PaperNote
//
//  Created by Jacob Clay on 2/21/22.
//

import SwiftUI

struct AddTaskSheet: View {
    @Binding var isShowingAddTaskSheet: Bool
    @ObservedObject var AddTaskSheetVM: AddTaskSheetVM
    @EnvironmentObject var TaskListVM: TaskListVM
    @FocusState private var todoFieldFocus: activeField?
    
    enum activeField {
        case primaryTask
        case notesTextEditor
    }

    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(LinearGradient(colors: [Color("BackgroundTop"), Color("BackgroundBottom")], startPoint: .topLeading, endPoint: .bottomTrailing))
                .shadow(color: Color("OuterGlare"), radius: 2, x: -2, y: -4)
            VStack(spacing: 25) {
                HStack {
                    Spacer()
                    Text("Add task")
                        .customFontHeadline()
                        .foregroundColor(.primary)
                        .padding(.leading)
                    Spacer()
                    Button {
                        withAnimation {
                            isShowingAddTaskSheet.toggle()
                        }
                        
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 10)
                SunkenTextField(textField: TextField("task", text: $AddTaskSheetVM.taskName))
                    .focused($todoFieldFocus, equals: .primaryTask)
                    .onSubmit {
                        if AddTaskSheetVM.updating {
                            updateTask()
                        } else {
                            addTask()
                        }
                    }
                    .submitLabel(.done)
                
                SunkenTextEditor(textField: TextEditor(text: $AddTaskSheetVM.taskNoteName), placeHolderText: AddTaskSheetVM.taskNoteName.isEmpty ? "note" : "")
                    .frame(height: 150)
                
                toolBar
                Spacer()
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.bottom)
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                todoFieldFocus = .primaryTask
            }
        }
    }
    
    var toolBar: some View {
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
                AddTaskSheetVM.updating ? updateTask() : addTask()
            } label: {
                Image(systemName: "checkmark.rectangle.fill")
                    .font(.title)
                    .foregroundColor(AddTaskSheetVM.isDisabled ? .secondary : Color("AccentStart"))
            }
            .disabled(AddTaskSheetVM.isDisabled)
            .buttonStyle(.plain)
        }
    }
}

extension AddTaskSheet {
    func updateTask() {
        let task = TaskItem(
            id: AddTaskSheetVM.id!,
            name: AddTaskSheetVM.taskName,
            isTaskCompleted: AddTaskSheetVM.isTaskCompleted,
            note: AddTaskSheetVM.taskNoteName
        )
        TaskListVM.updateTask(task)
        isShowingAddTaskSheet = false
        
    }
    
    func addTask() {
        let task = TaskItem(name: AddTaskSheetVM.taskName, note: AddTaskSheetVM.taskNoteName)
        TaskListVM.addTaskToList(task)
        isShowingAddTaskSheet = false
    }
}


struct AddTaskSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskSheet(isShowingAddTaskSheet: .constant(true), AddTaskSheetVM: AddTaskSheetVM())
            .environmentObject(TaskListVM())

    }
}
