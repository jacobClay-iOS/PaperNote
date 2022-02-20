//
//  TaskListView.swift
//  PaperNote
//
//  Created by Jacob Clay on 2/19/22.
//

import SwiftUI

struct TaskListView: View {
    
    @State var taskList: [TaskItem] = []
    @State var totalTasks: Double = 0
    @State var completedTasks: Double = 0
    @State var isShowingAddTaskSheet = false
    @State var listTitle = "Title"
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            NeumorphicBackground()
            VStack{
                header
                progressBar
                Spacer()
                bottomButtons
            }
            .padding(.horizontal)
            
        }
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
            Text(listTitle)
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
                
                if !taskList.isEmpty {
                    RoundedRectangle(cornerRadius: 10)
                        .fill( LinearGradient(colors: [Color("AccentStart"), Color("AccentEnd")], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .frame(
                            width: 316 * ((completedTasks) / (totalTasks)) ,
                            height: 9
                        )
                        .padding(completedTasks == 0 ? 0 : 8)
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
                Text("\(completedTasks, specifier: "%.f")/\(totalTasks, specifier: "%.f")")
                    .customFontCaptionRegular()
                    .foregroundColor(.secondary)
            }
        }
        .frame(height: 50)
        
    }
    
    var bottomButtons: some View {
        HStack {
            if ((completedTasks == totalTasks) && (totalTasks > 0)) {
                Button {
                    //            viewModel.clearTodoList()
                    //            viewModel.resetTodoListCounters()
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
        TaskListView()
            .preferredColorScheme(.dark)
    }
}
