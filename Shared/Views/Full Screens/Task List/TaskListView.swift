//
//  TaskListView.swift
//  PaperNote
//
//  Created by Jacob Clay on 2/19/22.
//

import SwiftUI

struct TaskListView: View {
    @StateObject var taskListVM = TaskListVM()
    @State var isShowingAddTaskSheet = false
    @Environment(\.presentationMode) var presentationMode
    
    @FocusState private var todoFieldFocus: activeField?
    
    enum activeField {
        case primaryTask
        case notesTextEditor
    }
    
    var body: some View {
    
        
        ZStack {
            NeumorphicBackground()
            VStack{
                header
                progressBar
                
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(taskListVM.taskList) { listItem in
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
            
            ZStack {
                if isShowingAddTaskSheet {
                    AddTaskSheet(isShowingAddTaskSheet: $isShowingAddTaskSheet, AddTaskSheetVM: AddTaskSheetVM())
                        .padding(.top, 150)
                        .transition(.move(edge: .bottom))
                }
                    
            }
            .zIndex(2)
           
        }
        .environmentObject(taskListVM)
        .navigationBarHidden(true)
    }
    
    var header: some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .buttonStyle(.plain)
            Spacer()
            Text(taskListVM.listTitle)
                .customFontHeadline()
                .foregroundColor(.primary)
                .padding(.trailing)
            Spacer()
        }
        .padding(.vertical)
    }
    
    var progressBar: some View {
        VStack {
            ZStack(alignment: .leading) {
                ProgressBarBackground
                
                if !taskListVM.taskList.isEmpty {
                    RoundedRectangle(cornerRadius: 10)
                        .fill( LinearGradient(colors: [Color("AccentStart"), Color("AccentEnd")], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .frame(
                            width: 316 * ((taskListVM.completedTasks) / (taskListVM.totalTasks)) ,
                            height: 9
                        )
                        .padding(taskListVM.completedTasks == 0 ? 0 : 8)
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
                Text("\(taskListVM.completedTasks, specifier: "%.f")/\(taskListVM.totalTasks, specifier: "%.f")")
                    .customFontCaptionRegular()
                    .foregroundColor(.secondary)
            }
        }
        .frame(height: 50)
        
    }
    
    var bottomButtons: some View {
        HStack {
            if ((taskListVM.completedTasks == taskListVM.totalTasks) && (taskListVM.totalTasks > 0)) {
                Button {
                    taskListVM.clearTaskList()
                    taskListVM.resetTaskListCounters()
                    print("balls")
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
                withAnimation {
                    isShowingAddTaskSheet.toggle()
                }
                
                //                { sheetType = .newTask }
            } label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
            }
            .buttonStyle(AddTaskButtonStyle())
            .padding()
            //            .sheet(item: $sheetType) { $0 }
        }
        .padding(.horizontal)
    }
    

    
}



var ProgressBarBackground: some View {
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






struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
      
        VStack {
            TaskListView()
                .environmentObject(TaskListVM())
                .preferredColorScheme(.dark)
        }
        
    }
}
