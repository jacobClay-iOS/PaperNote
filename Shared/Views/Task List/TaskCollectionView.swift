//
//  TaskCollectionView.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/2/22.
//

import SwiftUI

// MARK: remove horizontal padding on individual elements

struct TaskCollectionView: View {
    @StateObject var taskCollectionVM = TaskCollectionVM()
    @FocusState private var newTaskListFieldFocus: Bool
     
    var body: some View {
       
            VStack(spacing: 5) {
                HStack {
                    Text("Tasks")
                        .customFontHeadline()
                        .foregroundColor(.secondary)
                        
                    Spacer()
                } // HStack
                .padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(taskCollectionVM.collectionOfLists) { collectionListItem in
                            TaskListView(list: collectionListItem)
                                .transition(.scale(scale: 0.1))
                        } // ForEach
                        Button {
                            withAnimation {
                                taskCollectionVM.newListTitle = ""
                                taskCollectionVM.isShowingListTitleField.toggle()
                            }
                        } label: {
                            Image(systemName: "plus")
                                .font(.largeTitle)
                                .foregroundColor(.primary)
                        } // Button
                        .buttonStyle(AddListButtonStyle())
                    } // HStack
                    .padding()
                } // Scrollview
                .frame(height: 150)
            } // VStack
      
        .environmentObject(taskCollectionVM)
        .overlay {
            if taskCollectionVM.isShowingListTitleField {
                addListsheet
                    .transition(.move(edge: .bottom))
            }
        } // Overlay
    } // body
        
} // Struct

extension TaskCollectionView {
    
    private func addList() {
        let list = TaskList(name: taskCollectionVM.newListTitle)
        taskCollectionVM.addListToCollection(list)
        taskCollectionVM.isShowingListTitleField = false
    }
    
    private var addListsheet: some View {
        VStack {
            Spacer()
            VStack(spacing: 15) {
                HStack {
                    Spacer()
                    Text("New List")
                        .customFontHeadline()
                        .foregroundColor(.primary)
                        .padding(.leading)
                        .padding(.leading, 4)
                    Spacer()
                    Button {
                        withAnimation {
                            newTaskListFieldFocus = false
                            taskCollectionVM.isShowingListTitleField.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .overlay(
                                Rectangle()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.secondary.opacity(0.000001))
                            )
                    } // Button
                    .buttonStyle(.plain)
                } // HStack
                SunkenTextField(textField: TextField("title", text: $taskCollectionVM.newListTitle))
                    .customFontBodyRegular()
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .focused($newTaskListFieldFocus)
                    .onSubmit {
                        withAnimation {
                            addList()
                        }
                    } // TextField
                    .submitLabel(.done)
            } // VStack
            .padding()
            .background(
                Color("Surface")
                    .shadow(color: Color("OuterGlare"), radius: 1, y: -4)
            )
        } // Vstack
        
        .ignoresSafeArea(.container, edges: .bottom)
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                newTaskListFieldFocus = true
            }
        } // Task
    }
}

struct TaskCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCollectionView()
    }
}
