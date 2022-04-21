//
//  ListSettingsView.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/15/22.
//

import SwiftUI

struct ListSettingsView: View {
    @EnvironmentObject var taskListVM: TaskListVM
    @EnvironmentObject var taskCollectionVM: TaskCollectionVM
    @FocusState private var settingTextFieldFocus
    @State private var currentDragOffsetY: CGFloat = 0
    @Environment(\.scenePhase) private var scenePhase
    var list: TaskList
    
    var body: some View {
        
        VStack {
            Spacer()
            VStack(spacing: 10) {
                DragGestureTab()
                header
                    .padding(.bottom, 5)
                
                settingsItems
            }
            .padding(.horizontal)
            .padding(.bottom)
            .padding(.bottom)
            .background(Color("Surface"))
            .customCornerRadius(25, corners: [.topRight, .topLeft])
            .shadow(color: Color("OuterGlare"), radius: 0.5, y: -1)
            .shadow(color: Color("OuterGlare"), radius: 0.5, y: -1)
            .shadow(color: Color("OuterGlare"), radius: 0.5, y: -1)
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .offset(y: currentDragOffsetY)
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation(.spring()) {
                        currentDragOffsetY = value.translation.height
                    }
                }
                .onEnded { value in
                    withAnimation(.spring()) {
                        if currentDragOffsetY > 40 && settingTextFieldFocus == false {
                            withAnimation {
                                taskListVM.isShowingSettingsSheet = false
                            }
                        } else if currentDragOffsetY > 40 && settingTextFieldFocus == true {
                            settingTextFieldFocus = false
                        }
                        currentDragOffsetY = 0
                    }
                }
        )
        
        // scene phase isnt working
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                
            } else if newPhase == .inactive {
                dismissSettingsSheet()
                
            } else if newPhase == .background {
                dismissSettingsSheet()
            }
        }
        
    }
}

extension ListSettingsView {
    
    func dismissSettingsSheet() {
        settingTextFieldFocus = false
        taskListVM.isShowingSettingsSheet = false
        currentDragOffsetY = 0
    }
    
    private var header: some View {
        HStack {
            Text("Settings")
                .customFontHeadline()
                .foregroundColor(.primary)
            Spacer()
        }
    }
    
    private var settingsItems: some View {
        VStack {
            HStack {
                Text("Title: ")
                    .customFontBodyRegular()
                    .foregroundColor(.primary)
                TextField("list name", text: $taskListVM.initializedTaskList.name)
                    .focused($settingTextFieldFocus)
                    .customFontBodyRegular()
                    .foregroundColor(.primary)
                    .submitLabel(.done)
                    .onSubmit { settingTextFieldFocus = false }
                    
                Spacer()
            }
         
            HStack {
                ColorPicker(selection: $taskListVM.initializedTaskList.customAccentColor, supportsOpacity: false) {
                    Text("Accent color:")
                        .customFontBodyRegular()
                        .foregroundColor(.primary)
                }
                .frame(width: 165)
                Spacer()
            }

            
            Button {
                taskListVM.isShowingDeleteListAlert.toggle()
            } label: {
                Text("Delete List")
                    .customFontHeadline()
                    .foregroundColor(.red)
            }
            .buttonStyle(.plain)
            .padding(.top, 20)
            .alert(isPresented: $taskListVM.isShowingDeleteListAlert) {
                Alert(title: Text("Are you sure?"), message: Text("This will permanently remove the list from your collection"), primaryButton: .destructive(Text("Delete"), action: {
                    taskListVM.isShowingSettingsSheet.toggle()
                    taskListVM.isListExpanded.toggle()
                    withAnimation {
                        taskCollectionVM.deleteListFromCollection(list)
                    }
                    
                }), secondaryButton: .cancel())
            }
        }
    }
}

struct ListSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ListSettingsView(list: TaskList(name: "Grocery List", customAccentColor: Color.blue))
            .environmentObject(TaskListVM())
            .preferredColorScheme(.dark)
    }
}
