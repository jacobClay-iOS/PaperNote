//
//  ListItem.swift
//  PaperNote
//
//  Created by Jacob Clay on 2/20/22.
//

import SwiftUI

struct ListItem: View {
    var listItem: TaskItem
    @EnvironmentObject var taskListVM: TaskListVM
    //    @State private var sheetType: SheetType? = nil
    @State var isShowingNote = false
    
    var body: some View {
        if listItem.isTaskCompleted {
            VStack(alignment: .leading) {
                primaryTaskListItemCompletedView
                
                if !listItem.note.isEmpty && isShowingNote {
                    taskNoteCompletedView
                }
            }
            //            .sheet(item: $sheetType) { $0 }
        } else {
            VStack(alignment: .leading) {
                primaryTaskListItemNotCompletedView
                
                if !listItem.note.isEmpty && isShowingNote {
                    taskNoteNotCompletedView
                }
            }
            //            .sheet(item: $sheetType) { $0 }
        }
    }
    
    
    var primaryTaskListItemNotCompletedView: some View {
        HStack(spacing: 20) {
            Button {
                withAnimation {
                    taskListVM.completeTask(listItem)
                    taskListVM.moveTaskEndOfArray(listItem)
                    
                }
            } label: { primaryTaskNotCompletedButtonLabel }
            .buttonStyle(.plain)
            
            Button {
                //                sheetType = .updateTask(listItem)
                
            }
        label: {
            Text(listItem.name)
                .customFontBodyRegular()
                .foregroundColor(.primary)
        }
        .buttonStyle(.plain)
            
            
            if !listItem.note.isEmpty {
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
            }
        }
    }
    
    var primaryTaskListItemCompletedView: some View {
        HStack(spacing: 20) {
            Button {
                withAnimation {
                    taskListVM.unCompleteTask(listItem)
                    taskListVM.moveTaskStartOfArray(listItem)
                }
            } label: { primaryTaskCompletedButtonLabel }
            .offset(x: 1, y: 0)
            .buttonStyle(.plain)
            
            
            Button {
                //                sheetType = .updateTask(listItem)
                
            }
        label: {
            Text(listItem.name)
                .customFontBodyRegularStrikethrough()
            
        }
        .buttonStyle(.plain)
            
            
            if !listItem.note.isEmpty {
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
            }
        }
    }
    
    var primaryTaskCompletedButtonLabel: some View {
        Image(systemName: "circlebadge.fill")
            .font(.body)
            .foregroundColor(Color ("AccentStart"))
            .padding(5)
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
                            .blur(radius: 4)
                            .offset(x: -2, y: -2)
                            .mask(
                                Circle()
                                    .fill(LinearGradient(colors: [Color.black, Color.clear], startPoint: .topLeading, endPoint: .bottomTrailing))
                            )
                    )
            )
    }
    
    var primaryTaskNotCompletedButtonLabel: some View {
        Image(systemName: "circlebadge")
            .font(.body)
            .foregroundColor(Color ("AccentStart"))
            .padding(5)
            .background(
                Circle()
                    .foregroundColor(Color("Surface"))
                    .shadow(color: Color("OuterShadow"), radius: 2, x: 2, y: 2)
                    .shadow(color: Color("OuterGlare"), radius: 1, x: -2, y: -2)
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
            .padding(.horizontal, 48)
        
    }
}
