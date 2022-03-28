//
//  ListItemView.swift
//  PaperNote
//
//  Created by Jacob Clay on 2/20/22.
//

import SwiftUI

struct ListItemView: View {
    var listItem: TaskItem
    @EnvironmentObject var taskListVM: TaskListVM
    @State private var isShowingNote = false
    @State private var isShowingActionSheet = false
    
    var body: some View {
        if listItem.isTaskCompleted {
            VStack(alignment: .leading, spacing: 6) {
                primaryTaskListItemCompletedView
                
                if !listItem.note.isEmpty && isShowingNote {
                    taskNoteCompletedView
                }
            }
        } else {
            VStack(alignment: .leading, spacing: 6) {
                primaryTaskListItemNotCompletedView
                
                if !listItem.note.isEmpty && isShowingNote {
                    taskNoteNotCompletedView
                }
            }
        }
    }
}

extension ListItemView {
    
    var primaryTaskListItemNotCompletedView: some View {
        HStack(spacing: 20) {
            VStack {
                Button {
                    withAnimation {
                        taskListVM.completeTask(listItem)
                        taskListVM.moveTaskEndOfArray(listItem)
                    }
                } label: { primaryTaskNotCompletedButtonLabel }
                .buttonStyle(.plain)
                .offset(y: 4)
                Spacer()
            }
            
            Button {
                isShowingActionSheet.toggle()
            }
        label: {
            Text(listItem.name)
                .customFontBodyRegular()
                .foregroundColor(.primary)
        }
        .buttonStyle(.plain)
        .confirmationDialog("Task options", isPresented: $isShowingActionSheet, actions: {
            Button("Complete") {
                withAnimation {
                    taskListVM.completeTask(listItem)
                    taskListVM.moveTaskEndOfArray(listItem)
                }
            }
            Button("Edit") {
                withAnimation {
                    taskListVM.grabAndApplyTaskProperties(listItem)
                    taskListVM.isShowingEditTaskSheet.toggle()
                }
            }
            Button("Delete", role: .destructive) {
                withAnimation {
                    taskListVM.deleteTask(listItem)
                }
            }
        }, message: {
            Text(listItem.name)
        })
            
            if !listItem.note.isEmpty {
                VStack {
                    Button {
                        withAnimation {
                            isShowingNote.toggle()
                        }
                    } label: {
                        Image(systemName: isShowingNote ? "chevron.up" : "chevron.down")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .buttonStyle(.plain)
                    .offset(y: 11)
                    Spacer()
                }
            }
        }
    }
    
    var primaryTaskListItemCompletedView: some View {
        HStack(spacing: 20) {
            VStack {
                Button {
                    withAnimation {
                        taskListVM.unCompleteTask(listItem)
                        taskListVM.moveTaskStartOfArray(listItem)
                    }
                } label: { primaryTaskCompletedButtonLabel }
                .offset(x: 1, y: 0)
                .buttonStyle(.plain)
                .offset(y: 4)
                Spacer()
            }
            
            Button {
                isShowingActionSheet.toggle()
            }
        label: {
            Text(listItem.name)
                .customFontBodyRegular()
                .foregroundColor(.secondary)
        }
        .buttonStyle(.plain)
        .confirmationDialog("Task options", isPresented: $isShowingActionSheet, actions: {
            Button("Unmark") {
                withAnimation {
                    taskListVM.unCompleteTask(listItem)
                    taskListVM.moveTaskStartOfArray(listItem)
                }
            }
            Button("Edit") {
                withAnimation {
                    taskListVM.grabAndApplyTaskProperties(listItem)
                    taskListVM.isShowingEditTaskSheet.toggle()
                }
            }
            Button("Delete", role: .destructive) {
                withAnimation {
                    taskListVM.deleteTask(listItem)
                }
            }
        }, message: {
            Text(listItem.name)
        })
            
            if !listItem.note.isEmpty {
                VStack {
                    Button {
                        withAnimation {
                            isShowingNote.toggle()
                        }
                    } label: {
                        Image(systemName: isShowingNote ? "chevron.up" : "chevron.down")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .buttonStyle(.plain)
                    .offset(y: 11)
                    Spacer()
                }
            }
        }
    }
    
    var primaryTaskCompletedButtonLabel: some View {
        Image(systemName: "circlebadge.fill")
            .font(.body)
            .foregroundColor(taskListVM.initializedTaskList.customAccentColor)
            .padding(6)
            .background(
                Circle()
                    .foregroundColor(Color("Surface"))
                    .overlay(
                        Circle()
                            .stroke(Color("OuterGlare"), lineWidth: 4)
                            .blur(radius: 4)
                            .offset(x: 2, y: 2)
                            .mask(
                                Circle()
                                    .fill(LinearGradient(colors: [Color.clear, Color("OuterGlare")], startPoint: .topLeading, endPoint: .bottomTrailing))
                            )
                    )
                    .overlay(
                        Circle()
                            .stroke(Color("InnerShadow"), lineWidth: 4)
                            .blur(radius: 6)
                            .offset(x: -2, y: -2)
                            .mask(
                                Circle()
                                    .fill(LinearGradient(colors: [Color.black, Color.clear], startPoint: .topLeading, endPoint: .bottomTrailing))
                            )
                    )
                    .overlay(
                        Circle()
                            .stroke( LinearGradient(gradient: Gradient(stops: [
                                Gradient.Stop(color: Color("OuterGlare"), location: 0.4),
                                Gradient.Stop(color: Color("Surface"), location: 0.6),
                            ]), startPoint: .bottomTrailing, endPoint: .topLeading), lineWidth: 1.5)
                )
            )
    }
    
    var primaryTaskNotCompletedButtonLabel: some View {
        Image(systemName: "circlebadge")
            .font(.body)
            .foregroundColor(taskListVM.initializedTaskList.customAccentColor)
            .padding(6)
            .background(
                Circle()
                    .foregroundColor(Color("Surface"))
                    .shadow(color: Color("OuterGlare"), radius: 0.5, x: -1, y: -1)
                    .shadow(color: Color("OuterGlare"), radius: 0.5, x: -1, y: -1)
                    .shadow(color: Color("OuterShadow"), radius: 2, x: 1, y: 2)
                    .overlay(
                        Circle()
                            .stroke( LinearGradient(gradient: Gradient(stops: [
                                Gradient.Stop(color: Color("OuterGlare"), location: 0.4),
                                Gradient.Stop(color: Color("Surface"), location: 0.6),
                            ]), startPoint: .topLeading, endPoint: .bottom), lineWidth: 1)
                )
            )
    }
    
    var taskNoteCompletedView: some View {
        Text(listItem.note)
            .customFontCaptionRegular()
            .foregroundColor(.secondary)
            .padding(.horizontal, 48)
        
    }
    
    var taskNoteNotCompletedView: some View {
        Text(listItem.note)
            .customFontCaptionRegular()
            .foregroundColor(.primary)
            .padding(.horizontal, 48)
        
    }
}
