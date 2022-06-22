//
//  TaskCollectionView.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/2/22.
//

import SwiftUI

// MARK: remove horizontal padding on individual elements

struct TaskCollectionView: View {
//    @StateObject var taskCollectionVM = TaskCollectionVM()
    @FocusState private var newTaskListFieldFocus: Bool
    @EnvironmentObject var taskCollectionVM: TaskCollectionVM
    @Environment(\.scenePhase) var scenePhase
    @Binding var startingOffsetY: CGFloat
    @Binding var currentDragOffsetY: CGFloat
    @Binding var hiddenOffsetY: CGFloat
    
    
    var body: some View {
        
        ZStack {
            VStack {
                DragGestureTab()
                VStack(spacing: 5) {
                    header
                        .padding(.horizontal)
                    if taskCollectionVM.isShowingListTitleField {
                        addListsheet
                    } else {
                        scrollingCollectionOfLists
                    }
                }
                .padding(.top, 5)
                Spacer()
                footer
            }
            .frame(maxWidth: .infinity)
            .background(Color("Surface"))
            .cornerRadius(25)
            .shadow(color: Color("OuterGlare"), radius: 0.5, y: -1)
            .shadow(color: Color("OuterGlare"), radius: 0.5, y: -1)
            .shadow(color: Color("OuterGlare"), radius: 0.5, y: -1)
        }
//        .environmentObject(taskCollectionVM)
        .ignoresSafeArea(edges: .bottom)
        .offset(y: taskCollectionVM.isShowingListTitleField ? 0 : startingOffsetY)
        .offset(y: taskCollectionVM.isShowingListTitleField ? UIScreen.main.bounds.height * 0.35 : currentDragOffsetY)
        .offset(y: taskCollectionVM.isShowingListTitleField ? 0 : hiddenOffsetY)
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation {
                        currentDragOffsetY = value.translation.height
                    }
                }
                .onEnded{ value in
                    withAnimation {
                        if (currentDragOffsetY > 40) && (!taskCollectionVM.isShowingListTitleField)  {
                            hiddenOffsetY = UIScreen.main.bounds.height * 0.41
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
    }
}

extension TaskCollectionView {
    
    private func addList() {
        let list = TaskList(name: taskCollectionVM.newListTitle)
        taskCollectionVM.addListToCollection(list)
    }

    
    private var header: some View {
        HStack {
            Text(taskCollectionVM.isShowingListTitleField ? "New List" : "Tasks")
                .customFontHeadline()
                .foregroundColor(.primary)
            Spacer()
        }
    }
    
    private var footer: some View {
        Image("NeumorphicText")
            .resizable()
            .scaledToFit()
            .frame(width: 200)
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
            .task { DispatchQueue.main.async { newTaskListFieldFocus = true } }
    }
}

struct TaskCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCollectionView(startingOffsetY: .constant(UIScreen.main.bounds.height * 0.45), currentDragOffsetY: .constant(0), hiddenOffsetY: .constant(0))
    }
}
