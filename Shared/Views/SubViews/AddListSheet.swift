//
//  AddListSheet.swift
//  PaperNote
//
//  Created by Jacob Clay on 2/27/22.
//

import SwiftUI

struct AddListSheet: View {
    @EnvironmentObject var usersTaskListCollectionVM: UsersTaskListCollectionVM
    @Binding var isShowingListTitleField: Bool
    @State var listTitle = ""
    @FocusState private var taskListFieldFocus: Bool
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 15) {
                HStack {
                    Spacer()
                    Text("New List")
                        .customFontHeadline()
                        .foregroundColor(.primary)
                        .padding(.trailing)
                    Spacer()
                    Button {
                        withAnimation {
                            taskListFieldFocus = false
                            isShowingListTitleField.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                }
                SunkenTextField(textField: TextField("title", text: $listTitle))
                    .focused($taskListFieldFocus)
                    .onSubmit {
                        addList()
                    }
            }
            .padding()
            .background(
                Color("Surface")
                    .shadow(color: Color("OuterShadow"), radius: 4, x: 2, y: 2)
                    .shadow(color: Color("OuterGlare"), radius: 2, x: -2, y: -2)
            )
            
        }
        
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                taskListFieldFocus = true
            }
        }

    }
}

extension AddListSheet {
    func addList() {
        let list = TaskList(name: listTitle)
        usersTaskListCollectionVM.addListToCollection(list)
        isShowingListTitleField = false
    }
}

struct AddListSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddListSheet(isShowingListTitleField: .constant(true))
    }
}
