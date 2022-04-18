//
//  TaskListView.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/2/22.
//

import SwiftUI

struct TaskListView: View {
    @StateObject var taskListVM = TaskListVM()
    @EnvironmentObject var taskCollectionVM: TaskCollectionVM

    var list: TaskList

    
    var body: some View {
        ZStack {
            cardListView
                .fullScreenCover(isPresented: $taskListVM.isListExpanded) {
                    expandedListView
                }
        } // ZStack
        .onAppear(perform: {
            taskListVM.initializedTaskList.name = list.name
            taskListVM.initializedTaskList.list = list.list
            taskListVM.initializedTaskList.totalTaskCount = list.totalTaskCount
            taskListVM.initializedTaskList.completedTaskCount = list.completedTaskCount
            taskListVM.initializedTaskList.customAccentColor = list.customAccentColor
        }) // OnAppear
        .environmentObject(taskListVM)
    } // Body
} // Struct

extension TaskListView {
    
    private var cardListView: some View {
        Button {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            withAnimation { taskListVM.isListExpanded.toggle() }
        }
        label: {
            listButtonLabel
        }
        .buttonStyle(AddListButtonStyle())
    }
    
    private var expandedListView: some View {
        ZStack {
            NeumorphicBackground()
                VStack{
                    listHeader
                    taskProgressBar
                    ScrollView {
                        
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(taskListVM.initializedTaskList.list) { listItem in
                                HStack {
                                    ListItemView(listItem: listItem)
                                        .padding(.horizontal, 2)
                                        .animation(.default, value: 1)
                                    Spacer()
                                }
                            }
                        }
                        .padding(.top, 2)
                    }
                    
                    Spacer()
                    bottomButtons
                }
                
                .padding(.horizontal)
                .disabled(taskListVM.isShowingASheet)
                .overlay(alignment: .center) {
                    if taskListVM.isShowingASheet {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.white.opacity(0.00001))
                            .onTapGesture {
                                withAnimation {
                                    taskListVM.dismissAllSheets()
                                }
                            }
                    }
                    
                }
            
            ZStack {
                if taskListVM.isShowingAddNewTaskSheet {
                    AddTaskSheetView(isShowingAddNewTaskSheet: $taskListVM.isShowingAddNewTaskSheet, isShowingEditTaskSheet: $taskListVM.isShowingEditTaskSheet)
                        .transition(.move(edge: .bottom))
                }
            }
            .zIndex(2)
            
            ZStack {
                if taskListVM.isShowingEditTaskSheet {
                    AddTaskSheetView(isShowingAddNewTaskSheet: $taskListVM.isShowingAddNewTaskSheet, isShowingEditTaskSheet: $taskListVM.isShowingEditTaskSheet)
                        .transition(.move(edge: .bottom))
                }
            }
            .zIndex(2)
            
            ZStack {
                if taskListVM.isShowingSettingsSheet {
                    ListSettingsView(list: list)
                        .transition(.move(edge: .bottom))
                }
            }
            .zIndex(2)
            
            
            
            
        }
        
    }
    
    private var listHeader: some View {
        HStack {
            Button {
                withAnimation { taskListVM.isListExpanded.toggle() }
            } label: {
                
                Image(systemName: "chevron.backward")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .overlay(
                        Rectangle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.secondary.opacity(0.000001))
                    )
            }
            .buttonStyle(.plain)
            Spacer()
            Text(taskListVM.initializedTaskList.name)
                .customFontHeadline()
                .foregroundColor(.primary)
                .lineLimit(1)
                .padding(.horizontal)
                
            Spacer()
            Button {
                withAnimation { taskListVM.isShowingSettingsSheet.toggle() }
            } label: {
                Image(systemName: "ellipsis")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .overlay(
                        Rectangle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.secondary.opacity(0.000001))
                    )
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical)
    }
    
    private var listButtonLabel: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color.gray, lineWidth: 4)
                .opacity(0.1)
                .padding(10)
            RoundedRectangle(cornerRadius: 12)
                .trim(from: taskListVM.percentageCompleted, to: 1)
                .stroke(taskListVM.initializedTaskList.customAccentColor, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .opacity(taskListVM.initializedTaskList.list.isEmpty ? 0.0 : 1)
                .padding(12)
            VStack(alignment: .leading) {
                HStack {
                    Text(taskListVM.initializedTaskList.name)
                        .customFontCaptionMedium()
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                Spacer()
                HStack {
                    Text(taskListVM.allTasksCompleted ? "Complete" : "\(taskListVM.initializedTaskList.completedTaskCount, specifier: "%.f")/\(taskListVM.initializedTaskList.totalTaskCount, specifier: "%.f")")
                        .customFontCaptionLight()
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            .padding(25)
        }
    }
    
    private var taskProgressBar: some View {
        VStack {
            ZStack(alignment: .leading) {
                ProgressBarSunkenBackground()
                if !taskListVM.initializedTaskList.list.isEmpty {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(taskListVM.initializedTaskList.customAccentColor)
                        
                        .frame(
                            width: 316 * ((taskListVM.initializedTaskList.completedTaskCount) / (taskListVM.initializedTaskList.totalTaskCount)) ,
                            height: 9
                        )
                        .padding(taskListVM.initializedTaskList.completedTaskCount == 0 ? 0 : 7)
                        .background(
                            RoundedRectangle(cornerRadius: .infinity)
                                .fill(Color("Surface"))
                                .shadow(color: Color("OuterGlare"), radius: 0.5, x: -0.5, y: -0.5)
                                .shadow(color: Color("OuterGlare"), radius: 0.5, x: -0.5, y: -0.5)
                                .shadow(color: Color("OuterGlare"), radius: 0.5, x: 0, y: -0.5)
                                .shadow(color: Color("OuterShadow"), radius: 3, x: 2, y: 3)
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
        .opacity(taskListVM.isShowingASheet ? 0.5 : 1.0)
    }
    
    private var bottomButtons: some View {
            HStack {
                if taskListVM.allTasksCompleted {
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
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    withAnimation {
                        taskListVM.isShowingAddNewTaskSheet.toggle()
                    }
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
}

struct ProgressBarSunkenBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color("Surface"))
            .frame(width: 320, height: 15)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("OuterShadow"), lineWidth: 3)
                    .blur(radius: 3)
                    .offset(x: 2, y: 2)
                    .mask(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LinearGradient(colors: [Color.black, Color.clear], startPoint: .top, endPoint: .bottom))
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("OuterShadow"), lineWidth: 3)
                    .blur(radius: 3)
                    .offset(x: 2, y: 2)
                    .mask(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LinearGradient(colors: [Color("InnerShadow"), Color.clear], startPoint: .topLeading, endPoint: .bottomTrailing))
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("InnerGlare"), lineWidth: 1)
                    .blur(radius: 1)
                    .offset(x: -1, y: -1)
                    .mask(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LinearGradient(colors: [Color.clear, Color("InnerGlare")], startPoint: .top, endPoint: .bottom))
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("InnerGlare"), lineWidth: 1)
                    .blur(radius: 1)
                    .offset(x: -1, y: -1)
                    .mask(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LinearGradient(colors: [Color.clear, Color("InnerGlare")], startPoint: .topLeading, endPoint: .bottomTrailing))
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("InnerGlare"), lineWidth: 1)
                    .blur(radius: 1)
                    .offset(x: -1, y: -1)
                    .mask(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LinearGradient(colors: [Color.clear, Color("InnerGlare")], startPoint: .topLeading, endPoint: .bottomTrailing))
                    )
            )
            .padding(1)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(colors: [Color("Surface"), Color("OuterGlare")], startPoint: .top, endPoint: .bottom))
            )
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TaskListView(list: TaskList(name: "Grocery List", list: [TaskItem(name: "Bananas", isTaskCompleted: true, note: "All of them")], totalTaskCount: 1, completedTaskCount: 1))
                .preferredColorScheme(.dark)
                
        }
    }
}
