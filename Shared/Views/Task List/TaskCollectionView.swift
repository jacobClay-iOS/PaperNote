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
        ZStack {
            NeumorphicBackground()
            VStack(spacing: 0) {
                HStack {
                    Text("Lists")
                        .customFontHeadline()
                        .foregroundColor(.secondary)
                    Spacer()
                } // HStack
                .padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(taskCollectionVM.collectionOfLists) { collectionListItem in
                            TaskListView(list: collectionListItem)
                          
                        } // ForEach
                        Button {
                            withAnimation {
                                taskCollectionVM.isShowingListTitleField.toggle()
                            }
                        } label: {
                            Image(systemName: "plus")
                                .font(.largeTitle)
                                .foregroundColor(.primary)
                        } // Button
                        .buttonStyle(AddListButtonStyle())
                    } // LazyHStack
                    .padding(.horizontal)
                } // Scrollview
                .frame(height: 150)
            } // VStack
        } // ZStack
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
                    Spacer()
                    Button {
                        withAnimation {
                            newTaskListFieldFocus = false
                            taskCollectionVM.isShowingListTitleField.toggle()
                            taskCollectionVM.newListTitle = ""
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    } // Button
                } // HStack
                SunkenTextField(textField: TextField("title", text: $taskCollectionVM.newListTitle))
                    .customFontBodyRegular()
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .focused($newTaskListFieldFocus)
                    .onSubmit {
                        addList()
                        taskCollectionVM.newListTitle = ""
                    } // TextField
                    .submitLabel(.done)
            } // VStack
            .padding()
            .background(
                Color("Surface")
                    .shadow(color: Color("OuterShadow"), radius: 4, x: 4, y: 4)
                    .shadow(color: Color("OuterGlare"), radius: 2, x: -2, y: -2)
            )
        } // Vstack
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
