//
//  TaskListView.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/2/22.
//

import SwiftUI

struct TaskListView: View {
    @StateObject var taskListVM = TaskListVM()
    var list: TaskList
    
    var body: some View {
        ZStack {
            cardListView
            
        }
        .onAppear(perform: {
            taskListVM.initializedTaskList.name = list.name
            taskListVM.initializedTaskList.list = list.list
            taskListVM.initializedTaskList.totalTaskCount = list.totalTaskCount
            taskListVM.initializedTaskList.completedTaskCount = list.completedTaskCount
        })
        .environmentObject(taskListVM)
        
    }
        
    var cardListView: some View {
        Button { withAnimation { taskListVM.isListExpanded.toggle() } }
        label: {
        VStack(alignment: .leading) {
            HStack {
                Text(taskListVM.initializedTaskList.name)
                    .customFontCaptionBold()
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            Spacer()
            HStack {
                Text("\(taskListVM.initializedTaskList.completedTaskCount, specifier: "%.f")/\(taskListVM.initializedTaskList.totalTaskCount, specifier: "%.f")")
                    .customFontCaptionRegular()
                    .foregroundColor(.primary)
                Spacer()
            }
        }
        .padding()
        .frame(width: 120, height: 120)
        .background(
            Color("Surface")
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: Color("OuterShadow"), radius: 4, x: 2, y: 2)
                .shadow(color: Color("OuterGlare"), radius: 2, x: -2, y: -2)
        )
        .fullScreenCover(isPresented: $taskListVM.isListExpanded) {
            expandedListView
        }
        }
    }
    
    var expandedListView: some View {
        ZStack {
            NeumorphicBackground()
            VStack{
                listHeader
                taskProgressBar
                
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(taskListVM.initializedTaskList.list) { listItem in
                        HStack {
                            ListItem(listItem: listItem)
                                .padding(.horizontal, 2)
                                .animation(.default, value: 1)
                            Spacer()
                        }
                    }
                }
                Spacer()
                bottomButtons
            }
            .padding(.horizontal)
            .disabled(taskListVM.isShowingAddNewTaskSheet)
            
            ZStack {
                if taskListVM.isShowingAddNewTaskSheet {
                    AddTaskSheet(isShowingAddNewTaskSheet: $taskListVM.isShowingAddNewTaskSheet, AddTaskSheetVM: AddTaskSheetVM())
                        .transition(.move(edge: .bottom))
                }
            }
            .zIndex(3)
        }
    }
    
    var listHeader: some View {
        HStack {
            Button {
                withAnimation { taskListVM.isListExpanded.toggle() }
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .buttonStyle(.plain)
            Spacer()
            Text(taskListVM.initializedTaskList.name)
                .customFontHeadline()
                .foregroundColor(.primary)
                .padding(.trailing)
            Spacer()
        }
        .padding(.vertical)
    }
    
    var taskProgressBar: some View {
        VStack {
            ZStack(alignment: .leading) {
                ProgressBarSunkenBackground()
                if !taskListVM.initializedTaskList.list.isEmpty {
                    RoundedRectangle(cornerRadius: 10)
                        .fill( LinearGradient(colors: [Color("AccentStart"), Color("AccentEnd")], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .frame(
                            width: 316 * ((taskListVM.initializedTaskList.completedTaskCount) / (taskListVM.initializedTaskList.totalTaskCount)) ,
                            height: 9
                        )
                        .padding(taskListVM.initializedTaskList.completedTaskCount == 0 ? 0 : 8)
                        .background(
                            RoundedRectangle(cornerRadius: .infinity)
                                .fill(Color("Surface"))
                                .shadow(color: Color("OuterShadow"), radius: 2, x: 2, y: 2)
                                .shadow(color: Color("OuterGlare"), radius: 2, x: -2, y: -2)
                        )
                }
            }
            .frame(height: 24)
            
            HStack {
                Spacer()
                    .frame(width: 280)
                Text("\(taskListVM.initializedTaskList.completedTaskCount, specifier: "%.f")/\(taskListVM.initializedTaskList.totalTaskCount, specifier: "%.f")")
                    .customFontCaptionRegular()
                    .foregroundColor(.secondary)
            }
        }
        .frame(height: 50)
    }
    
    var bottomButtons: some View {
        HStack {
            if ((taskListVM.initializedTaskList.completedTaskCount == taskListVM.initializedTaskList.totalTaskCount) && (taskListVM.initializedTaskList.totalTaskCount > 0)) {
                Button {
                    taskListVM.clearTaskList()
                    taskListVM.resetTaskListCounters()
                } label: {
                    Text("clear list")
                        .customFontHeadline()
                        .foregroundColor(.primary)
                }
                .buttonStyle(.plain)
                .padding(.leading)
            }
            Spacer()
            Button {
                withAnimation { taskListVM.isShowingAddNewTaskSheet.toggle() }
            } label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
            }
            .buttonStyle(AddTaskButtonStyle())
            .padding()
        }
        .padding(.horizontal)
    }
    
} // struct


struct ProgressBarSunkenBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color("Surface"))
            .frame(width: 320, height: 15)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("OuterShadow"), lineWidth: 4)
                    .blur(radius: 4)
                    .offset(x: 2, y: 2)
                    .mask(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LinearGradient(colors: [Color.black, Color.clear], startPoint: .top, endPoint: .bottom))
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("InnerGlare"), lineWidth: 4)
                    .blur(radius: 4)
                    .offset(x: -2, y: -2)
                    .mask(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LinearGradient(colors: [Color.clear, Color("InnerGlare")], startPoint: .top, endPoint: .bottom))
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("OuterShadow"), lineWidth: 4)
                    .blur(radius: 4)
                    .offset(x: 2, y: 2)
                    .mask(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LinearGradient(colors: [Color("InnerShadow"), Color.clear], startPoint: .topLeading, endPoint: .bottomTrailing))
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("InnerGlare"), lineWidth: 4)
                    .blur(radius: 4)
                    .offset(x: -2, y: -2)
                    .mask(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LinearGradient(colors: [Color.clear, Color("InnerGlare")], startPoint: .topLeading, endPoint: .bottomTrailing))
                    )
            )
            .padding(2)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(colors: [Color("Surface"), Color("OuterGlare")], startPoint: .top, endPoint: .bottom))
            )
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TaskListView(list: TaskList(name: "Grocery List", list: [TaskItem(name: "Bananas", note: "All of them")], totalTaskCount: 1, completedTaskCount: 0))
        }
    }
}
