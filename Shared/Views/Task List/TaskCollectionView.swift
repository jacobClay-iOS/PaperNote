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
    
    @Environment(\.scenePhase) var scenePhase
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.65
    @State var currentDragOffsetY: CGFloat = 0
    @State var hiddenOffsetY: CGFloat = 0
    
    
    var body: some View {
        
        ZStack {
            VStack {
                dragGestureTab
                VStack(spacing: 5) {
                    header
                        .padding(.horizontal)
                    if taskCollectionVM.isShowingListTitleField {
                        addListsheet
                    } else {
                        scrollingCollectionOfLists
                    }
                    
                } // VStack
                .padding(.top, 5)
                Spacer()
                footer
            } // VStack
            .frame(maxWidth: .infinity)
            .background(
                Color("Surface")
            ) // ZStack
            .cornerRadius(30)
            .shadow(color: Color("OuterGlare"), radius: 1, x: 0, y: -1)
            .shadow(color: Color("OuterGlare"), radius: 0.5, x: 0, y: -1)
            .shadow(color: Color("OuterGlare"), radius: 0.5, x: 0, y: -1)
        }
        .environmentObject(taskCollectionVM)
        .ignoresSafeArea(edges: .bottom)
        .offset(y: taskCollectionVM.isShowingListTitleField ? 0 : startingOffsetY)
        .offset(y: taskCollectionVM.isShowingListTitleField ? UIScreen.main.bounds.height * 0.35 : currentDragOffsetY)
        .offset(y: taskCollectionVM.isShowingListTitleField ? 0 : hiddenOffsetY)
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation(.spring()) {
                        currentDragOffsetY = value.translation.height
                    }
                }
                .onEnded{ value in
                    withAnimation(.spring()) {
                        if (currentDragOffsetY > 40) && (!taskCollectionVM.isShowingListTitleField)  {
                            hiddenOffsetY = UIScreen.main.bounds.height * 0.21
                        } else if hiddenOffsetY != 0 && currentDragOffsetY < -40 {
                            hiddenOffsetY = 0
                        } else if (taskCollectionVM.isShowingListTitleField) && (currentDragOffsetY > 40) {
                            newTaskListFieldFocus = false
                            taskCollectionVM.isShowingListTitleField = false
                            hiddenOffsetY = 0
                        }
                        currentDragOffsetY = 0
                    }
                }
        )
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                
            } else if newPhase == .inactive {
                currentDragOffsetY = 0
            } else if newPhase == .background {
                
            }
        }
    } // body
} // Struct

extension TaskCollectionView {
    
    private func addList() {
        let list = TaskList(name: taskCollectionVM.newListTitle)
        taskCollectionVM.addListToCollection(list)
    }
    
    private var dragGestureTab: some View {
        RoundedRectangle(cornerRadius: .infinity)
            .frame(width: 40, height: 5)
            .foregroundColor(.secondary)
            .padding(.top)
    }
    
    private var header: some View {
        HStack {
            Text(taskCollectionVM.isShowingListTitleField ? "New List" : "Tasks")
                .customFontHeadline()
                .foregroundColor(.secondary)
            Spacer()
        }
    }
    
    private var footer: some View {
        Text("peek-a-boo ;)")
            .foregroundColor(.secondary)
            .customFontCaptionLight()
    }
    
    private var scrollingCollectionOfLists: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(taskCollectionVM.collectionOfLists) { collectionListItem in
                    TaskListView(list: collectionListItem)
                        .transition(.scale(scale: 0.1))
                } // ForEach
                Button {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    withAnimation(.spring()) {
                        taskCollectionVM.newListTitle = ""
                        taskCollectionVM.isShowingListTitleField.toggle()
                    } // WithAnimation
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
    }
    
    private var addListsheet: some View {
            VStack {
                SunkenTextField(textField: TextField("title", text: $taskCollectionVM.newListTitle))
                    .customFontBodyRegular()
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .focused($newTaskListFieldFocus)
                    .onSubmit {
                        if !taskCollectionVM.newListTitle.isEmpty {
                            withAnimation(.spring()) {
                                taskCollectionVM.isShowingListTitleField = false
                                addList()
                            }
                        } else {
                            withAnimation(.spring()) {
                                taskCollectionVM.isShowingListTitleField = false
                            }
                        }
                    } // TextField
                    .submitLabel(.done)
                Spacer()
            } // VStack
            .padding()
            .frame(height: 150)
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
